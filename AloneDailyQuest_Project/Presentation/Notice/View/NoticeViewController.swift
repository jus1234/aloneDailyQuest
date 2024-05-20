//
//  NoticeViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/13/24.
//

import UIKit

final class NoticeViewController: UIViewController {
    
    private let viewModel: NoticeVewModel
    private let notice = NoticeView()
    private lazy var input = NoticeVewModel.Input(didBackButtonTap: notice.didBackButtonTap,
                                                  qeusetViewEvent: notice.tabView.qeusetViewEvent,
                                                  rankViewEvent: notice.tabView.rankiViewEvent,
                                                  profileViewEvent: notice.tabView.profileViewEvent)
    private lazy var output = viewModel.transform(input: input)
    
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
        output.errorMessage.bind { [weak self] errorMessage in
            self?.completedAlert(message: errorMessage)
        }
    }
}
