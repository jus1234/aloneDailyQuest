//
//  SettingViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 2/6/24.
//

import UIKit

import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    private let disposebag = DisposeBag()
    private let profileView: ProfileView = ProfileView()
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
        view = profileView
    }
    
    func configureUI() {
        profileView.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
    }
    
    func bindViewModel() {
        let input = ProfileViewModel.Input(
            viewWillAppear: rx.viewWillAppear,
            qeusetViewEvent: profileView.tabView.questButton.rx.tap,
            rankViewEvent: profileView.tabView.rankListButton.rx.tap,
            didNoticeTap: profileView.noticeButton.rx.tap,
            didContactTap: profileView.contactButton.rx.tap,
            didLeaveTap: profileView.leaveButton.rx.tap,
            dropMembershipEvent: PublishSubject<Void>())
        let output = viewModel.transform(input: input)
        
        output.userInfo
            .asDriver(onErrorJustReturn: nil)
            .drive(with: self) { owner, user in
                guard
                    let nickName = user?.fetchNickName(),
                    let level = user?.fetchLevel(),
                    let experience = user?.fetchExperience()
                else {
                    return
                }
                owner.profileView.configureLabel(nickName: nickName, level: level)
                owner.profileView.updateExperienceBar(currentExp: experience)
            }
            .disposed(by: disposebag)
        
        output.ourEmail
            .asDriver(onErrorJustReturn: "")
            .drive(with: self) { owner, email in
                owner.completedAlert(message: "이메일 복사 완료!")
                UIPasteboard.general.string = email
            }
            .disposed(by: disposebag)
        
        output.warningMessage
            .asDriver(onErrorJustReturn: "")
            .drive(with: self) { owner, message in
                owner.makeCancelAlert(message: message) { _ in
                    input.dropMembershipEvent.onNext(())
                }
            }
            .disposed(by: disposebag)
        
        output.result
            .asDriver(onErrorJustReturn: ())
            .drive(with: self)
            .disposed(by: disposebag)
        
        output.viewChanged
            .asDriver(onErrorJustReturn: ())
            .drive(with: self)
            .disposed(by: disposebag)
    }
}


