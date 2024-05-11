//
//  LoginViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/10/24.
//

import Foundation

@MainActor
class LoginViewModel: ViewModel {
    struct Input {
        var signupEvent: Observable<String>
        var nickNameValidationEvent: Observable<String>
    }
    
    struct Output {
        var isValidNickName: Observable<Bool?>
        var isSignupSucess: Observable<Bool?>
    }
    
    private let usecase: AccountUsecase
    private var isValidNickName: Observable<Bool?> = Observable(false)
    private var isSignupSucess: Observable<Bool?> = Observable(false)
    
    init(usecase: AccountUsecase) {
        self.usecase = usecase
    }
    
    func transform(input: Input) -> Output {
        input.signupEvent.bind { [weak self] nickName in
            Task {
                self?.isSignupSucess.value = try await self?.signup(nickName: nickName)
            }
        }
        
        input.nickNameValidationEvent.bind { [weak self] nickName in
            self?.isValidNickName.value = self?.vaildateNickname(nickName)
        }
        
        return .init(isValidNickName: isValidNickName,
                      isSignupSucess: isSignupSucess)
    }
    
    private func signup(nickName: String) async throws -> Bool {
        let result = try await usecase.checkId(userId: nickName)
        if result {
            try await usecase.signup(userId: nickName)
        }
        return result
    }
    
    private func vaildateNickname(_ text: String) -> Bool {
        let nicknameRegex = "^[a-zA-Z0-9가-힣]{1,8}$"
        let nicknamePredicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
        return nicknamePredicate.evaluate(with: text)
    }
}
