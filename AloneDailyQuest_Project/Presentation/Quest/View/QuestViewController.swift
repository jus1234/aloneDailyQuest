//
//  QuestViewController.swift
//  AloneDailyQuest-QuestTestUI
//
//  Created by 오정석 on 20/12/2023.
//

import UIKit

import RxSwift
import RxCocoa

final class QuestViewController: UIViewController{
    private var disposeBag = DisposeBag()
    
    private let questView: QuestView = QuestView()
    private let viewModel: QuestViewModel
    private lazy var questList: [QuestInfo] = []
    private lazy var deleteQuestInfo: QuestInfo? = nil
    private lazy var userExperience: Int = UserDefaults.standard.integer(forKey: "experince")
    private lazy var userInfo: UserInfo? = nil
    
    private lazy var input = QuestViewModel.Input(
        viewWillAppear: rx.viewWillAppear,
        deleteQuestEvent: PublishRelay(),
        qeusetViewEvent: questView.tabView.questButton.rx.tap,
        rankViewEvent: questView.tabView.rankListButton.rx.tap,
        profileViewEvent: questView.tabView.profileButton.rx.tap,
        didPlusButtonTap: questView.plusButton.rx.tap,
        updateQuestEvent: PublishRelay(),
        completeQuestEvent: PublishRelay())
    
    var index: IndexPath?
    var todayExp = 0
    
    init(viewModel: QuestViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questView.tableView.dataSource = self
        questView.tableView.delegate = self
        view = questView
        setupProfile()
        bindOutput()
    }
    
    private func setupProfile() {
        let user = UserInfo(nickName: UserDefaults.standard.string(forKey: "nickName")!,
                 experience: UserDefaults.standard.integer(forKey: "experience"))
        questView.profileBoxView.configureLabel(nickName: user.fetchNickName(), level: String(user.fetchLevel()))
        questView.profileBoxView.updateExperienceBar(currentExp: user.fetchExperience() % 10)
    }
    
    func bindOutput() {
        let output = viewModel.transform(input: input)
        
        output.userInfo
            .asDriver(onErrorJustReturn: UserInfo(nickName: "-", experience: 0))
            .drive(with: self) { owner, user in
                guard
                    let nickName = user?.fetchNickName(),
                    let level = user?.fetchLevel(),
                    let experience = user?.fetchExperience()
                else {
                    return
                }
                owner.questView.profileBoxView.configureLabel(nickName: nickName, level: String(level))
                owner.questView.profileBoxView.updateExperienceBar(currentExp: experience)
            }
            .disposed(by: disposeBag)
        
        output.questList
            .asDriver(onErrorJustReturn: [])
            .drive(with: self) { owner, quests in
                owner.questList = quests
                owner.reload()
            }
            .disposed(by: disposeBag)
        
        output.errorMessage
            .asDriver(onErrorJustReturn: "")
            .drive(with: self) { owner, error in
                owner.completedAlert(message: error)
            }
            .disposed(by: disposeBag)
    }
    
    @objc func updateQuest(sender: UIButton) {
        let questData = self.filterQuest()
        let quest = questData[sender.tag]
        input.updateQuestEvent.accept(quest)
    }
    
    @objc func deleteQuest(sender: UIButton) {
        let alert = UIAlertController(title: "퀘스트 삭제", message: "정말로 퀘스트를 삭제하시겠습니까", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { [weak self] _ in
            guard let questData = self?.filterQuest() else {
                return
            }
            if questData[sender.tag].completed {
                self?.todayExp -= 20
            }
            self?.input.deleteQuestEvent.accept(questData[sender.tag])
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func completeQuest(sender: UIButton) {
        let questData = self.filterQuest()
        var questInfo = questData[sender.tag]
        questInfo.completed = true
        input.completeQuestEvent.accept(questInfo)
    }
}

extension QuestViewController: UITableViewDataSource, UITableViewDelegate {
    func currentDayOfWeek() -> Int {
        let today = Calendar.current.component(.weekday, from: Date())
        return (today + 5) % 7
    }

    func filterQuest() -> [QuestInfo] {
        return questList.filter{ $0.selectedDate[currentDayOfWeek()] }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = filterQuest().count
        return count
    }
    
    func reload() {
        questView.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestCell", for: indexPath) as! QuestCell
        let questData = filterQuest()
        cell.questData = questData[indexPath.row]
        let completedCheck = cell.questData!.completed
        // 테이블뷰 시작시 UI 기본 설정
        cell.repeatday.text = cell.questData?.repeatDay
        cell.questTitle.text = cell.questData?.quest
        
        index = indexPath
    
        if todayExp < 100 {
            cell.expAmount.text = "보상 : 1xp"
        } else {
            cell.expAmount.text = "보상 : - "
        }

        if cell.questData!.completed {
            cell.questImage.image = UIImage(named: "img_quest_completed")
            cell.questTitle.textColor = UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00)
            cell.expAmount.textColor = UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00)
            cell.repeatday.textColor = UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00)
            cell.completeButton.setTitle("완료", for: .normal)
            cell.completeButton.setTitleColor(UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00), for: .normal)
            cell.completeButton.isEnabled = false
        } else {
            cell.questImage.image = UIImage(named: "img_quest_ing")
            cell.questTitle.textColor = .black
            cell.expAmount.textColor = .black
            cell.repeatday.textColor = .black
            cell.completeButton.setTitle("완료하기", for: .normal)
            cell.completeButton.setTitleColor(.black, for: .normal)
            cell.completeButton.isEnabled = true
        }
        
        cell.updateButton.addTarget(self , action: #selector(updateQuest), for: .touchUpInside)
        cell.updateButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteQuest), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        cell.completeButton.addTarget(self, action: #selector(completeQuest), for: .touchUpInside)
        cell.completeButton.tag = indexPath.row
         
        func completedToggle() {
            if var questData = cell.self.questData {
                questData.completed = completedCheck
                tableView.reloadData()
            }
        }
        
        func toggleExpAdd() {
            if cell.questData!.completed {
                self.userExperience = -20
                todayExp -= 20
            } else {
                self.userExperience = 20
                todayExp += 20
            }
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

