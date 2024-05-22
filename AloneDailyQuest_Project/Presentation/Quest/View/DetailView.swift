//
//  DetailView.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 12/1/2024.
//

import UIKit

final class DetailView: UIView {

    // MARK: - 프로필 부분
    
    let profileBoxView: ProfileBoxView = ProfileBoxView()
    
    let titleText: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        let attrString = NSAttributedString(
            string: "퀘스트생성",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 30) ?? UIFont.systemFont(ofSize: 30),
                NSAttributedString.Key.strokeWidth: -2.5
            ]
        )
        label.attributedText = attrString
        return label
    }()
    
    let titleBackgroundText: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        let attrString = NSAttributedString(
            string: "퀘스트생성",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.128, green: 0.345, blue: 0.345, alpha: 1),
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 30) ?? UIFont.systemFont(ofSize: 30),
                NSAttributedString.Key.strokeWidth: -2.5
            ]
        )
        label.attributedText = attrString
        return label
    }()
    
    private lazy var backgroundBottomImageView: UIImageView = {
        var view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 430, height: 188)
        view.image = UIImage(named: "image_background_bottom")
        return view
    }()
    
    // MARK: - 퀘스트 생성 파트

    let basicView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_detailquest_background")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let firstView: UIView = {
        let view = UIView()
        return view
    }()
    
    let questLabel: UILabel = {
        let label = UILabel()
        label.text = "퀘스트 내용"
        label.font = UIFont(name: "DungGeunMo", size: 16)
        return label
    }()
    
    let secondView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let questTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.isSelectable = true
        textView.backgroundColor = .white
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor(red: 0.93, green: 0.77, blue: 0.64, alpha: 1.00).cgColor
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()

    let thirdView: UIView = {
        let view = UIView()
        return view
    }()
    
    let repeatLabel: UILabel = {
        let label = UILabel()
        label.text = "반복설정"
        label.font = UIFont(name: "DungGeunMo", size: 16)
       return label
    }()
    
    let fourthView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let mondayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("월", for: .normal)
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleFont(font: UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14))
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        return button
    }()
    
    let tuesdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("화", for: .normal)
        button.tag = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleFont(font: UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14))
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        return button
    }()
    
    let wednesdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("수", for: .normal)
        button.tag = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleFont(font: UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14))
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        return button
    }()
    
    let thursdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("목", for: .normal)
        button.tag = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleFont(font: UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14))
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        return button
    }()
    
    let fridayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("금", for: .normal)
        button.tag = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleFont(font: UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14))
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        return button
    }()
    
    let saturdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("토", for: .normal)
        button.tag = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleFont(font: UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14))
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        return button
    }()
    
    let sundayButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.setTitle("일", for: .normal)
        button.tag = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleFont(font: UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14))
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 1.00, green: 0.90, blue: 0.78, alpha: 1.00)
        return button
    }()
    
    lazy var buttons: [UIButton] = [mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton, sundayButton]
        
    
    lazy var buttonStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: buttons)
        stview.spacing = 8
        stview.axis = .horizontal
        stview.isUserInteractionEnabled = true
        stview.distribution = .fillEqually
        stview.alignment = .fill
        return stview
    }()
    
    private lazy var baseStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: [firstView, secondView, thirdView, fourthView])
        stview.spacing = 2
        stview.axis = .vertical
        stview.distribution = .fill
        stview.alignment = .fill
        return stview
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        var label = UILabel()
        button.setBackgroundImage(UIImage(named: "btn_account_normal"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 64)
        let attrString = NSAttributedString(
            string: "퀘스트 저장하기",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 22) ?? UIFont.systemFont(ofSize: 22),
                NSAttributedString.Key.strokeWidth: -2.0
                
            ]
        )
        button.setAttributedTitle(attrString, for: .normal)
        button.titleLabel!.layer.shadowColor = UIColor.black.cgColor
        button.titleLabel!.layer.shadowOffset = CGSize(width: -2.0, height: 2.0)
        button.titleLabel!.layer.shadowOpacity = 1.0
        button.titleLabel!.layer.shadowRadius = 0
        button.titleLabel!.layer.masksToBounds = false
        return button
    }()
    
    lazy var backButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "btn_back_normal"), for: .normal)
        button.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        return button
    }()
    
    var didBackButtonTap: Observable<Void> = Observable(())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
        
        addsubviews()
        profileAutoLayout()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapBackButton() {
        didBackButtonTap.value = ()
    }
    
    func addsubviews() {
        
        addSubview(profileBoxView)
        addSubview(titleBackgroundText)
        addSubview(titleText)
        addSubview(backgroundBottomImageView)
        addSubview(backButton)
        
        addSubview(basicView)
        
        basicView.addSubview(baseStackView)
        
        baseStackView.addSubview(firstView)
        baseStackView.addSubview(secondView)
        baseStackView.addSubview(thirdView)
        baseStackView.addSubview(fourthView)
        
        firstView.addSubview(questLabel)
        secondView.addSubview(questTextView)
        thirdView.addSubview(repeatLabel)
        fourthView.addSubview(buttonStackView)
        
        addSubview(saveButton)
    }
    
    func profileAutoLayout() {
        profileBoxView.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleBackgroundText.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        titleText.widthAnchor.constraint(equalToConstant: 153).isActive = true
        titleText.heightAnchor.constraint(equalToConstant: 33).isActive = true
        titleText.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleText.topAnchor.constraint(equalTo: topAnchor, constant: 63).isActive = true
        
        titleBackgroundText.widthAnchor.constraint(equalToConstant: 153).isActive = true
        titleBackgroundText.heightAnchor.constraint(equalToConstant: 33).isActive = true
        titleBackgroundText.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -3).isActive = true
        titleBackgroundText.topAnchor.constraint(equalTo: topAnchor, constant: 66).isActive = true
        
        profileBoxView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileBoxView.topAnchor.constraint(equalTo: titleBackgroundText.bottomAnchor, constant: 20).isActive = true
        profileBoxView.widthAnchor.constraint(equalToConstant: 500).isActive = true
        profileBoxView.heightAnchor.constraint(equalToConstant: 104).isActive = true
        
        backButton.centerYAnchor.constraint(equalTo: titleText.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    }

    func setupUI() {
        // 베이스 뷰 오토레이아웃
        basicView.translatesAutoresizingMaskIntoConstraints = false
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        backgroundBottomImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            basicView.topAnchor.constraint(equalTo: profileBoxView.bottomAnchor, constant: 40),
            basicView.heightAnchor.constraint(equalToConstant: 264),
            basicView.widthAnchor.constraint(equalToConstant: 374),
            basicView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            baseStackView.centerXAnchor.constraint(equalTo: basicView.centerXAnchor),
            baseStackView.centerYAnchor.constraint(equalTo: basicView.centerYAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 20),
            baseStackView.topAnchor.constraint(equalTo: basicView.topAnchor, constant: 0),
//            baseStackView.widthAnchor.constraint(equalToConstant: 328)
        ])
        
        // 각 스택뷰마다 오토레이아웃 설정
        questLabel.translatesAutoresizingMaskIntoConstraints = false
        questTextView.translatesAutoresizingMaskIntoConstraints = false
        repeatLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstView.heightAnchor.constraint(equalToConstant: 41),
            questLabel.heightAnchor.constraint(equalToConstant: 16),
            questLabel.widthAnchor.constraint(equalToConstant: 88),
            questLabel.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 15),
            questLabel.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 0),
            
            
            questTextView.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 10),
            questTextView.centerYAnchor.constraint(equalTo: secondView.centerYAnchor),
            questTextView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 0),
            questTextView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: 0),
            secondView.heightAnchor.constraint(equalToConstant: 94),
            
            repeatLabel.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 0),
            repeatLabel.topAnchor.constraint(equalTo: thirdView.topAnchor, constant: 12),
            repeatLabel.heightAnchor.constraint(equalToConstant: 16),
            repeatLabel.widthAnchor.constraint(equalToConstant: 64),
            repeatLabel.centerYAnchor.constraint(equalTo: thirdView.centerYAnchor),
            
            buttonStackView.topAnchor.constraint(equalTo: fourthView.topAnchor, constant: 15),
            buttonStackView.bottomAnchor.constraint(equalTo: fourthView.bottomAnchor, constant: -28),
            buttonStackView.centerXAnchor.constraint(equalTo: fourthView.centerXAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: fourthView.leadingAnchor, constant: 0)
        ])
       
        // 세이브 버튼 오토레이아웃 설정
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: basicView.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 300),
            saveButton.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        backgroundBottomImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundBottomImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundBottomImageView.heightAnchor.constraint(equalToConstant: 188).isActive = true
        backgroundBottomImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
