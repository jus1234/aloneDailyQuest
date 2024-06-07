//
//  DetailViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/10/24.
//

import Foundation

import RxSwift
import RxCocoa

final class DetailViewModel: ViewModel {
    private var disposeBag = DisposeBag()
    
    struct Input {
        var updateEvent: PublishRelay<QuestInfo?>
        var createEvent: PublishRelay<QuestInfo?>
        var didBackButtonTapEvent: ControlEvent<Void>
    }
    
    struct Output {
        var errorMessage: PublishRelay<String>
        var userInfo: PublishRelay<UserInfo>
    }
    
    private let usecase: QuestUsecase
    private let coordinator: DetailCoordinator
    
    init(usecase: QuestUsecase, coordinator: DetailCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        let output = Output(
            errorMessage: PublishRelay(),
            userInfo: PublishRelay())
        
        input.updateEvent
            .subscribe(onNext: { [weak self] quest in
                guard let self, let quest else {
                    output.errorMessage.accept("처리 중 문제가 발생했습니다.")
                    return
                }

                if quest.quest.isEmpty  || quest.quest == "퀘스트를 입력하세요." {
                    output.errorMessage.accept("퀘스트 내용을 입력해 주세요.")
                    return
                }
                
                if quest.selectedDate.filter({ $0 }).count == 0 {
                    output.errorMessage.accept("하나 이상의 요일을 선택해 주세요.")
                    return
                }
                usecase.update(quest: quest)
                    .subscribe(onCompleted: {
                        self.coordinator.finish(to: .quest)
                    },onError: { _ in
                        output.errorMessage.accept("처리 중 문제가 발생했습니다.")
                    })
                    .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
            
        input.createEvent
            .subscribe(onNext: { [weak self] quest in
                guard let self, let quest else {
                    output.errorMessage.accept("처리 중 문제가 발생했습니다.")
                    return
                }
                
                if quest.quest.isEmpty  || quest.quest == "퀘스트를 입력하세요." {
                    output.errorMessage.accept("퀘스트 내용을 입력해 주세요.")
                    return
                }
                
                
                if quest.selectedDate.filter({ $0 }).count == 0 {
                    output.errorMessage.accept("하나 이상의 요일을 선택해 주세요.")
                    return
                }
                usecase.create(quest: quest)
                    .subscribe(onCompleted: {
                        self.coordinator.finish(to: .quest)
                    },onError: { _ in
                        output.errorMessage.accept("처리 중 문제가 발생했습니다.")
                    })
                    .disposed(by: disposeBag)
            })
            .disposed(by: disposeBag)
        
        input.didBackButtonTapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator.finish(to: .quest)
            })
            .disposed(by: disposeBag)
        
        return output
    }
    
}
