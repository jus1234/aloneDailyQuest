//
//  QuestCell.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 12/1/2024.
//

import UIKit

final class QuestCell: UITableViewCell {

    // MARK: - UI 설정 (퀘스트🍎윗부분 🍏아랫부분)

    let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 🍎(이미지, 퀘스트 내용, 업데이트 버튼, 삭제 버튼)
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 퀘스트 이미지
    let questImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // 퀘스트 타이틀
    let questTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 18)
        return label
    }()
    
    // 업데이트 버튼
    lazy var updateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "pencil.line"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 삭제 버튼
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [updateButton, deleteButton])
        stview.spacing = 10
        stview.axis = .horizontal
        stview.distribution = .fillEqually
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    
    
    // 🍏(반복, 경험치량, 완료 버튼)
    let subView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 요일반복 레이블
    let repeatday: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 경험치량 표시
    let expAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "DungGeunMo", size: 14)
        label.text = "보상 : 20xp"
        return label
    }()

    // 완료하기 버튼
    lazy var completeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont(name: "DungGeunMo", size: 14)
        button.setTitle("완료하기", for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var subStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [repeatday ,expAmount])
        stview.spacing = 60
        stview.axis = .horizontal
        stview.distribution = .fillEqually
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    // 메인뷰랑, 서브뷰 합침
    private lazy var mainStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [mainView, subView])
        stview.spacing = 10
        stview.axis = .vertical
        stview.distribution = .fillEqually
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    // QuestData를 전달받을 변수 (전달 받으면 ==> 표시하는 메서드 실행) ⭐️
    var questData: QuestData? {
        didSet {
            configureUIwithData()
        }
    }
    
    // (델리게이트 대신에) 실행하고 싶은 클로저 저장
    // 뷰컨트롤러에 있는 클로저 저장할 예정 (셀(자신)을 전달)
    var updateButtonPressed: (QuestCell) -> Void = { (sender) in }
    
    var deleteButtonPressed: (QuestCell) -> Void = { (sender) in }
    
    var completeButtonPressed: (QuestCell) -> Void = { (sender) in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setConstraints() {
        self.contentView.addSubview(backView)
        // backView <== mainStackView
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25),
            backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -25),
            backView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7),
            backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -7)])
        
        self.contentView.addSubview(mainStackView)
        
        // mainStackView <== mainView + subView
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -10),
            mainStackView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -10)
        ])
        
        self.contentView.addSubview(questImage)
        self.contentView.addSubview(questTitle)
        self.contentView.addSubview(buttonStackView)
        
        // mainView <== questImage + questTitle + buttonStackView
        NSLayoutConstraint.activate([
            mainView.heightAnchor.constraint(greaterThanOrEqualToConstant: 90),
            
            questImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            questImage.widthAnchor.constraint(equalToConstant: 45),
            questImage.heightAnchor.constraint(equalToConstant: 45),
            
            questTitle.leadingAnchor.constraint(equalTo: questImage.trailingAnchor, constant: 14),
            questTitle.trailingAnchor.constraint(equalTo: buttonStackView.leadingAnchor, constant: 14),
            questTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 45),
            
            buttonStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            buttonStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 10),
            buttonStackView.heightAnchor.constraint(equalToConstant: 20),
            buttonStackView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            
        ])
        
        self.contentView.addSubview(subStackView)
        self.contentView.addSubview(completeButton)
        
        // subView <== subStackView + compleButton
        NSLayoutConstraint.activate([
            subView.heightAnchor.constraint(equalToConstant: 45),
            
            subStackView.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 10),
            subStackView.trailingAnchor.constraint(equalTo: completeButton.leadingAnchor, constant: 70),
            subStackView.topAnchor.constraint(equalTo: subView.topAnchor, constant: 10),
            subStackView.bottomAnchor.constraint(equalTo: subView.bottomAnchor ,constant: -10),
            subStackView.heightAnchor.constraint(equalToConstant: 15),
            
            completeButton.topAnchor.constraint(equalTo: subView.topAnchor, constant: 10),
            completeButton.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -10),
            completeButton.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -10),
            completeButton.heightAnchor.constraint(equalToConstant: 15)
            
        ])
        mainView.setContentCompressionResistancePriority(.init(rawValue: 752), for: .horizontal)
    }
    
    // 기본 UI 설정
    func configureUI() {
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 25
        
        updateButton.clipsToBounds = true
        deleteButton.clipsToBounds = true
        completeButton.clipsToBounds = true
    }
    
    // (퀘스트) 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        questTitle.text = questData?.quest
        
        // ⭐️요일 버튼 눌렀을때 반응 넣기
        
    }
    
    // 버튼이 눌리면 updateButtonPressed변수에 들어있는 클로저 실행
    @objc func updateButtonTapped(_ sender: UIButton)
        {
        updateButtonPressed(self)
    }
    
    // 버튼이 눌리면 deleteButtonPressed변수에 들어있는 클로저 실행
    @objc func deleteButtonTapped(_ sender: UIButton)
        {
        deleteButtonPressed(self)
    }
    
    // 버튼이 눌리면 completeButtonPressed변수에 들어있는 클로저 실행
    @objc func completeButtonTapped(_ sender: UIButton)
        {
        completeButtonPressed(self)
    }
    
}
