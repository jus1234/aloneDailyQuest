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
    private let disposeBag = DisposeBag()
    
    struct Input {
        var signupEvent: PublishRelay<String>
        var nickNameValidationEvent: ControlProperty<String>
    }
    
    struct Output {
        var isValidNickName: PublishRelay<Bool>
        var errorMessage: PublishRelay<String>
    }
    
    private let usecase: AccountUsecase
    private let coordinator: SignupCoordinator
    
    init(usecase: AccountUsecase, coordinator: SignupCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        let output = Output(
            isValidNickName: PublishRelay(),
            errorMessage: PublishRelay())
        
        input.signupEvent
            .subscribe(onNext: { [weak self] nickName in
                guard let self else {
                    return
                }
                usecase
                    .signup(userId: nickName)
                    .subscribe(onSuccess: { result in
                        result ? self.coordinator.finish(to: .quest) : output.errorMessage.accept("중복된 닉네임입니다.")
                    }, onFailure: { error in
                        output.errorMessage.accept(error.localizedDescription)
                    })
                    .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        
        input.nickNameValidationEvent
            .subscribe(onNext: { [weak self] nickName in
                guard let self else {
                    return
                }
                usecase
                    .validata(nickName: nickName)
                    .subscribe(onCompleted: {
                        output.isValidNickName.accept(true)
                    }, onError: { _ in
                        output.isValidNickName.accept(false)
                    })
                    .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        
        return output
    }
}
