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
    private let dispoeseBag = DisposeBag()
    
    private let repository: AccountRepository
    
    init(repository: AccountRepository) {
        self.repository = repository
    }
    
    func signup(userId: String) -> Single<Bool> {
        return Single.create { [weak self] observer in
            guard let self else {
                observer(.failure(NSError()))
                return Disposables.create()
            }
            repository
                .checkId(userId: userId)
                .subscribe(onSuccess: { result in
                    if result {
                        observer(.success(false))
                        return
                    }
                    self.repository
                        .signup(userId: userId)
                        .subscribe(onCompleted: {
                            UserDefaults.standard.set(userId, forKey: "nickName")
                            UserDefaults.standard.setValue(0, forKey: "experience")
                            observer(.success(true))
                        }, onError: { error in
                            observer(.failure(error))
                        })
                        .disposed(by: self.dispoeseBag)
                }, onFailure: { error in
                    observer(.failure(error))
                })
                .disposed(by: dispoeseBag)
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
