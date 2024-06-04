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
    private var viewDidLoadEvent: Observable<Void> = Observable(())
    private lazy var updateEvent: Observable<QuestInfo?> = Observable(questData)
    private lazy var addEvent: Observable<QuestInfo?> = Observable(nil)
    private lazy var input = DetailViewModel.Input(
        viewWillAppear: rx.viewWillAppear,
        updateEvent: PublishRelay(),
        createEvent: PublishRelay(),
        didBackButtonTapEvent: detailView.backButton.rx.tap)
    
    init(viewModel: DetailViewModel, questData: QuestInfo?) {
        self.viewModel = viewModel
        self.questData = questData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var questData: QuestInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        setup()
        configureUI()
        bindViewModel()
    }
    
    func bindViewModel() {
        let output = viewModel.transform(input: input)
        
        output.userInfo
            .asDriver(onErrorJustReturn: UserInfo(nickName: "-", experience: 0))
            .drive(with: self) { owner, user in
                owner.detailView.profileBoxView.configureLabel(nickName: user.fetchNickName(), level: String(user.fetchLevel()))
                owner.detailView.profileBoxView.updateExperienceBar(currentExp: user.fetchExperience())
            }
            .disposed(by: disposeBag)
        
        output.errorMessage
            .asDriver(onErrorJustReturn: "")
            .drive(with: self) { owner, error in
                owner.completedAlert(message: error)
            }
            .disposed(by: disposeBag)
    }
    
    func setup() {
        detailView.questTextView.delegate = self
        detailView.buttons.forEach{ button in
            button.addTarget(self, action: #selector(dayButtonTapped), for: .touchUpInside)
        }
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func configureUI() {
        if let questData = self.questData {
            detailView.titleText.text = "퀘스트수정"
            detailView.titleBackgroundText.text = "퀘스트수정"
            detailView.questTextView.text = questData.quest
            
            detailView.questTextView.textColor = .black
            detailView.questTextView.becomeFirstResponder()
            isDaySelected = questData.selectedDate
            zip(detailView.buttons, questData.selectedDate).forEach { toggleButtonAppearance(button: $0.0, isSelected: $0.1) }
        } else {
            detailView.titleText.text = "퀘스트생성"
            detailView.titleBackgroundText.text = "퀘스트생성"
            
            detailView.questTextView.text = "퀘스트를 입력하세요."
            detailView.questTextView.textColor = .lightGray
            
        }
    }
    
    var isDaySelected = [false, false, false, false, false, false, false]
    var day = ["월", "화", "수", "목", "금", "토", "일"]
    var repeatLabel = ""
    var isCompleted = false
    var todayExp: Int64 = 0
    var questImage = "img_quest_ing"
    var expString = "보상 : 20xp"
    
    func repeatLabelSet() -> String {
        for (index, bool) in isDaySelected.enumerated() {
            if bool {
                repeatLabel = repeatLabel + day[index]
            }
        }
        
        if repeatLabel == "" {
            return "반복 없음"
        } else if repeatLabel == "월화수목금토일" {
            return "매일 반복"
        } else {
            return "요일 반복"
        }
    }

    @objc func dayButtonTapped(_ sender: UIButton){
        guard let index = detailView.buttons.firstIndex(of: sender) else { return }
        isDaySelected[index].toggle()
        toggleButtonAppearance(button: sender, isSelected: isDaySelected[index])
    }
    
    func toggleButtonAppearance(button: UIButton, isSelected: Bool) {
        if isSelected {
            button.backgroundColor = UIColor(red: 0.63, green: 0.28, blue: 0.01, alpha: 1.00)
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
            button.setTitleColor(.black, for: .normal)
        }
    }
    
    @objc func saveButtonTapped(_ sender: UIButton) {
        if var questData = self.questData {
            let repeatLabel = repeatLabelSet()
            questData.quest = detailView.questTextView.text
            questData.selectedDate[0] = isDaySelected[0]
            questData.selectedDate[1] = isDaySelected[1]
            questData.selectedDate[2] = isDaySelected[2]
            questData.selectedDate[3] = isDaySelected[3]
            questData.selectedDate[4] = isDaySelected[4]
            questData.selectedDate[5] = isDaySelected[5]
            questData.selectedDate[6] = isDaySelected[6]
            questData.repeatDay = repeatLabel
            input.updateEvent.accept(questData)
            
            self.questData = questData
            
            // 기존데이터가 없을때 ===> 새로운 데이터 생성
        } else {
            guard let questText = detailView.questTextView.text else { return }
            let repeatLabel = repeatLabelSet()
            registerQuestForSelectedDays(questText: questText, repeatLabel: repeatLabel)
        }
    }
    
    func registerQuestForSelectedDays(questText: String, repeatLabel: String) {
        let data = QuestInfo(id: UUID(), quest: questText, date: Date(), selectedDate: isDaySelected, repeatDay: repeatLabel, completed: isCompleted)
        input.createEvent.accept(data)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "퀘스트를 여기에 입력하세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "퀘스트를 여기에 입력하세요."
            textView.textColor = .lightGray
        }
    }
}
