//
//  QuestView.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 18/2/2024.
//

import UIKit

final class QuestView: UIView {
    let profileBoxView: ProfileBoxView = ProfileBoxView()
    let tabView: TabView = TabView()
    
    let titleText: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(hexCode: "ffffff")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        let attrString = NSAttributedString(
            string: "일일퀘스트",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor(hexCode: "000000"),
                NSAttributedString.Key.foregroundColor: UIColor(hexCode: "ffffff"),
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
    
    let titleBackgroundText: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(hexCode: "ffffff")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        let attrString = NSAttributedString(
            string: "일일퀘스트",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor(hexCode: "215858"),
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 30) ?? UIFont.systemFont(ofSize: 30),
                NSAttributedString.Key.strokeWidth: -2.5
            ]
        )
        label.attributedText = attrString
        return label
    }()

    lazy var plusButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "btn_plus_normal"), for: .normal)
        

        return button
    }()
    
    let tableView: UITableView = {
        var view = UITableView()
        view.backgroundColor = UIColor(hexCode: "38C8C8")
        return view
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        tableView.reloadData()
        addsubViews()
        setupTableView()
        setupProfileConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.backgroundColor = UIColor(hexCode: "38C8C8")
    }
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.register(QuestCell.self, forCellReuseIdentifier: "QuestCell")
    }
    
    
    func addsubViews() {
        addSubview(profileBoxView)
        addSubview(titleBackgroundText)
        addSubview(titleText)
        addSubview(plusButton)
        addSubview(tableView)
        addSubview(backgroundBottomImageView)
        addSubview(tabView)
    }
    
    func setupProfileConstraints() {
        backgroundBottomImageView.translatesAutoresizingMaskIntoConstraints = false
        tabView.translatesAutoresizingMaskIntoConstraints = false
        profileBoxView.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleBackgroundText.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundBottomImageView.widthAnchor.constraint(equalToConstant: 430).isActive = true
        backgroundBottomImageView.heightAnchor.constraint(equalToConstant: 188).isActive = true
        backgroundBottomImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        tabView.heightAnchor.constraint(equalToConstant: 146).isActive = true
        tabView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        tabView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tabView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
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
        
        plusButton.leadingAnchor.constraint(equalTo: titleBackgroundText.trailingAnchor, constant: 60).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        plusButton.centerYAnchor.constraint(equalTo: titleBackgroundText.centerYAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: profileBoxView.bottomAnchor, constant: 20).isActive = true
        tableView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: tabView.topAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: 374).isActive = true
        
    }
    
    func configureLabel(nickName: String, level: String) {
        profileBoxView.configureLabel(nickName: nickName, level: level)
    }
    
    func updateExperienceBar(currentExp: Int) {
        profileBoxView.updateExperienceBar(currentExp: currentExp)
    }

}
