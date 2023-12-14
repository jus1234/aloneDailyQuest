//
//  ProfileCell.swift
//  AloneDailyQuest_Project
//
//  Created by Joy Kim on 2023/12/16.
//

import UIKit

class ProfileTableCell: UITableViewCell {

    let mainIconView: UIImageView = {
        let iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        return iconView
    }()
    
    let profileMenuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution  = .fill
        sv.alignment = .fill
        sv.spacing = 8
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupStackView()
        
        // 셀 오토레이아웃 일반적으로 생성자에서 잡으면 됨 ⭐️⭐️⭐️
        setConstraints()
    }
    
    func setupStackView() {
        
        // self.addSubview보다 self.contentView.addSubview로 잡는게 더 정확함 ⭐️
        // (cell은 기본뷰로 contentView를 가지고 있기 때문)
        self.contentView.addSubview(mainIconView)
        //self.addSubview(mainImageView)
        
        // self.contentView.addSubview로 잡는게 더 정확함 ⭐️
        self.contentView.addSubview(stackView)
        //self.addSubview(stackView)
        
        // 스택뷰 위에 뷰들 올리기
        stackView.addArrangedSubview(profileMenuLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 오토레이아웃 재계산 시점 (뷰가 변하는 경우) ===> 일반적으로 생성자에서 잡으면 됨 ⭐️⭐️⭐️
//    override func updateConstraints() {
//        setConstraints()
//        super.updateConstraints()
//    }
    
    func setConstraints() {
        setMainIconViewConstraints()
        setProfileMenuLabelConstraints()
        setStackViewConstraints()
    }
    
    func setMainIconViewConstraints() {
        
        NSLayoutConstraint.activate([
            mainIconView.heightAnchor.constraint(equalToConstant: 100),
            mainIconView.widthAnchor.constraint(equalToConstant: 100),
            
            // self.leadingAnchor로 잡는 것보다 self.contentView.leadingAnchor로 잡는게 더 정확함 ⭐️
            // (cell은 기본뷰로 contentView를 가지고 있기 때문)
            mainIconView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            mainIconView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    func setProfileMenuLabelConstraints() {
        profileMenuLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileMenuLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: mainIconView.trailingAnchor, constant: 15),
            
            // self.trailingAnchor로 잡는 것보다 self.contentView.trailingAnchor로 잡는게 더 정확함 ⭐️
            // (cell은 기본뷰로 contentView를 가지고 있기 때문)
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.mainIconView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.mainIconView.bottomAnchor)
        ])
    }
}

