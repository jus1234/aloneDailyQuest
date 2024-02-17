//
//  DetailView.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 12/1/2024.
//

import UIKit

final class DetailView: UIView {

    // MARK: - 프로필 부분
    lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_profile_background")
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_profile_Lv1-10")
        return view
    }()
    
    lazy var nickNameTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.44, green: 0.22, blue: 0.04, alpha: 1.00)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "닉네임", attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        return label
    }()
    
    lazy var nickNameText: UILabel = {
        let label = UILabel()
        label.text = "매튜"
        return label
    }()
    
//    lazy var nickNameStackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [nickNameTitleLabel, nickNameText])
//        stack.spacing = 10
//        stack.axis = .horizontal
//        stack.distribution = .fill
//        stack.alignment = .fill
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
    
    lazy var levelTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.44, green: 0.22, blue: 0.04, alpha: 1.00)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "레벨", attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        return label
    }()
    
    lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "LV.1"
        return label
    }()
//
//    lazy var levelStackView: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [levelTitleLabel, levelLabel])
//        stack.spacing = 20
//        stack.axis = .horizontal
//        stack.distribution = .fillEqually
//        stack.alignment = .fill
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
    
    lazy var firstStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImage, nickNameTitleLabel, nickNameText, levelTitleLabel, levelLabel])
        stack.spacing = 15
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 3.5
        view.layer.borderColor = CGColor(red: 0.90, green: 0.83, blue: 0.74, alpha: 1.00)
        return view
    }()
    
    lazy var experienceTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.44, green: 0.22, blue: 0.04, alpha: 1.00)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "경험치", attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        return label
    }()
    
    lazy var experienceBar: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_level_bar")
        let attrString = NSAttributedString(
            string: "0/10",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 16)
            ]
        )
        view.layer.backgroundColor = UIColor(red: 0.261, green: 0.872, blue: 0.248, alpha: 1).cgColor
        view.accessibilityAttributedLabel = attrString
        return view
    }()
    
    lazy var secondStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [experienceTitleLabel, experienceBar])
        stack.spacing = 12
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var allStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [firstStackView, secondStackView])
        stack.spacing = 16
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - 퀘스트 생성 파트

    let basicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.backgroundColor = UIColor(red: 0.997, green: 0.897, blue: 0.786, alpha: 1).cgColor
        return view
    }()
    
    let questLabel: UILabel = {
        let label = UILabel()
        label.text = "퀘스트 내용"
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let secondView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.backgroundColor = UIColor(red: 1, green: 0.941, blue: 0.859, alpha: 1).cgColor
        return view
    }()
    
    let questTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.isSelectable = true
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    let thirdView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.backgroundColor = UIColor(red: 0.997, green: 0.897, blue: 0.786, alpha: 1).cgColor
        return view
    }()
    
    let repeatLabel: UILabel = {
        let label = UILabel()
        label.text = "반복설정"
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fourthView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.backgroundColor = UIColor(red: 1, green: 0.941, blue: 0.859, alpha: 1).cgColor
        return view
    }()
    
    let mondayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("월", for: .normal)
        button.tag = 1
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tuesdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("화", for: .normal)
        button.tag = 2
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let wednesdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("수", for: .normal)
        button.tag = 3
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let thursdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("목", for: .normal)
        button.tag = 4
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let fridayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("금", for: .normal)
        button.tag = 5
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let saturdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("토", for: .normal)
        button.tag = 6
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let sundayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("일", for: .normal)
        button.tag = 7
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttons: [UIButton] = [mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton, sundayButton]
        
    
    lazy var buttonStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: buttons)
        stview.spacing = 8
        stview.axis = .horizontal
        stview.distribution = .fillEqually
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 22)
        button.setTitle("퀘스트 생성하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1).cgColor
        button.layer.cornerRadius = 14
        return button
    }()
    
    private lazy var baseStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [firstView, secondView, thirdView, fourthView])
        stview.spacing = 2
        stview.axis = .vertical
        stview.distribution = .fill
        stview.alignment = .fill
        stview.translatesAutoresizingMaskIntoConstraints = false
        return stview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
        
        profileAutoLayout()
        addsubviews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var firstHeightConstraint: CGFloat = 26
    var secondHeightConstraint: CGFloat = 18
    var trailingAnchorConstraint: CGFloat = -4
    
    func profileAutoLayout() {
        self.addSubview(backgroundView)
        backgroundView.addSubview(allStackView)
        backgroundView.addSubview(separatorView)
        allStackView.addSubview(firstStackView)
        allStackView.addSubview(secondStackView)
        firstStackView.addSubview(profileImage)
        firstStackView.addSubview(nickNameTitleLabel)
        firstStackView.addSubview(levelTitleLabel)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        nickNameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        levelTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingAnchorConstraint),
            backgroundView.heightAnchor.constraint(equalToConstant: 100),
            
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            separatorView.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 6),
            separatorView.leadingAnchor.constraint(equalTo: firstStackView.leadingAnchor, constant: 0),
            separatorView.trailingAnchor.constraint(equalTo: firstStackView.trailingAnchor, constant: 0),
            
            profileImage.widthAnchor.constraint(equalToConstant: firstHeightConstraint),
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor),
            
            nickNameTitleLabel.widthAnchor.constraint(equalToConstant: 50),
            
            levelLabel.widthAnchor.constraint(equalToConstant: 35),
            levelTitleLabel.widthAnchor.constraint(equalTo: levelLabel.widthAnchor),
            
            
            
            firstStackView.heightAnchor.constraint(equalToConstant: firstHeightConstraint),
            secondStackView.heightAnchor.constraint(equalToConstant: secondHeightConstraint),
            
           
            allStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            allStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 30),
            allStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -30)
        ])
        
        
    }
    
    func addsubviews() {
        self.addSubview(basicView)
        
        basicView.addSubview(baseStackView)
        
        baseStackView.addSubview(firstView)
        baseStackView.addSubview(secondView)
        baseStackView.addSubview(thirdView)
        baseStackView.addSubview(fourthView)
        
        firstView.addSubview(questLabel)
        secondView.addSubview(questTextView)
        thirdView.addSubview(repeatLabel)
        fourthView.addSubview(buttonStackView)
        
        self.addSubview(saveButton)
    }
    
    
    var stackViewleadingConstraint: CGFloat = 20
    
    
    
    func setupUI() {
        // 베이스 뷰 오토레이아웃
        NSLayoutConstraint.activate([
            // topanchor은 추후에 프로필바 추가 되면 수정 해야함
            basicView.topAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: 20),
            basicView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            basicView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            
            baseStackView.topAnchor.constraint(equalTo: basicView.topAnchor, constant: 0),
            baseStackView.bottomAnchor.constraint(equalTo: basicView.bottomAnchor, constant: 0),
            baseStackView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 0),
            baseStackView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: 0)
        ])
        
        // 각 스택뷰마다 오토레이아웃 설정
        NSLayoutConstraint.activate([
            
            firstView.heightAnchor.constraint(equalToConstant: 40),
            secondView.heightAnchor.constraint(equalToConstant: 84),
            thirdView.heightAnchor.constraint(equalToConstant: 40),
            fourthView.heightAnchor.constraint(equalToConstant: 70),
            
            questLabel.heightAnchor.constraint(equalToConstant: 20),
            questLabel.widthAnchor.constraint(equalToConstant: 90),
            questLabel.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 15),
            questLabel.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: stackViewleadingConstraint),
            
            questTextView.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 10),
            questTextView.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 10),
            questTextView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: stackViewleadingConstraint),
            questTextView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -stackViewleadingConstraint),
            
            repeatLabel.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: stackViewleadingConstraint),
            repeatLabel.heightAnchor.constraint(equalToConstant: 16),
            repeatLabel.widthAnchor.constraint(equalToConstant: 64),
            repeatLabel.centerYAnchor.constraint(equalTo: thirdView.centerYAnchor),
            
            buttonStackView.topAnchor.constraint(equalTo: fourthView.topAnchor, constant: 17),
            buttonStackView.heightAnchor.constraint(equalToConstant: 40),
            buttonStackView.leadingAnchor.constraint(equalTo: fourthView.leadingAnchor, constant: stackViewleadingConstraint),
            buttonStackView.trailingAnchor.constraint(equalTo: fourthView.trailingAnchor, constant: -stackViewleadingConstraint)
        ])
       
        // 세이브 버튼 오토레이아웃 설정
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: basicView.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 300),
            saveButton.heightAnchor.constraint(equalToConstant: 64)
        ])
        
    }
}
