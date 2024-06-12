//
//  NoticeViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/13/24.
//

import UIKit

import RxSwift
import RxCocoa

final class NoticeViewController: UIViewController {
    private let disosebag = DisposeBag()
    private let viewModel: NoticeVewModel
    private let notice = NoticeView()
    
    init(viewModel: NoticeVewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = notice
        bindOutput()
    }
    
    private func bindOutput() {
        let input = NoticeVewModel.Input(didBackButtonTap: notice.backButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.viewChangedEvent
            .asDriver(onErrorJustReturn: ())
            .drive(with: self)
            .disposed(by: disosebag)
    }
}
