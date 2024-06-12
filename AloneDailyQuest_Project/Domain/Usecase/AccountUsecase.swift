//
//  AccountUsecase.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/8/24.
//

import Foundation
import RxSwift

protocol AccountUsecase {
    func signup(userId: String) -> Single<Bool>
    func validata(nickName: String) -> Single<Bool>
}

final class DefaultAccountUsecase: AccountUsecase {
    
    private let repository: AccountRepository
    
    init(repository: AccountRepository) {
        self.repository = repository
    }
    
    func signup(userId: String) -> Single<Bool> {
        return repository
            .checkId(userId: userId)
            .flatMap { [weak self] isExist -> Single<Bool> in
                switch isExist {
                case true:
                    return .just(false)
                case false:
                    guard let result = self?.repository.signup(userId: userId) else {
                        return .error(NSError())
                    }
                    UserDefaults.standard.set(userId, forKey: "nickName")
                    UserDefaults.standard.setValue(0, forKey: "experience")
                    return result
                }
            }
    }
    
    func validata(nickName: String) -> Single<Bool> {
        return Single.create { observer in
            guard nickName.count > 0 else {
                observer(.success(false))
                return Disposables.create()
            }
            let nicknameRegex = "^[a-zA-Z0-9가-힣]{1,8}$"
            let nicknamePredicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
            nicknamePredicate.evaluate(with: nickName) ? observer(.success(true)) : observer(.success(false))
            return Disposables.create()
        }
    }
}
