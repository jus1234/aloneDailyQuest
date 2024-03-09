//
//  QuestView.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 18/2/2024.
//

import UIKit

final class QuestView: UIView {
    

    // MARK: - 프로필 부분
    
    let profileBoxView: UIView = ProfileBoxView()
    let tabView: TabView = TabView()
    weak var delegate: delegateViewController?
    
    let titleText: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        let attrString = NSAttributedString(
            string: "일일퀘스트",
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
    
    private lazy var backgroundBottomImageView: UIImageView = {
        var view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 430, height: 188)
        view.image = UIImage(named: "image_background_bottom")
        return view
    }()
    
    let titleBackgroundText: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        let attrString = NSAttributedString(
            string: "일일퀘스트",
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
    
    // 플러스 버튼 생성
    lazy var plusButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "btn_plus_normal"), for: .normal)
        return button
    }()
    
    // 테이블 뷰 생성
    let tableBackView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
        return view
    }()
    
    
    let tableView: UITableView = {
        var view = UITableView()
        view.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
        return view
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
        
        tableView.reloadData()
        
        addsubViews()
        setupTableView()
        setupProfileConstraints()
        plusButtonConstraints()
        setupQuestViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        tableView.separatorStyle = .none
        // 셀의 등록과정 ⭐️ (코드로 구현)
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
        
    }
    // 플러스 버튼 오토레이아웃
    func plusButtonConstraints() {
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        plusButton.leadingAnchor.constraint(equalTo: titleBackgroundText.trailingAnchor, constant: 60).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        plusButton.centerYAnchor.constraint(equalTo: titleBackgroundText.centerYAnchor).isActive = true
    }
    
//    테이블뷰 자체의 오토레이아웃
    func setupQuestViewConstraints() {
        tableBackView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: profileBoxView.bottomAnchor, constant: 20),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: tabView.topAnchor),
            tableView.widthAnchor.constraint(equalToConstant: 374)
        ])
    }
}
