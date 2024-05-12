//
//  RankingViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/8/24.
//

import Foundation

@MainActor
final class RankingViewModel: ViewModel {
    struct Input {
        var viewDidLoad: Observable<Void>
    }
    
    struct Output {
        var userInfo: Observable<UserInfo>
        var rankingList: Observable<[UserInfo]>
        var myRanking: Observable<Int>
        var errorMessage: Observable<String>
    }
    
    private let usecase: RankingUsecase
    private let user: Observable<UserInfo>
    private var rankingList: Observable<[UserInfo]> = Observable([])
    private var myRanking: Observable<Int> = Observable(0)
    private var errorMessage: Observable<String> = Observable("")
    
    init(usecase: RankingUsecase, user: UserInfo) {
        self.usecase = usecase
        self.user = Observable(user)
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.bind { [weak self] _ in
            self?.viewDidLoad()
        }
        
        return .init(userInfo: user,
                     rankingList: rankingList,
                     myRanking: myRanking,
                     errorMessage: errorMessage)
    }
    
    private func viewDidLoad() {
        Task {
            await fetchRanking()
        }
    }
    
    private func fetchRanking() async {
        do {
            user.value = user.value
            rankingList.value = try await usecase.fetch()
            myRanking.value = try await usecase.fetchUserRanking(nickName: user.value.fetchNickName())
        } catch {
            errorMessage.value = error.localizedDescription
        }
    }
    
}
