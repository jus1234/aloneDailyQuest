//
//  LoginView.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 12/1/23.
//

import UIKit

class LoginView: UIView {

    private lazy var backgroundBottomImageView: UIImageView = {
        var view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 430, height: 188)
        view.image = UIImage(named: "image_background_bottom")
        return view
    }()
    
    var nickNameTextField: UITextField = {
        var tf = UITextField()
        return tf
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
        addSubview(nickNameTextField)
    }
    func autoLayoutConstraints() {
        logoText.translatesAutoresizingMaskIntoConstraints = false
        logoBackgroundText.translatesAutoresizingMaskIntoConstraints = false
        backgroundBottomImageView.translatesAutoresizingMaskIntoConstraints = false
        
        logoText.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoText.heightAnchor.constraint(equalToConstant: 80).isActive = true
        logoText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 117).isActive = true
        logoText.topAnchor.constraint(equalTo: topAnchor, constant: 130).isActive = true
        
        logoBackgroundText.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoBackgroundText.heightAnchor.constraint(equalToConstant: 80).isActive = true
        logoBackgroundText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 114).isActive = true
        logoBackgroundText.topAnchor.constraint(equalTo: topAnchor, constant: 133).isActive = true
        
        backgroundBottomImageView.widthAnchor.constraint(equalToConstant: 430).isActive = true
        backgroundBottomImageView.heightAnchor.constraint(equalToConstant: 188).isActive = true
        backgroundBottomImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
