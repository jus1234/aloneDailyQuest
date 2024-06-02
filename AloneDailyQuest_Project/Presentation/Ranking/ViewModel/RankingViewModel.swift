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
    typealias Observable = RxSwift.Observable
    
    private var disposeBag = DisposeBag()
    
    struct Input {
        var viewWillAppear: ControlEvent<Bool>
        var qeusetViewEvent: ControlEvent<Void>
        var rankViewEvent: ControlEvent<Void>
        var profileViewEvent: ControlEvent<Void>
    }
    
    struct Output {
        var rankingList: BehaviorRelay<[UserInfo]>
        var myRanking: PublishRelay<Int>
        var errorMessage: PublishRelay<String>
    }
    
    private let usecase: RankingUsecase
    private let coordinator: RankingCoordinator
    
    init(usecase: RankingUsecase, coordinator: RankingCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        let output = Output(
            rankingList: BehaviorRelay(value: [UserInfo]()),
            myRanking: PublishRelay(),
            errorMessage: PublishRelay())
        
        input.viewWillAppear
            .flatMapLatest { [weak self] _ -> Observable<([UserInfo], Int)> in
                guard 
                    let self = self,
                    let nickName = UserDefaults.standard.string(forKey: "nickName")
                else {
                    return Observable.error(UserDefaultsError.notFound)
                }
                return Observable.zip(
                    self.usecase.fetchRankingList(),
                    self.usecase.fetchUserRanking(nickName: nickName))
            }
            .subscribe(onNext: { rankingList, myRanking in
                output.rankingList.accept(rankingList)
                output.myRanking.accept(myRanking)
            }, onError: { error in
                output.errorMessage.accept(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        input.qeusetViewEvent
            .subscribe(with: self) { owner, _ in
                owner.coordinator.finish(to: .quest)
            }
            .disposed(by: disposeBag)
        
        input.rankViewEvent
            .subscribe(with: self) { owner, _ in
                owner.coordinator.finish(to: .ranking)
            }
            .disposed(by: disposeBag)
        
        input.profileViewEvent
            .subscribe(with: self) { owner, _ in
                owner.coordinator.finish(to: .profile)
            }
            .disposed(by: disposeBag)
        
        return output
    }
}
