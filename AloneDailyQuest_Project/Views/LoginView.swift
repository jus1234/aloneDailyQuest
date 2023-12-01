//
//  LoginView.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 12/1/23.
//

import UIKit

class LoginView: UIView {

    var logoText: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 80)
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = UIFont(name: "DungGeunMo-Regular", size: 40)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        // Line height: 40 pt
        view.textAlignment = .center
        view.text = "나혼자만\n일일퀘스트"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(logoText)
    }
    func logoTextConstraints() {
        logoText.translatesAutoresizingMaskIntoConstraints = false
        logoText.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoText.heightAnchor.constraint(equalToConstant: 80).isActive = true
        logoText.leadingAnchor.constraint(equalTo: logoText.leadingAnchor, constant: 117).isActive = true
        logoText.topAnchor.constraint(equalTo: logoText.topAnchor, constant: 100).isActive = true
    }
}
