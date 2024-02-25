//
//  SettingView.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 2/6/24.
//

import UIKit

class ProfileView: UIView {
    
    var xpList: [Int] = [10, 20, 30, 40, 50, 60, 70]
    
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
            string: "프로필",
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
    
    let monthlyButton: UIButton = {
        let button = UIButton()
        button.setTitle("6개월간", for: .normal)
        button.isSelected = false
        button.setTitleFont(font: UIFont(name: "DungGeunMo", size: 16) ?? UIFont.systemFont(ofSize: 40))
        button.setTitleColor(UIColor(hexCode: "000000", alpha: 1), for: .selected)
        button.setTitleColor(UIColor(hexCode: "CEB291", alpha: 1), for: .normal)
        button.titleLabel?.attributedText = NSMutableAttributedString(string: "6개월간", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.addTarget(self, action: #selector(selectMonthlyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    func startList() {
        dailyButton.isSelected.toggle()
        let listView: [UIStackView] = [xp1StackView, xp2StackView, xp3StackView, xp4StackView, xp5StackView, xp6StackView, xp7StackView]
        
        for view in listView {
            centerStackView.addArrangedSubview(view)
        }
    }
    
    @objc func selectMonthlyButtonTapped(_ sender: UIButton) {
        for button in [monthlyButton, dailyButton] {
            button.isSelected = false
        }
        
        sender.isSelected.toggle()
        
        let deleteListStackView: [UIStackView] = [xp1StackView, xp2StackView, xp3StackView, xp4StackView, xp5StackView, xp6StackView, xp7StackView]
        
        let updateListStackView: [UIStackView] = [xp1StackView, xp2StackView, xp3StackView, xp4StackView, xp5StackView, xp6StackView]
        
        if sender.isSelected {
            deleteStackView(with: deleteListStackView)
            updateStackView(with: updateListStackView)
        }
    }
    
    @objc func selectDailyButtonTapped(_ sender: UIButton) {
        for button in [monthlyButton, dailyButton] {
            button.isSelected = false
        }
        
        sender.isSelected.toggle()
        let deleteListStackView: [UIStackView] = [xp1StackView, xp2StackView, xp3StackView, xp4StackView, xp5StackView, xp6StackView, xp7StackView]
        
        let updateListStackView: [UIStackView] = [xp1StackView, xp2StackView, xp3StackView, xp4StackView, xp5StackView, xp6StackView, xp7StackView]
        
        if sender.isSelected {
            deleteStackView(with: deleteListStackView)
            updateStackView(with: updateListStackView)
        }
    }
    
    func deleteStackView(with views: [UIStackView]) {
        for view in views {
            view.removeFromSuperview()
        }
        guard let currentView = currentXpView, currentView.superview == self else { return }
        currentView.removeFromSuperview()
        currentXpView = nil
    }
    
    func updateStackView(with views: [UIStackView]) {
        for view in views {
            centerStackView.addArrangedSubview(view)
        }
    }
    
    let dailyButton: UIButton = {
        let button = UIButton()
        button.setTitle("일별", for: .normal)
        button.isSelected = false
        button.setTitleFont(font: UIFont(name: "DungGeunMo", size: 16) ?? UIFont.systemFont(ofSize: 16))
        button.setTitleColor(UIColor(hexCode: "000000", alpha: 1), for: .selected)
        button.setTitleColor(UIColor(hexCode: "CEB291", alpha: 1), for: .normal)
        button.titleLabel?.attributedText = NSMutableAttributedString(string: "일별", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.addTarget(self, action: #selector(selectDailyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var currentXpView: UIImageView?
    
    lazy var xp1StackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [xpBar1Button, xpBar1Title])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    lazy var xpBar1Title: UILabel = {
        let label = UILabel()
        label.text = "02.23"
        label.font = UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var xpBar1Button: UIButton = {
        let button = UIButton()
        let backgroungImage = UIImage(named: "img_greenXpBar_background")
        
        let view = UIImageView(image: backgroungImage)
        
        button.addSubview(view)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: CGFloat(xpList[0])).isActive = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: CGFloat(xpList[0])).isActive = true
        view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        
        button.addTarget(self, action: #selector(xp1ViewTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func xp1ViewTapped(_ sender: UIView) {
        if let currentView = currentXpView, currentView.superview == self {
            currentView.removeFromSuperview()
            currentXpView = nil
        } else {
            let view = UIImageView()
            let label = UILabel()
            label.textAlignment = .center
            let attrString = NSAttributedString(
                string: "\(xpList[0])xp",
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
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 11).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14).isActive = true
            
            view.bottomAnchor.constraint(equalTo: sender.topAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: sender.centerXAnchor).isActive = true
            
            currentXpView = view
        }
    }
    
    lazy var xp2StackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [xpBar2Button, xpBar2Title])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    lazy var xpBar2Title: UILabel = {
        let label = UILabel()
        label.text = "02.23"
        label.font = UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var xpBar2Button: UIButton = {
        let button = UIButton()
        let backgroungImage = UIImage(named: "img_greenXpBar_background")
        
        let view = UIImageView(image: backgroungImage)
        
        button.addSubview(view)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: CGFloat(xpList[1])).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: CGFloat(xpList[1])).isActive = true
        view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        
        button.addTarget(self, action: #selector(xp2ViewTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func xp2ViewTapped(_ sender: UIView) {
        if let currentView = currentXpView, currentView.superview == self {
            currentView.removeFromSuperview()
            currentXpView = nil
        } else {
            let view = UIImageView()
            let label = UILabel()
            label.textAlignment = .center
            let attrString = NSAttributedString(
                string: "\(xpList[1])xp",
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
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 11).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14).isActive = true
            
            view.bottomAnchor.constraint(equalTo: sender.topAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: sender.centerXAnchor).isActive = true
            
            currentXpView = view
        }
    }
    
    lazy var xp3StackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [xpBar3Button, xpBar3Title])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    lazy var xpBar3Title: UILabel = {
        let label = UILabel()
        label.text = "02.23"
        label.font = UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var xpBar3Button: UIButton = {
        let button = UIButton()
        let backgroungImage = UIImage(named: "img_greenXpBar_background")
        
        let view = UIImageView(image: backgroungImage)
        
        button.addSubview(view)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: CGFloat(xpList[2])).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: CGFloat(xpList[2])).isActive = true
        view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        
        button.addTarget(self, action: #selector(xp3ViewTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func xp3ViewTapped(_ sender: UIView) {
        if let currentView = currentXpView, currentView.superview == self {
            currentView.removeFromSuperview()
            currentXpView = nil
        } else {
            let view = UIImageView()
            let label = UILabel()
            label.textAlignment = .center
            let attrString = NSAttributedString(
                string: "\(xpList[2])xp",
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
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 11).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14).isActive = true
            
            view.bottomAnchor.constraint(equalTo: sender.topAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: sender.centerXAnchor).isActive = true
            
            currentXpView = view
        }
    }
    
    lazy var xp4StackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [xpBar4Button, xpBar4Title])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    lazy var xpBar4Title: UILabel = {
        let label = UILabel()
        label.text = "02.23"
        label.font = UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var xpBar4Button: UIButton = {
        let button = UIButton()
        let backgroungImage = UIImage(named: "img_greenXpBar_background")
        
        let view = UIImageView(image: backgroungImage)
        
        button.addSubview(view)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: CGFloat(xpList[3])).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: CGFloat(xpList[3])).isActive = true
        view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        
        button.addTarget(self, action: #selector(xp4ViewTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func xp4ViewTapped(_ sender: UIView) {
        if let currentView = currentXpView, currentView.superview == self {
            currentView.removeFromSuperview()
            currentXpView = nil
        } else {
            let view = UIImageView()
            let label = UILabel()
            label.textAlignment = .center
            let attrString = NSAttributedString(
                string: "\(xpList[3])xp",
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
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 11).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14).isActive = true
            
            view.bottomAnchor.constraint(equalTo: sender.topAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: sender.centerXAnchor).isActive = true
            
            currentXpView = view
        }
    }
    
    lazy var xp5StackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [xpBar5Button, xpBar5Title])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    lazy var xpBar5Title: UILabel = {
        let label = UILabel()
        label.text = "02.23"
        label.font = UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var xpBar5Button: UIButton = {
        let button = UIButton()
        let backgroungImage = UIImage(named: "img_greenXpBar_background")
        
        let view = UIImageView(image: backgroungImage)
        
        button.addSubview(view)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: CGFloat(xpList[4])).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: CGFloat(xpList[4])).isActive = true
        view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        
        button.addTarget(self, action: #selector(xp5ViewTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func xp5ViewTapped(_ sender: UIView) {
        if let currentView = currentXpView, currentView.superview == self {
            currentView.removeFromSuperview()
            currentXpView = nil
        } else {
            let view = UIImageView()
            let label = UILabel()
            label.textAlignment = .center
            let attrString = NSAttributedString(
                string: "\(xpList[4])xp",
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
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 11).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14).isActive = true
            
            view.bottomAnchor.constraint(equalTo: sender.topAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: sender.centerXAnchor).isActive = true
            
            currentXpView = view
        }
    }
    
    lazy var xp6StackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [xpBar6Button, xpBar6Title])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    lazy var xpBar6Title: UILabel = {
        let label = UILabel()
        label.text = "02.23"
        label.font = UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var xpBar6Button: UIButton = {
        let button = UIButton()
        let backgroungImage = UIImage(named: "img_greenXpBar_background")
        
        let view = UIImageView(image: backgroungImage)
        
        button.addSubview(view)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: CGFloat(xpList[5])).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: CGFloat(xpList[5])).isActive = true
        view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        
        button.addTarget(self, action: #selector(xp6ViewTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func xp6ViewTapped(_ sender: UIView) {
        if let currentView = currentXpView, currentView.superview == self {
            currentView.removeFromSuperview()
            currentXpView = nil
        } else {
            let view = UIImageView()
            let label = UILabel()
            label.textAlignment = .center
            let attrString = NSAttributedString(
                string: "\(xpList[5])xp",
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
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 11).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14).isActive = true
            
            view.bottomAnchor.constraint(equalTo: sender.topAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: sender.centerXAnchor).isActive = true
            
            currentXpView = view
        }
    }
    
    lazy var xp7StackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [xpBar7Button, xpBar7Title])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    lazy var xpBar7Title: UILabel = {
        let label = UILabel()
        label.text = "02.23"
        label.font = UIFont(name: "DungGeunMo", size: 14) ?? UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    lazy var xpBar7Button: UIButton = {
        let button = UIButton()
        let backgroungImage = UIImage(named: "img_greenXpBar_background")
        
        let view = UIImageView(image: backgroungImage)
        
        button.addSubview(view)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: CGFloat(xpList[6])).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: CGFloat(xpList[6])).isActive = true
        view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        
        button.addTarget(self, action: #selector(xp7ViewTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func xp7ViewTapped(_ sender: UIView) {
        if let currentView = currentXpView, currentView.superview == self {
            currentView.removeFromSuperview()
            currentXpView = nil
        } else {
            let view = UIImageView()
            let label = UILabel()
            label.textAlignment = .center
            let attrString = NSAttributedString(
                string: "\(xpList[6])xp",
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
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 11).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14).isActive = true
            
            view.bottomAnchor.constraint(equalTo: sender.topAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: sender.centerXAnchor).isActive = true
            
            currentXpView = view
        }
    }
    
    lazy var centerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .bottom
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
        view.contentMode = .scaleAspectFit
        return view
    }()

    let customButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.setTitle("문의하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "DungGeunMo", size: 16) ?? UIFont.systemFont(ofSize: 16)
        
        button.setImage(UIImage(named: "btn_arrow_normal"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 320, bottom: 0, right: 0)

        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func buttonTapped() {
        print("Button tapped")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        autoLayoutConstraints()
        startList()
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
        addSubview(customButton)
    }
    
    func autoLayoutConstraints() {
        profileBoxView.translatesAutoresizingMaskIntoConstraints = false
        backgroundBottomImageView.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleBackgroundText.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        centerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        customButton.topAnchor.constraint(equalTo: centerStackView.bottomAnchor, constant: 30).isActive = true
        customButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20).isActive = true
        customButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20).isActive = true
        customButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20).isActive = true
        
        centerStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor).isActive = true
        centerStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 6).isActive = true
        centerStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        centerStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -76).isActive = true
        
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
        
        titleText.widthAnchor.constraint(equalToConstant: 123).isActive = true
        titleText.heightAnchor.constraint(equalToConstant: 33).isActive = true
        titleText.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleText.topAnchor.constraint(equalTo: topAnchor, constant: 63).isActive = true
        
        titleBackgroundText.widthAnchor.constraint(equalToConstant: 123).isActive = true
        titleBackgroundText.heightAnchor.constraint(equalToConstant: 33).isActive = true
        titleBackgroundText.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -3).isActive = true
        titleBackgroundText.topAnchor.constraint(equalTo: topAnchor, constant: 66).isActive = true
        
        backgroundBottomImageView.widthAnchor.constraint(equalToConstant: 430).isActive = true
        backgroundBottomImageView.heightAnchor.constraint(equalToConstant: 188).isActive = true
        backgroundBottomImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
