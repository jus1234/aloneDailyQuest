//
//  DetailView.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 12/1/2024.
//

import UIKit

final class DetailView: UIView {

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
        button.titleLabel?.text = "월"
        button.tag = 1
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 0.996, green: 0.898, blue: 0.784, alpha: 1)
        return button
    }()
    
    let tuesdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.text = "화"
        button.tag = 2
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 0.996, green: 0.898, blue: 0.784, alpha: 1)
        return button
    }()
    
    let wednesdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.text = "수"
        button.tag = 3
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 0.996, green: 0.898, blue: 0.784, alpha: 1)
        return button
    }()
    
    let thursdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.text = "목"
        button.tag = 4
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 0.996, green: 0.898, blue: 0.784, alpha: 1)
        return button
    }()
    
    let fridayButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.text = "금"
        button.tag = 5
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 0.996, green: 0.898, blue: 0.784, alpha: 1)
        return button
    }()
    
    let saturdayButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.text = "토"
        button.tag = 6
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 0.996, green: 0.898, blue: 0.784, alpha: 1)
        return button
    }()
    
    let sundayButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.text = "일"
        button.tag = 7
        button.titleLabel?.font = UIFont(name: "DungGeunMo-Regular", size: 14)
        button.backgroundColor = UIColor(red: 0.996, green: 0.898, blue: 0.784, alpha: 1)
        return button
    }()
    
    lazy var buttons: [UIButton] = [mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton, sundayButton]
    
    lazy var buttonStackView: UIStackView = {
        let stview = UIStackView(arrangedSubviews: buttons)
        stview.spacing = 10
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
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(basicView)
        
        NSLayoutConstraint.activate([
            // topanchor은 추후에 프로필바 추가 되면 수정 해야함
            basicView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            basicView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: 34),
            basicView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            basicView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25)
        ])
        self.basicView.addSubview(baseStackView)
        
        self.firstView.addSubview(questLabel)
        self.secondView.addSubview(questTextView)
        self.thirdView.addSubview(repeatLabel)
        self.fourthView.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            questLabel.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 20),
            questTextView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 20),
            repeatLabel.leadingAnchor.constraint(equalTo: thirdView.leadingAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: fourthView.leadingAnchor, constant: 20)
        ])
    }
}
