//
//  LoginView.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 12/1/23.
//

import UIKit

class LoginView: UIView {
    
    lazy var startButton: UIButton = {
        var button = UIButton()
        var label = UILabel()
        button.setBackgroundImage(UIImage(named: "btn_account_normal"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 64)
        let attrString = NSAttributedString(
            string: "시작하기",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 22),
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
    
    lazy var validationText: UILabel = {
        var text = UILabel()
        text.font = UIFont(name: "DungGeunMo", size: 14)
        text.textAlignment = .center
        text.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        text.text = "중복된 닉네임 입니다."
        return text
    }()
    
    lazy var nickNameTextField: UITextField = {
        var tf = UITextField()
        tf.frame = CGRect(x: 0, y: 0, width: 350, height: 50)
        tf.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        tf.textAlignment = .center
        tf.font = UIFont(name: "DungGeunMo", size: 16)
        return tf
    }()
    
    lazy var info2Text: UILabel = {
        var text = UILabel()
        text.frame = CGRect(x: 0, y: 0, width: 222, height: 12)
        text.textColor = UIColor(red: 0.443, green: 0.218, blue: 0.04, alpha: 1)
        text.font = UIFont(name: "DungGeunMo", size: 12)
        text.textAlignment = .left
        text.text = "* 닉네임에는 영문자와 숫자, 한글만 사용할 수 있습니다. \n* 닉네임은 설정시 변경할 수 없습니다."
        text.numberOfLines = 0
        text.setLineSpacing(spacing: 8.0)
        return text
    }()
    
    lazy var infoText: UILabel = {
        var text = UILabel()
        text.frame = CGRect(x: 0, y: 0, width: 279, height: 18)
        text.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        text.font = UIFont(name: "DungGeunMo", size: 18)
        text.textAlignment = .center
        text.text = "사용하실 닉네임을 입력해주세요."
        return text
    }()
    
    private lazy var backgroundBottomImageView: UIImageView = {
        var view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 430, height: 188)
        view.image = UIImage(named: "image_background_bottom")
        return view
    }()
    
    lazy var nickNameImageView: UIImageView = {
        var view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 394, height: 204)
        view.image = UIImage(named: "img_account_background")
        return view
    }()
    
    var logoText: UILabel = {
        var label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 80)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        let attrString = NSAttributedString(
            string: "나혼자만\n일일퀘스트",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 40),
                NSAttributedString.Key.strokeWidth: -2.5
            ]
        )
        label.attributedText = attrString
        return label
    }()
    
    var logoBackgroundText: UILabel = {
        var label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 80)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        let attrString = NSAttributedString(
            string: "나혼자만\n일일퀘스트",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.128, green: 0.345, blue: 0.345, alpha: 1),
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 40),
                NSAttributedString.Key.strokeWidth: -2.5
            ]
        )
        label.attributedText = attrString
        return label
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
        addSubview(logoBackgroundText)
        addSubview(logoText)
        addSubview(backgroundBottomImageView)
        addSubview(nickNameImageView)
        addSubview(nickNameTextField)
        addSubview(infoText)
        addSubview(info2Text)
        addSubview(validationText)
        addSubview(startButton)
        
    }
    func autoLayoutConstraints() {
//        self.back
        logoText.translatesAutoresizingMaskIntoConstraints = false
        logoBackgroundText.translatesAutoresizingMaskIntoConstraints = false
        backgroundBottomImageView.translatesAutoresizingMaskIntoConstraints = false
        nickNameImageView.translatesAutoresizingMaskIntoConstraints = false
        infoText.translatesAutoresizingMaskIntoConstraints = false
        info2Text.translatesAutoresizingMaskIntoConstraints = false
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        validationText.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        logoText.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoText.heightAnchor.constraint(equalToConstant: 80).isActive = true
        logoText.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoText.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        
        logoBackgroundText.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoBackgroundText.heightAnchor.constraint(equalToConstant: 80).isActive = true
        logoBackgroundText.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -3).isActive = true
        logoBackgroundText.topAnchor.constraint(equalTo: topAnchor, constant: 103).isActive = true
        
        backgroundBottomImageView.widthAnchor.constraint(equalToConstant: 430).isActive = true
        backgroundBottomImageView.heightAnchor.constraint(equalToConstant: 188).isActive = true
        backgroundBottomImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        nickNameImageView.widthAnchor.constraint(equalToConstant: 394).isActive = true
        nickNameImageView.heightAnchor.constraint(equalToConstant: 204).isActive = true
        nickNameImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nickNameImageView.topAnchor.constraint(equalTo: logoBackgroundText.bottomAnchor, constant: 60).isActive = true
        
        infoText.widthAnchor.constraint(equalToConstant: 279).isActive = true
        infoText.heightAnchor.constraint(equalToConstant: 18).isActive = true
        infoText.topAnchor.constraint(equalTo: nickNameImageView.topAnchor, constant: 20).isActive = true
        infoText.centerXAnchor.constraint(equalTo: nickNameImageView.centerXAnchor).isActive = true
        
        info2Text.widthAnchor.constraint(equalToConstant: 324).isActive = true
        info2Text.heightAnchor.constraint(equalToConstant: 50).isActive = true
        info2Text.topAnchor.constraint(equalTo: nickNameImageView.topAnchor, constant: 40).isActive = true
        info2Text.centerXAnchor.constraint(equalTo: nickNameImageView.centerXAnchor).isActive = true
        
        nickNameTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        nickNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nickNameTextField.topAnchor.constraint(equalTo: nickNameImageView.topAnchor, constant: 96).isActive = true
        nickNameTextField.centerXAnchor.constraint(equalTo: nickNameImageView.centerXAnchor).isActive = true
        
        validationText.topAnchor.constraint(equalTo: nickNameImageView.topAnchor, constant: 156).isActive = true
        validationText.centerXAnchor.constraint(equalTo: nickNameImageView.centerXAnchor).isActive = true
        
        startButton.topAnchor.constraint(equalTo: nickNameImageView.bottomAnchor, constant: 34).isActive = true
        startButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}


extension UILabel {
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }

        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}
