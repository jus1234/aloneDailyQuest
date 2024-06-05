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
    func validata(nickName: String) -> Completable
}

final class DefaultAccountUsecase: AccountUsecase {
    private let repository: AccountRepository
    
    init(repository: AccountRepository) {
        self.repository = repository
    }
    
    func signup(userId: String) -> Single<Bool> {
        return Single.create { [weak self] observer in
            self?.repository
                .checkId(userId: userId)
                .subscribe(onSuccess: { result in
                    guard result else {
                        observer(.success(false))
                        return
                    }
                    self?.repository
                        .signup(userId: userId)
                        .subscribe(onCompleted: {
                            observer(.success(true))
                        }, onError: { error in
                            observer(.failure(error))
                        })
                        .disposed(by: DisposeBag())
                }, onFailure: { error in
                    observer(.failure(error))
                })
                .disposed(by: DisposeBag())
            return Disposables.create()
        }
    }
    
    func validata(nickName: String) -> Completable {
        return Completable.create { observer in
            guard nickName.count > 0 else {
                observer(.error(NSError()))
                return Disposables.create()
            }
            
            let nicknameRegex = "^[a-zA-Z0-9가-힣]{1,8}$"
            let nicknamePredicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
            nicknamePredicate.evaluate(with: nickName) ? observer(.completed) : observer(.error(NSError()))
            
            return Disposables.create()
        }
    }
}
