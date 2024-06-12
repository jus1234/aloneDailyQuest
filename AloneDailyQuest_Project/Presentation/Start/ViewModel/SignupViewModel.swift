//
//  LoginViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/10/24.
//

import Foundation

import RxSwift
import RxCocoa

class SignupViewModel: ViewModel {
    struct Input {
        var signupEvent: Observable<String>
        var nickNameValidationEvent: ControlProperty<String>
    }
    
    struct Output {
        var isValidNickName: Observable<Bool>
        var signupResult: Observable<Bool>
    }
    
    private let usecase: AccountUsecase
    private let coordinator: SignupCoordinator
    
    init(usecase: AccountUsecase, coordinator: SignupCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        let isValidNickName = input.nickNameValidationEvent
            .flatMap { [weak self] nickName -> Observable<Bool> in
                guard let result = self?.usecase.validata(nickName: nickName)
                    .asObservable() else {
                    return .empty()
                }
                return result
            }
        
        let signupResult = input.signupEvent
            .flatMap { [weak self] nickName in
                return self?.usecase.signup(userId: nickName) ?? .just(false)
            }
            .asDriver(onErrorJustReturn: false)
            .do { [weak self] result in
                if result {
                    self?.coordinator.finish(to: .quest)
                }
            }
            .asObservable()

        return Output(isValidNickName: isValidNickName, signupResult: signupResult)
    }
}
