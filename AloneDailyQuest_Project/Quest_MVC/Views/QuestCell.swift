//
//  QuestCell.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 12/1/2024.
//

import UIKit

final class QuestCell: UITableViewCell {

    // MARK: - UI 설정 (퀘스트🍎윗부분 🍏아랫부분)

    let backView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "img_quest_background")
        return view
    }()
    
    // 🍎(이미지, 퀘스트 내용, 업데이트 버튼, 삭제 버튼)
    let firstView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 퀘스트 이미지
    var questImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img_quest_ing")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // 퀘스트 타이틀
    var questTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 14)
        return label
    }()
    
    // 업데이트 버튼
    lazy var updateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "btn_edit_normal"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // 삭제 버튼
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "btn_delete_normal"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [updateButton, deleteButton])
        stview.spacing = 10
        stview.axis = .horizontal
        stview.distribution = .fillEqually
        stview.alignment = .fill
        stview.isUserInteractionEnabled = true
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    
    
    
    // 요일반복 레이블
    let repeatday: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "매일 반복"
        label.font = UIFont(name: "DungGeunMo", size: 14)
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
        button.setTitleFont(font: UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14))
        button.setTitle("완료하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var secondStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [repeatday ,expAmount, completeButton])
        stview.axis = .horizontal
        stview.alignment = .fill
        stview.isUserInteractionEnabled = true
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    // 메인뷰랑, 서브뷰 합침
    private lazy var mainStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [firstView, secondStackView])
        stview.spacing = 10
        stview.axis = .vertical
        stview.isUserInteractionEnabled = true
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    // QuestData를 전달받을 변수 (전달 받으면 ==> 표시하는 메서드 실행) ⭐️
    var questData: QuestData? {
        didSet {
            configureUIwithData()
        }
    }
    
//    // (델리게이트 대신에) 실행하고 싶은 클로저 저장
//    // 뷰컨트롤러에 있는 클로저 저장할 예정 (셀(자신)을 전달)
//    var updateButtonPressed: (QuestCell) -> Void = { (sender) in }
//    
//    var deleteButtonPressed: (QuestCell) -> Void = { (sender) in }
//    
//    var completeButtonPressed: (QuestCell) -> Void = { (sender) in }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        
        addsubview()
        setConstraints()
        configureUI()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
   
    
    func addsubview() {
        self.contentView.addSubview(backView)
        backView.addSubview(mainStackView)
        mainStackView.addSubview(firstView)
        mainStackView.addSubview(secondStackView)
        firstView.addSubview(questImage)
        firstView.addSubview(questTitle)
        firstView.addSubview(buttonStackView)
        secondStackView.addSubview(repeatday)
        secondStackView.addSubview(expAmount)
        secondStackView.addSubview(completeButton)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            backView.heightAnchor.constraint(equalToConstant: 134),
            backView.widthAnchor.constraint(equalToConstant: 374),
            backView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            backView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        ])
        
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 0),
            mainStackView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -22)
        ])
        
        NSLayoutConstraint.activate([
            firstView.heightAnchor.constraint(equalToConstant: 88),
            secondStackView.heightAnchor.constraint(equalToConstant: 14),
            
            questImage.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 0),
            questImage.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 15),
            questImage.widthAnchor.constraint(equalToConstant: 50),
            questImage.heightAnchor.constraint(equalToConstant: 50),
            
            questTitle.leadingAnchor.constraint(equalTo: questImage.trailingAnchor, constant: 14),
            questTitle.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 15),
            questTitle.heightAnchor.constraint(equalToConstant: 42),
            questTitle.widthAnchor.constraint(equalToConstant: 200),
            
            buttonStackView.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 15),
            buttonStackView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: 0),
            buttonStackView.heightAnchor.constraint(equalToConstant: 26),
            buttonStackView.widthAnchor.constraint(equalToConstant: 62)
        ])
        
        
        NSLayoutConstraint.activate([
            
            secondStackView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 0),
            
            repeatday.widthAnchor.constraint(equalToConstant: 100),
            repeatday.leadingAnchor.constraint(equalTo: secondStackView.leadingAnchor, constant: 0),
            
            expAmount.widthAnchor.constraint(equalToConstant: 77),
            expAmount.trailingAnchor.constraint(equalTo: completeButton.leadingAnchor, constant: -56),
            
            completeButton.widthAnchor.constraint(equalToConstant: 70),
            completeButton.trailingAnchor.constraint(equalTo: secondStackView.trailingAnchor, constant: 0)
            
        ])
    }
    
    // 기본 UI 설정
    func configureUI() {
        backView.clipsToBounds = true
        
        updateButton.clipsToBounds = true
        deleteButton.clipsToBounds = true
        completeButton.clipsToBounds = true
    }
    
    var repeatLabel = ""
    
    // (퀘스트) 데이터를 가지고 적절한 UI 표시하기
    func configureUIwithData() {
        questTitle.text = questData?.quest
    }
    
    
    
}
