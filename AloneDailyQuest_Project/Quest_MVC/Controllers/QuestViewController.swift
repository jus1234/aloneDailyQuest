//
//  QuestViewController.swift
//  AloneDailyQuest-QuestTestUI
//
//  Created by 오정석 on 20/12/2023.
//

import UIKit

final class QuestViewController: UIViewController{
    
    // 모델(저장 데이터를 관리하는 코어데이터)
    let questManager = CoreDataManager.shared
    private let questView = QuestView()
    weak var delegate: delegateViewController? = nil
    
    // MARK: - UI설정
    
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
    
}

extension QuestViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questManager.getQuestListFromCoreData().count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestCell", for: indexPath) as! QuestCell
        
        
        // (테이블뷰 그리기 위한) 셀에 모델(QuestData) 전달
        let questData = questManager.getQuestListFromCoreData()
        cell.questData = questData[indexPath.row]
        
        
        // 셀 위에 있는 버튼이 눌렸을때 (뷰컨트롤러에서) 어떤 행동을 하기 위해서 클로저 전달
        // 세그웨이 대신 직접 push
        cell.updateButtonPressed = { [weak self] (senderCell) in
            let detailVC = DetailViewController()
            let selectedQuest = self?.questManager.getQuestListFromCoreData()[indexPath.row]
            detailVC.questData = selectedQuest
            
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        cell.deleteButtonPressed = { [weak self] (senderCell) in
            
            let alert = UIAlertController(title: "퀘스트 삭제", message: "정말로 퀘스트를 삭제하시겠습니까", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
                guard let indexPath = tableView.indexPath(for: senderCell) else { return }
                
                self?.questManager.deletQuest(data: questData[indexPath.row], completion: {
                    print("삭제 완료")
                    tableView.reloadData()
                })
                
            }))
            self?.present(alert, animated: true, completion: nil)
            tableView.reloadData()
        }
        
        cell.completeButtonPressed = { [weak self] (senderCell) in
            
            cell.questImage = UIImageView(image: UIImage(named: "img_quest_completed"))
            cell.questTitle.textColor = UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00)
            cell.completeButton.titleLabel?.textColor = UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00)
            cell.repeatday.textColor = UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00)
            cell.expAmount.textColor = UIColor(red: 0.82, green: 0.74, blue: 0.63, alpha: 1.00)
            print("완료버튼 눌림")
            cell.completeButton.setTitle("Clear!!", for: .normal)
            cell.completeButton.isEnabled = false
            cell.updateButton.isEnabled = false
            
            tableView.reloadData()
        }
        
        cell.selectionStyle = .none
        return cell
    }
}
