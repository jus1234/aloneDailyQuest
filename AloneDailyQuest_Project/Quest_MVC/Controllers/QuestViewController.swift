//
//  QuestViewController.swift
//  AloneDailyQuest-QuestTestUI
//
//  Created by 오정석 on 20/12/2023.
//

import UIKit

final class QuestViewController: UIViewController{
    
    // 모델(저장 데이터를 관리하는 코어데이터)
    var coreManager: CoreDataManager? = nil
    private let questView = QuestView()
    weak var delegate: delegateViewController? = nil
    weak var delegate2: UITableViewDelegate? = nil
    
    let questManager = CoreDataManager.shared
    
    
    var text: String = ""
    
    var index: IndexPath?
    
    
    // 초기화 경험치
    var todayExp = 0
    
    
    override func loadView() {
        self.view = questView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questView.tableView.dataSource = self
        
        setUp()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setUp() {
        questView.plusButton.addTarget(self, action: #selector(addQuest), for: .touchUpInside)
    }
    
    
    // 플러스 버튼 눌렀을때
    @objc func addQuest() {
        delegate?.addQuest()
    }
    
    @objc func updateQuest(sender: UIButton) {
        guard let index = index else { return }
        delegate?.updateQuest(indexPath: sender.tag)
    }
    
    @objc func deleteQuest(sender: UIButton) {
        let alert = UIAlertController(title: "퀘스트 삭제", message: "정말로 퀘스트를 삭제하시겠습니까", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            guard let indexPath = self.index else { return }
            
            let questData = self.coreManager?.getQuestListFromCoreData() ?? []
            if questData[sender.tag].completed {
                self.todayExp -= 20
                print(self.todayExp)
            }
            self.coreManager?.deletQuest(data: questData[sender.tag], completion: {
                print("삭제 완료")
                self.reload()
            })
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

extension QuestViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func currentDayOfWeek() -> Int {
        let today = Calendar.current.component(.weekday, from: Date())
        return (today - 2 + 7) % 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        print("numberOfRowsInSection")
        let count = coreManager?.getQuestListFromCoreData().count
        print(count)
        return count ?? 0
    }
    
    func reload() {
        questView.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestCell", for: indexPath) as! QuestCell
        let questData = coreManager?.getQuestListFromCoreData() ?? []
        cell.questData = questData[indexPath.row]
        
        
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

        
        // completed 데이터에 따라 UI설정하기
        if cell.questData!.completed {
            // 퀘스트 이미지 변경
            cell.questImage.image = UIImage(named: "img_quest_completed")
            // 퀘스트 타이틀 색 변경
            cell.questTitle.textColor = UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00)
            // 경험치 레이블 색 변경
            cell.expAmount.textColor = UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00)
            // 요일 레이블 색 변경
            cell.repeatday.textColor = UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00)
            // 완료 버튼 UI변경
            cell.completeButton.setTitle("미완료하기", for: .normal)
            cell.completeButton.setTitleColor(UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00), for: .normal)
            
        } else {
            // 퀘스트 이미지 변경
            cell.questImage.image = UIImage(named: "img_quest_ing")
            // 퀘스트 타이틀 색 변경
            cell.questTitle.textColor = .black
            // 경험치 레이블 색 변경
            cell.expAmount.textColor = .black
            // 요일 레이블 색 변경
            cell.repeatday.textColor = .black
            // 완료 버튼 UI변경
            cell.completeButton.setTitle("완료하기", for: .normal)
            cell.completeButton.setTitleColor(.black, for: .normal)
            
        }
        
        // 셀 업데이트 버튼 눌렀을때
        cell.updateButton.addTarget(self , action: #selector(updateQuest), for: .touchUpInside)
        cell.updateButton.tag = indexPath.row
        // 셀 삭제 버튼 눌렀을때
        cell.deleteButton.addTarget(self, action: #selector(deleteQuest), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        // 셀 완료 버튼 눌렀을때
        cell.completeButtonPressed = { [weak self] (senderCell) in
            
            completedCheck.toggle()
            completedToggle()
            toggleExpAdd()
            tableView.reloadData()
            print(self!.todayExp)
        }
        
        func completedToggle() {
            if var questData = cell.self.questData {
                questData.completed = completedCheck
                
                self.coreManager?.updateQuest(newQuestData: questData){
                    print("완료")
                    
                }
                tableView.reloadData()
            }
        }
        
        func toggleExpAdd() {
            if cell.questData!.completed {
                todayExp -= 20
            } else {
                todayExp += 20
            }
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

