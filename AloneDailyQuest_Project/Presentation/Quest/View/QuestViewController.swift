//
//  QuestViewController.swift
//  AloneDailyQuest-QuestTestUI
//
//  Created by 오정석 on 20/12/2023.
//

import UIKit

final class QuestViewController: UIViewController{
    
    private let questView = QuestView()
    private let viewModel: QuestViewModel
    private var questList: [QuestInfo] = []
    private var deleteQuestInfo: QuestInfo? = nil
    private var userExperience: Int = 0
    
    weak var delegate: UITableViewDelegate? = nil
    
    var index: IndexPath?
    var todayExp = 0
    
    init(viewModel: QuestViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = questView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questView.tableView.dataSource = self
        configureUI()
        bindViewModel()
    }
    
    func configureUI() {
        questView.plusButton.addTarget(self, action: #selector(addQuest), for: .touchUpInside)
    }
    
    func bindViewModel() {
        let input = QuestViewModel.Input(viewDidLoad: Observable<Void>(()),
                                         deleteTrigger: Observable(deleteQuestInfo),
                                         experienceTrigger: Observable(userExperience), 
                                         qeusetViewEvent: questView.tabView.qeusetViewEvent,
                                         rankViewEvent: questView.tabView.rankiViewEvent)
        let output = viewModel.transform(input: input)
        output.questList.bind { questList in
            self.questList = questList
        }
        output.experience.bind { experience in
            self.userExperience = experience
        }
    }
    
    @objc func addQuest() {
//        delegate?.addQuest()
    }
    
    @objc func updateQuest(sender: UIButton) {
        guard let index = index else { return }
//        delegate?.updateQuest(indexPath: sender.tag)
    }
    
    @objc func deleteQuest(sender: UIButton) {
        let alert = UIAlertController(title: "퀘스트 삭제", message: "정말로 퀘스트를 삭제하시겠습니까", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            guard let indexPath = self.index else { return }
            
            let questData = self.filterQuest()
            if questData[sender.tag].completed {
                self.todayExp -= 20
            }
            self.deleteQuestInfo = questData[sender.tag]
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension QuestViewController: UITableViewDataSource, UITableViewDelegate {
    func currentDayOfWeek() -> Int {
        let today = Calendar.current.component(.weekday, from: Date())
        return (today + 5) % 7
    }

    func filterQuest() -> [QuestInfo] {
        return questList.filter{ $0.selectedDate[currentDayOfWeek()] || Calendar.current.component(.weekday, from:  $0.date) == Calendar.current.component(.weekday, from: Date()) }
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
        print(cell.questData ?? [])
        var completedCheck = cell.questData!.completed
        
        // 테이블뷰 시작시 UI 기본 설정
        cell.repeatday.text = cell.questData?.repeatDay
        cell.questTitle.text = cell.questData?.quest
        
        index = indexPath
    
        if todayExp < 100 {
            cell.expAmount.text = "보상 : 20xp"
        } else {
            cell.expAmount.text = "보상 : - "
        }

        if cell.questData!.completed {
            cell.questImage.image = UIImage(named: "img_quest_completed")
            cell.questTitle.textColor = UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00)
            cell.expAmount.textColor = UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00)
            cell.repeatday.textColor = UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00)
            cell.completeButton.setTitle("미완료하기", for: .normal)
            cell.completeButton.setTitleColor(UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00), for: .normal)
        } else {
            cell.questImage.image = UIImage(named: "img_quest_ing")
            cell.questTitle.textColor = .black
            cell.expAmount.textColor = .black
            cell.repeatday.textColor = .black
            cell.completeButton.setTitle("완료하기", for: .normal)
            cell.completeButton.setTitleColor(.black, for: .normal)
        }
        cell.updateButton.addTarget(self , action: #selector(updateQuest), for: .touchUpInside)
        cell.updateButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteQuest), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        cell.completeButtonPressed = { [weak self] (senderCell) in
            completedCheck.toggle()
            completedToggle()
            toggleExpAdd()
            tableView.reloadData()
        }
        
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

