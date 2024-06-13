//
//  RankingViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/8/24.
//

import Foundation

import RxCocoa
import RxSwift

final class RankingViewModel: ViewModel {
    struct Input {
        var viewWillAppear: ControlEvent<Bool>
        var qeusetViewEvent: ControlEvent<Void>
        var profileViewEvent: ControlEvent<Void>
    }
    
    struct Output {
        var rankData: Observable<([UserInfo], Int)>
        var viewChanged: Observable<Void>
    }
    
    private let usecase: RankingUsecase
    private let coordinator: RankingCoordinator
    
    init(usecase: RankingUsecase, coordinator: RankingCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        let rankData = input.viewWillAppear
            .flatMap { [weak self] _ -> Observable<([UserInfo], Int)> in
                guard
                    let nickName = UserDefaults.standard.string(forKey: "nickName"),
                    let rankList = self?.usecase.fetchRankingList().asObservable(),
                    let myRank = self?.usecase.fetchUserRanking(nickName: nickName).asObservable()
                else {
                    return .empty()
                }
                return Observable.zip(rankList, myRank)
            }
        
        let toQuestView = input.qeusetViewEvent
            .do(onNext: { [weak self] _ in
                self?.coordinator.finish(to: .quest)
            })
        
        let toProfileView = input.profileViewEvent
            .do(onNext: { [weak self] _ in
                self?.coordinator.finish(to: .profile)
            })
        
        let viewChanged = Observable.merge([toQuestView, toProfileView])
        
        return Output(rankData: rankData, viewChanged: viewChanged)
    }
}
