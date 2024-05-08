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
        var rankingList: Observable<[UserInfo]>
        var myRanking: Observable<Int>
        var errorMessage: Observable<String>
    }
    
    private let usecase: RankingUsecase
    private let nickName: String
    private var rankingList: Observable<[UserInfo]> = Observable([])
    private var myRanking: Observable<Int> = Observable(0)
    private var errorMessage: Observable<String> = Observable("")
    
    init(usecase: RankingUsecase, nickName: String) {
        self.usecase = usecase
        self.nickName = nickName
    }
    
    func transform(input: Input) async -> Output {
        input.viewDidLoad.bind { [weak self] _ in
            self?.viewDidLoad()
        }
        
        return .init(rankingList: rankingList,
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
            rankingList.value = try await usecase.fetch()
            myRanking.value = try await usecase.fetchUserRanking(nickName: nickName)
        } catch {
            errorMessage.value = error.localizedDescription
        }
    }
    
}
