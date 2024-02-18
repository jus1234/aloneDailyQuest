//
//  SettingView.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 2/6/24.
//

import UIKit

class ProfileView: UIView {
    
    let profileBoxView: UIView = ProfileBoxView()
    
    private lazy var backgroundBottomImageView: UIImageView = {
        var view = UIImageView()

        view.image = UIImage(named: "image_background_bottom")
        return view
    }()
    
    let titleText: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        let attrString = NSAttributedString(
            string: "프로필",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 40) ?? UIFont.systemFont(ofSize: 40),
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
            string: "프로필",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.128, green: 0.345, blue: 0.345, alpha: 1),
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 40) ?? UIFont.systemFont(ofSize: 40),
                NSAttributedString.Key.strokeWidth: -2.5
            ]
        )
        label.attributedText = attrString
        return label
    }()
    
    let monthlyButton: UIButton = {
        let button = UIButton()
        button.setTitle("6개월간", for: .normal)
        button.isSelected = true
        button.setTitleFont(font: UIFont(name: "DungGeunMo", size: 16) ?? UIFont.systemFont(ofSize: 40))
        button.setTitleColor(UIColor(hexCode: "000000", alpha: 1), for: .selected)
        button.setTitleColor(UIColor(hexCode: "CEB291", alpha: 1), for: .normal)
        button.titleLabel?.attributedText = NSMutableAttributedString(string: "6개월간", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func selectButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()

        if sender.isSelected {
            print("버튼이 선택되었습니다.")
        } else {
            print("버튼이 선택 해제되었습니다.")
        }
    }
    
    let dailyButton: UIButton = {
        let button = UIButton()
        button.setTitle("일별", for: .normal)
        button.isSelected = true
        button.setTitleFont(font: UIFont(name: "DungGeunMo", size: 16) ?? UIFont.systemFont(ofSize: 16))
        button.setTitleColor(UIColor(hexCode: "000000", alpha: 1), for: .selected)
        button.setTitleColor(UIColor(hexCode: "CEB291", alpha: 1), for: .normal)
        button.titleLabel?.attributedText = NSMutableAttributedString(string: "일별", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func viewTapped(_ rootView: UIView) {
            let view = UIImageView()
            let label = UILabel()
            label.textAlignment = .center
            let attrString = NSAttributedString(
                string: "60xp",
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor(hexCode: "A04802", alpha: 1),
                    NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14),
                ]
            )
            label.attributedText = attrString
            
            view.addSubview(label)
            view.contentMode = .center
            view.image = UIImage(named: "img_background_histoty_xp")
            
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            
        print(rootView.centerXAnchor)
        print(rootView.topAnchor)
//            view.centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
//            view.bottomAnchor.constraint(equalTo: rootView.topAnchor).isActive = true
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 11).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14).isActive = true
    }
    
    lazy var xpBar1View: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_greenXpBar_background")
        view.contentMode = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var xpBar2View: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_greenXpBar_background")
        view.contentMode = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var xpBar3View: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_greenXpBar_background")
        view.contentMode = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var xpBar4View: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_greenXpBar_background")
        view.contentMode = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var xpBar5View: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_greenXpBar_background")
        view.contentMode = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var xpBar6View: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_greenXpBar_background")
        view.contentMode = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var xpBar7View: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_greenXpBar_background")
        view.contentMode = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var centerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [xpBar1View, xpBar2View, xpBar3View, xpBar4View, xpBar5View, xpBar6View, xpBar7View])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    lazy var topStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [dailyButton, monthlyButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_background_history")

        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        autoLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(profileBoxView)
        addSubview(backgroundBottomImageView)
        addSubview(titleBackgroundText)
        addSubview(titleText)
        addSubview(backgroundView)
        addSubview(topStackView)
        addSubview(centerStackView)
    }
    
    func autoLayoutConstraints() {
        profileBoxView.translatesAutoresizingMaskIntoConstraints = false
        backgroundBottomImageView.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleBackgroundText.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        centerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        centerStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor).isActive = true
        centerStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 6).isActive = true
        centerStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        centerStackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        topStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        topStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: profileBoxView.bottomAnchor, constant: 20).isActive = true
        backgroundView.widthAnchor.constraint(equalToConstant: 374).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 404).isActive = true
        
        profileBoxView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileBoxView.topAnchor.constraint(equalTo: titleBackgroundText.bottomAnchor, constant: 20).isActive = true
        profileBoxView.widthAnchor.constraint(equalToConstant: 500).isActive = true
        profileBoxView.heightAnchor.constraint(equalToConstant: 104).isActive = true
        
        titleText.widthAnchor.constraint(equalToConstant: 144).isActive = true
        titleText.heightAnchor.constraint(equalToConstant: 63).isActive = true
        titleText.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleText.topAnchor.constraint(equalTo: topAnchor, constant: 63).isActive = true
        
        titleBackgroundText.widthAnchor.constraint(equalToConstant: 144).isActive = true
        titleBackgroundText.heightAnchor.constraint(equalToConstant: 66).isActive = true
        titleBackgroundText.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -3).isActive = true
        titleBackgroundText.topAnchor.constraint(equalTo: topAnchor, constant: 66).isActive = true
        
        backgroundBottomImageView.widthAnchor.constraint(equalToConstant: 430).isActive = true
        backgroundBottomImageView.heightAnchor.constraint(equalToConstant: 188).isActive = true
        backgroundBottomImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
