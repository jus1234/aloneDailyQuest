//
//  SettingViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 2/6/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileView: ProfileView = ProfileView()
    var coreManager: CoreDataManager
    weak var delegate: delegateViewController?
    
    init(coreManager: CoreDataManager) {
        self.coreManager = coreManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = profileView
        configureUI()
        setUp()
    }
    
    func configureUI() {
        profileView.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
    }
    
    func setUp() {
        profileView.tabView.questButton.addTarget(self, action: #selector(moveQuestView), for: .touchUpInside)
        profileView.tabView.rankListButton.addTarget(self, action: #selector(moveRankView), for: .touchUpInside)
        profileView.tabView.profileButton.addTarget(self, action: #selector(moveProfileView), for: .touchUpInside)
    }
    
    @objc func moveQuestView() {
        delegate?.moveQuestView()
    }
    
    @objc func moveRankView() {
        print("랭킹으로 이동")
    }
    
    @objc func moveProfileView() {
        delegate?.moveProfileView()
    }
}
