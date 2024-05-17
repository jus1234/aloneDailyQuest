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
        var qeusetViewEvent: Observable<Void>
        var rankViewEvent: Observable<Void>
    }
    
    struct Output {
        var userInfo: Observable<UserInfo?>
        var rankingList: Observable<[UserInfo]>
        var myRanking: Observable<Int>
        var errorMessage: Observable<String>
    }
    
    private let usecase: RankingUsecase
    private let coordinator: RankingCoordinator
    private let user: Observable<UserInfo?> = Observable(nil)
    private var rankingList: Observable<[UserInfo]> = Observable([])
    private var myRanking: Observable<Int> = Observable(0)
    private var errorMessage: Observable<String> = Observable("")
    
    init(usecase: RankingUsecase, coordinator: RankingCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.bind { [weak self] _ in
            self?.viewDidLoad()
        }
        input.qeusetViewEvent.bind { [weak self] _ in
            self?.coordinator.finish(to: .quest)
        }
        input.rankViewEvent.bind { _ in
            return
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
            rankingList.value = try await usecase.fetch()
            myRanking.value = try await usecase.fetchUserRanking(nickName: UserDefaults.standard.string(forKey: "nickName") ?? "")
            user.value = UserInfo(nickName: UserDefaults.standard.string(forKey: "nickName") ?? "",
                                  experience: UserDefaults.standard.integer(forKey: "experience"))
        } catch {
            errorMessage.value = error.localizedDescription
        }
    }
    
}
