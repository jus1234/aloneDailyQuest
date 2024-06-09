//
//  ProfileViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/17/24.
//

import Foundation
import RxSwift

@MainActor
final class ProfileViewModel: ViewModel {
    private let disosebag = DisposeBag()
    
    struct Input {
        var viewDidLoad: Observable<Void>
        var qeusetViewEvent: Observable<Void>
        var rankViewEvent: Observable<Void>
        var profileViewEvent: Observable<Void>
        var didNoticeTap: Observable<Void>
        var didContactTap: Observable<Void>
        var didLeaveTap: Observable<Void>
        var dropMembershipEvent: Observable<Void>
    }
    
    struct Output {
        var userInfo: Observable<UserInfo?>
        var ourEmail: Observable<String>
        var warningMessage: Observable<String>
    }
    
    private let usecase: ProfileUsecase
    private let coordinator: ProfileCoordinator
    private var user: Observable<UserInfo?> = Observable(nil)
    private var email: Observable<String> = Observable("")
    private var message: Observable<String> = Observable("")
    
    init(usecase: ProfileUsecase, coordinator: ProfileCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        self.user.value = UserInfo(nickName: UserDefaults.standard.string(forKey: "nickName") ?? "",
                             experience: UserDefaults.standard.integer(forKey: "experience"))
    }
    
    func sendOurEmail() {
        self.email.value = "aloneDailyQuest@gmail.com"
    }
    
    func sendWarningMessage() {
        self.message.value = "회원탈퇴시 회원정보를 복구할 수 없습니다. 정말 탈퇴하시겠습니까?"
    }
    
    func dropMembership() {
            usecase.dropMembership()
                .subscribe(onCompleted: { [weak self] in
                    self?.coordinator.finish(to: .app)
                })
                .disposed(by: disosebag)
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.bind { [weak self] _ in
            self?.viewDidLoad()
        }
        
        input.qeusetViewEvent.bind { [weak self] _ in
            self?.coordinator.finish(to: .quest)
        }
        input.rankViewEvent.bind { [weak self] _ in
            self?.coordinator.finish(to: .ranking)
        }
        input.profileViewEvent.bind { _ in
            return
        }
        input.didNoticeTap.bind { [weak self] _ in
            self?.coordinator.connectNoticeCoordinator()
        }
        input.didContactTap.bind { [weak self] _ in
            self?.sendOurEmail()
        }
        input.didLeaveTap.bind { [weak self] _ in
            self?.sendWarningMessage()
        }
        input.dropMembershipEvent.bind { [weak self] _ in
            self?.dropMembership()
        }
        return .init(userInfo: self.user, ourEmail: self.email, warningMessage: self.message)
    }
    
}
