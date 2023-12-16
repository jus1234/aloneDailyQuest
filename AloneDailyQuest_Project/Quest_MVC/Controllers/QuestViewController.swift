//
//  QuestViewController.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 12/12/2023.
//

import UIKit

class QuestViewController: UIViewController {

    
    
    // MARK: - 관리 모델 선언
    
    //MVC패턴을 위한 따로 만든 뷰
    private let questView = QuestView()
    //MVC패턴을 위한 데이터 매니저 (배열 관리 - 데이터)
    var questListManager = QuestListManager()

    //네비게이션 바에 넣기 위한 버튼
//    lazy var plusButton: UIBarButtonItem = {
//        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
//        return button
//    }()
    
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

   

}
