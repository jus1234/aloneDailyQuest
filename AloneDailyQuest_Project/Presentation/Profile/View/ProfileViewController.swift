//
//  SettingViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 2/6/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileView: ProfileView = ProfileView()
    private let viewModel: ProfileViewModel
    
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        input.viewDidLoad.value = ()
        view = profileView
    }
    
    private var viewDidLoadEvent: Observable<Void> = Observable(())
    private lazy var input = ProfileViewModel.Input(viewDidLoad: Observable(()),
                                                    qeusetViewEvent: profileView.tabView.qeusetViewEvent,
                                                    rankViewEvent: profileView.tabView.rankiViewEvent,
                                                    profileViewEvent: profileView.tabView.profileViewEvent)
    private lazy var output = viewModel.transform(input: input)
    
    func configureUI() {
        profileView.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
    }
    
    func bindViewModel() {
        output.userInfo.bind { user in
            guard
                let nickName = user?.fetchNickName(),
                let level = user?.fetchLevel(),
                let experience = user?.fetchExperience() else { return }
            self.profileView.configureLabel(nickName: nickName, level: String(level))
            self.profileView.updateExperienceBar(currentExp: experience)
        }
    }
}


