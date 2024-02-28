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
    var isCompleted = [false]
    
    var text: String = ""
    
    var index: IndexPath?
    
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
        
        cell.repeatday.text = cell.questData?.repeatDay
        cell.questTitle.text = cell.questData?.quest
        
        index = indexPath
        
        // 셀 업데이트 버튼 눌렀을때
        cell.updateButton.addTarget(self , action: #selector(updateQuest), for: .touchUpInside)
        cell.updateButton.tag = indexPath.row
            
        cell.deleteButton.addTarget(self, action: #selector(deleteQuest), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        
        cell.selectionStyle = .none
        return cell
    }
}
