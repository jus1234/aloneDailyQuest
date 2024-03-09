//
//  tabView.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 2/28/24.
//

import UIKit

class TabView: UIStackView {
    
    weak var delegate: delegateViewController?
    
    lazy var questLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 77, height: 14)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        var shadow = NSShadow()
        shadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        shadow.shadowOffset = CGSize(width: -1.5, height: 1.5)
        shadow.shadowBlurRadius = 0
        
        let attrString = NSAttributedString(
            string: "일일퀘스트",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 16) ?? UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.strokeWidth: -3.0,
                NSAttributedString.Key.shadow: shadow
            ]
        )
        label.attributedText = attrString
        return label
    }()
    
    lazy var questButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_questList_normal"), for: .normal)
        button.isUserInteractionEnabled = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return button
    }()
    
    lazy var questStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [questButton, questLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    lazy var rankListLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 77, height: 14)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        var shadow = NSShadow()
        shadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        shadow.shadowOffset = CGSize(width: -1.5, height: 1.5)
        shadow.shadowBlurRadius = 0
        
        let attrString = NSAttributedString(
            string: "월드랭킹",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 16) ?? UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.strokeWidth: -3.0,
                NSAttributedString.Key.shadow: shadow
            ]
        )
        label.attributedText = attrString
        return label
    }()
    
    lazy var rankListButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_rankList_normal"), for: .normal)
        button.isUserInteractionEnabled = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return button
    }()
    
    lazy var rankListStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rankListButton, rankListLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 77, height: 14)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        var shadow = NSShadow()
        shadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        shadow.shadowOffset = CGSize(width: -1.5, height: 1.5)
        shadow.shadowBlurRadius = 0
        
        let attrString = NSAttributedString(
            string: "프로필",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 16) ?? UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.strokeWidth: -3.0,
                NSAttributedString.Key.shadow: shadow
            ]
        )
        label.attributedText = attrString
        return label
    }()
    
    lazy var profileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_myhistory_normal"), for: .normal)
        button.isUserInteractionEnabled = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return button
    }()
    
    lazy var profileStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileButton, profileLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addArrangedSubview(questStack)
        addArrangedSubview(rankListStack)
        addArrangedSubview(profileStack)
    }
    
    func setupStackView() {
        self.axis = .horizontal
        self.distribution = .fill
        self.alignment = .center
    }
}
