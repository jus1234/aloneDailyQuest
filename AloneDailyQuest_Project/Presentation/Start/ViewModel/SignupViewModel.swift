//
//  LoginViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/10/24.
//

import Foundation

@MainActor
class SignupViewModel: ViewModel {
    struct Input {
        var signupEvent: Observable<String>
        var nickNameValidationEvent: Observable<String>
    }
    
    struct Output {
        var isValidNickName: Observable<Bool?>
        var isSignupSucess: Observable<Bool?>
        var errorMessage: Observable<String>
    }
    
    private let usecase: AccountUsecase
    private let coordinator: SignupCoordinator
    private var isValidNickName: Observable<Bool?> = Observable(false)
    private var isSignupSucess: Observable<Bool?> = Observable(false)
    private var errorMessage: Observable<String> = Observable("")
    
    init(usecase: AccountUsecase, coordinator: SignupCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.signupEvent.bind { [weak self] nickName in
            Task {
                do {
                    self?.isSignupSucess.value = try await self?.signup(nickName: nickName)
                    if let result = self?.isSignupSucess.value, result {
                        self?.coordinator.finish()
                    }
                } catch {
                    self?.errorMessage.value = error.localizedDescription
                }
            }
        }
        input.nickNameValidationEvent.bind { [weak self] nickName in
            self?.isValidNickName.value = self?.vaildateNickname(nickName)
        }
        return .init(isValidNickName: isValidNickName,
                     isSignupSucess: isSignupSucess,
                     errorMessage: errorMessage)
    }
    
    private func signup(nickName: String) async throws -> Bool {
        let result = try await usecase.checkId(userId: nickName)
        if result {
            try await usecase.signup(userId: nickName)
            UserDefaults.standard.set(nickName, forKey: "nickName")
            UserDefaults.standard.setValue(0, forKey: "experience")
        }
        return result
    }
    
    private func vaildateNickname(_ text: String) -> Bool {
        let nicknameRegex = "^[a-zA-Z0-9가-힣]{1,8}$"
        let nicknamePredicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
        return nicknamePredicate.evaluate(with: text)
    }
}
