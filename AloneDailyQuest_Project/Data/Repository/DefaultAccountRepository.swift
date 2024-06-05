//
//  DefaultAccountRepository.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/7/24.
//

import Foundation
import RxSwift

final class DefaultAccountRepository: AccountRepository {
    private let networkService: NetworkService
    private let decorder: JSONDecoder = JSONDecoder()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func signup(userId: String) -> Completable {
        return Completable.create { [weak self] observer in
            self?.networkService
                .request(.signup(userId: UserIdRequestDTO(userId: userId)))
                .subscribe(onSuccess: { _ in
                    observer(.completed)
                }, onFailure: { error in
                    observer(.error(error))
                })
                .disposed(by: DisposeBag())
            return Disposables.create()
        }
    }
    
    func checkId(userId: String) -> Single<Bool> {
        return networkService
            .request(.checkId(userId: UserIdRequestDTO(userId: userId)))
            .flatMap { [weak self] data in
                do {
                    guard let result = try self?.decorder.decode(CheckIdResponseDTO.self, from: data).exists else {
                        throw NetworkError.dataError
                    }
                    return Single.just(result)
                } catch {
                    return Single.error(error)
                }
            }
    }
    
    func fetchUserInfo(userId: String) -> Single<UserInfo> {
        return networkService
            .request(.member(userId: UserIdRequestDTO(userId: userId)))
            .flatMap { [weak self] data in
                do {
                    guard let userInfo = try self?.decorder.decode(UserInfoDTO.self, from: data) else {
                        throw NetworkError.dataError
                    }
                    return Single.just(userInfo.toEntity())
                } catch {
                    return Single.error(error)
                }
            }
    }
    
    func fetchExperience(userId: String) -> Single<Int> {
        return networkService
            .request(.experience(userId: UserIdRequestDTO(userId: userId)))
            .flatMap { [weak self] data in
                do {
                    guard let experience = try self?.decorder.decode(ExperienceResponseDTO.self, from: data) else {
                        throw NetworkError.dataError
                    }
                    return Single.just(experience.experience)
                } catch {
                    return Single.error(error)
                }
            }
    }
    
    func addExperience(user: UserInfo) -> Single<Int> {
        return networkService
            .request(.addExperience(user: UserInfoDTO(userId: user.fetchNickName(), experience: user.fetchExperience())))
            .flatMap { [weak self] data in
                do {
                    guard
                        let addedExperience = try self?.decorder.decode(ExperienceResponseDTO.self, from: data).experience
                    else {
                        throw NetworkError.dataError
                    }
                    return Single.just(addedExperience)
                } catch {
                    return Single.error(error)
                }
            }
    }
}

