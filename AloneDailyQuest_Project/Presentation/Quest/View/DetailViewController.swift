//
//  DetailViewController.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 12/1/2024.
//

import UIKit

import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    private let detailView = DetailView()
    private let viewModel: DetailViewModel
    
    private var questData: QuestInfo?
    private var isDaySelected = [false, false, false, false, false, false, false]
    
    init(viewModel: DetailViewModel, questData: QuestInfo?) {
        self.viewModel = viewModel
        self.questData = questData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        setup()
        configureUI()
        bind()
    }
    
    func bind() {
        let input = DetailViewModel.Input(
            saveQuest: detailView.saveButton.rx.tap
                .subscribe(on: MainScheduler())
                .map { [weak self] _ -> Bool in
                    guard
                        let content = self?.detailView.questTextView.text,
                        let selectedDays = self?.isDaySelected
                    else {
                        return false
                    }
                    if content == "" || content == "퀘스트를 입력하세요." {
                        self?.completedAlert(message: "퀘스트 내용을 입력해 주세요.")
                        return false
                    }
                    if selectedDays.filter({ $0 }).isEmpty {
                        self?.completedAlert(message: "하나 이상의 요일을 선택해 주세요.")
                        return false
                    }
                    return true
                }
                .map { [weak self] isValid in
                    guard isValid else {
                        return nil
                    }
                    guard
                        let quest = self?.makeQuest()
                    else {
                        return nil
                    }
                    return quest
                }
            ,
            didBackButtonTapEvent: detailView.backButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.saveResult
            .asDriver(onErrorJustReturn: false)
            .drive(with: self)
            .disposed(by: disposeBag)
        
        output.viewChanged
            .asDriver(onErrorJustReturn: ())
            .drive(with: self)
            .disposed(by: disposeBag)
        
        zip(detailView.buttons, 0...6).forEach { [weak self] button, index in
            guard 
                let disposebag = self?.disposeBag
            else {
                return
            }
            button.rx.tap
                .subscribe(on: MainScheduler())
                .subscribe { _ in
                    self?.isDaySelected[index].toggle()
                    guard 
                        let isSelected = self?.isDaySelected[index]
                    else {
                        return
                    }
                    self?.toggleButtonAppearance(button: button, isSelected: isSelected)
                }
                .disposed(by: disposebag)
        }
    }
    
    private func setup() {
        detailView.questTextView.delegate = self
    }
    
    private func configureUI() {
        if let questData = self.questData {
            detailView.titleText.text = "퀘스트수정"
            detailView.titleBackgroundText.text = "퀘스트수정"
            detailView.questTextView.text = questData.quest
            
            detailView.questTextView.textColor = .black
            detailView.questTextView.becomeFirstResponder()
            isDaySelected = questData.selectedDate
            zip(detailView.buttons, questData.selectedDate)
                .forEach { toggleButtonAppearance(button: $0.0, isSelected: $0.1) }
        } else {
            detailView.titleText.text = "퀘스트생성"
            detailView.titleBackgroundText.text = "퀘스트생성"
            
            detailView.questTextView.text = "퀘스트를 입력하세요."
            detailView.questTextView.textColor = .lightGray
        }
    }
    
    private func makeQuest() -> QuestInfo {
        return QuestInfo(
            id: questData?.id ?? UUID(),
            quest: detailView.questTextView.text ?? "",
            date: questData?.date ?? Date(),
            selectedDate: isDaySelected,
            repeatDay: isDaySelected.filter({ $0 }).count == 7 ? "매일 반복" : "요일 반복",
            completed: questData?.completed ?? false)
    }
    
    private func toggleButtonAppearance(button: UIButton, isSelected: Bool) {
        if isSelected {
            button.backgroundColor = UIColor(red: 0.63, green: 0.28, blue: 0.01, alpha: 1.00)
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
            button.setTitleColor(.black, for: .normal)
        }
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "퀘스트를 입력하세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "퀘스트를 입력하세요."
            textView.textColor = .lightGray
        }
    }
}
