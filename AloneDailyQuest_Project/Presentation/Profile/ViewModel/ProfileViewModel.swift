//
//  ProfileViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/17/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ProfileViewModel: ViewModel {
    struct Input {
        var viewWillAppear: ControlEvent<Bool>
        var qeusetViewEvent: ControlEvent<Void>
        var rankViewEvent: ControlEvent<Void>
        var didNoticeTap: ControlEvent<Void>
        var didContactTap: ControlEvent<Void>
        var didLeaveTap: ControlEvent<Void>
        var dropMembershipEvent: PublishSubject<Void>
    }
    
    struct Output {
        var userInfo: Observable<UserInfo?>
        var ourEmail: Observable<String>
        var warningMessage: Observable<String>
        var result: Observable<Void>
        var viewChanged: Observable<Void>
    }
    
    private let usecase: ProfileUsecase
    private let coordinator: ProfileCoordinator
    
    init(usecase: ProfileUsecase, coordinator: ProfileCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        let userInfo: Observable<UserInfo?> = input.viewWillAppear
            .map { _ in
                UserInfo(nickName: UserDefaults.standard.string(forKey: "nickName") ?? "",
                         experience: UserDefaults.standard.integer(forKey: "experience"))
            }
        let ourEmail = input.didContactTap
            .map { "aloneDailyQuest@gmail.com" }
        
        let warningMessage = input.didLeaveTap
            .map { "회원탈퇴시 회원정보를 복구할 수 없습니다. 정말 탈퇴하시겠습니까?" }
        
        let result = input.dropMembershipEvent
            .flatMap { _ in
                return self.usecase.dropMembership()
                    .do(onSuccess: {
                        self.coordinator.finish(to: .app)
                    })
                    .asObservable()
            }
        
        let didNoticeTap = input.didNoticeTap
            .do(onNext: { [weak self] in
                self?.coordinator.connectNoticeCoordinator()
            })
        
        let questViewEvent =  input.qeusetViewEvent
            .do(onNext: { [weak self] in
                self?.coordinator.finish(to: .quest)
            })
        
        let rankViewEvent = input.rankViewEvent
            .do(onNext: { [weak self] in
                self?.coordinator.finish(to: .ranking)
            })
        
        let viewChangedEvent = Observable
            .of(didNoticeTap, questViewEvent, rankViewEvent)
            .merge()
        
        return Output(
            userInfo: userInfo,
            ourEmail: ourEmail,
            warningMessage: warningMessage,
            result: result,
            viewChanged: viewChangedEvent)
    }
    
}
