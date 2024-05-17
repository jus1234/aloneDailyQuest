//
//  ProfileViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/17/24.
//

import Foundation

final class ProfileViewModel: ViewModel {
    struct Input {
        var viewDidLoad: Observable<Void>
        var qeusetViewEvent: Observable<Void>
        var rankViewEvent: Observable<Void>
        var profileViewEvent: Observable<Void>
    }
    
    struct Output {
        var userInfo: Observable<UserInfo?>
    }
    
    private let usecase: ProfileUsecase
    private let coordinator: ProfileCoordinator
    private var user: Observable<UserInfo?> = Observable(nil)
    
    init(usecase: ProfileUsecase, coordinator: ProfileCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        self.user.value = UserInfo(nickName: UserDefaults.standard.string(forKey: "nickName") ?? "",
                             experience: UserDefaults.standard.integer(forKey: "experience"))
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
        return .init(userInfo: self.user)
    }
    
}
