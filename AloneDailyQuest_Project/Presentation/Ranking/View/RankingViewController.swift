//
//  RankingViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 3/24/24.
//

import UIKit
import SwiftUI

class RankingViewController: UIViewController {
    
    let rankingView: UIView = RankingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = rankingView
        configureUI()
    }
    
    func configureUI() {
        rankingView.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
    }

}

//struct MyViewController_PreViews: PreviewProvider {
//    static var previews: some View {
//        RankingViewController().toPreview()
//    }
//}

class RankingView: UIView {

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
            string: "월드랭킹",
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
            string: "월드랭킹",
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
    
    let rankingLabel: UILabel = {
        var label = UILabel()
        label.text = "랭킹"
        label.textAlignment = .center
        label.font = UIFont(name: "DungGeunMo", size: 14)
        return label
    }()
    
    let nickNameLabel: UILabel = {
        var label = UILabel()
        label.text = "닉네임"
        label.textAlignment = .center
        label.font = UIFont(name: "DungGeunMo", size: 14)
        return label
    }()
    
    let levelLabel: UILabel = {
        var label = UILabel()
        label.text = "레벨"
        label.textAlignment = .center
        label.font = UIFont(name: "DungGeunMo", size: 14)
        return label
    }()
    
    var rank1: UIStackView = {
        var rankImg = UIImage(named: "img_rank_first")
        var rankImgView = UIImageView(image: rankImg)
        rankImgView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [rankImgView, nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    var rank2: UIStackView = {
        var rankImg = UIImage(named: "img_rank_second")
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [UIImageView(image: rankImg), nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.backgroundColor = UIColor(hexCode: "FEE5C8")
        return stack
    }()
    
    var rank3: UIStackView = {
        var rankImg = UIImage(named: "img_rank_third")
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [UIImageView(image: rankImg), nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    var rank4: UIStackView = {
        var rank = UILabel()
        rank.text = "4위"
        rank.font = UIFont(name: "DungGeunMo", size: 14)
        rank.textAlignment = .center
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [rank, nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.backgroundColor = UIColor(hexCode: "FEE5C8")
        return stack
    }()
    
    var rank5: UIStackView = {
        var rank = UILabel()
        rank.text = "5위"
        rank.font = UIFont(name: "DungGeunMo", size: 14)
        rank.textAlignment = .center
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [rank, nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    var rank6: UIStackView = {
        var rank = UILabel()
        rank.text = "6위"
        rank.font = UIFont(name: "DungGeunMo", size: 14)
        rank.textAlignment = .center
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [rank, nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.backgroundColor = UIColor(hexCode: "FEE5C8")
        return stack
    }()
    
    var rank7: UIStackView = {
        var rank = UILabel()
        rank.text = "7위"
        rank.font = UIFont(name: "DungGeunMo", size: 14)
        rank.textAlignment = .center
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [rank, nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    var rank8: UIStackView = {
        var rank = UILabel()
        rank.text = "8위"
        rank.font = UIFont(name: "DungGeunMo", size: 14)
        rank.textAlignment = .center
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [rank, nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.backgroundColor = UIColor(hexCode: "FEE5C8")
        return stack
    }()
    
    var rank9: UIStackView = {
        var rank = UILabel()
        rank.text = "9위"
        rank.font = UIFont(name: "DungGeunMo", size: 14)
        rank.textAlignment = .center
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [rank, nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    var rank10: UIStackView = {
        var rank = UILabel()
        rank.text = "10위"
        rank.font = UIFont(name: "DungGeunMo", size: 14)
        rank.textAlignment = .center
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [rank, nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.backgroundColor = UIColor(hexCode: "FEE5C8")
        return stack
    }()
    
    lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rankingLabel, nickNameLabel, levelLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    lazy var ranks = [rank1, rank2, rank3, rank4, rank5, rank6, rank7, rank8, rank9, rank10,]
    
    lazy var centerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: ranks)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .bottom
        return stack
    }()
    
    var myRank: UIStackView = {
        var rank = UILabel()
        rank.text = "-"
        rank.font = UIFont(name: "DungGeunMo", size: 14)
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        let stack = UIStackView(arrangedSubviews: [rank, nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .bottom
        return stack
    }()
    
    lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_background_history")
        view.contentMode = .scaleAspectFit
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
        addSubview(titleBackgroundText)
        addSubview(titleText)
        addSubview(profileBoxView)
        addSubview(backgroundView)
        addSubview(backgroundBottomImageView)
        addSubview(topStackView)
        addSubview(centerStackView)
        addSubview(myRank)
    }
    
    func autoLayoutConstraints() {
        profileBoxView.translatesAutoresizingMaskIntoConstraints = false
        backgroundBottomImageView.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleBackgroundText.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        centerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        profileBoxView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileBoxView.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20).isActive = true
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
        
        backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: profileBoxView.bottomAnchor, constant: 20).isActive = true
        backgroundView.widthAnchor.constraint(equalToConstant: 374).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 404).isActive = true
        
        backgroundBottomImageView.widthAnchor.constraint(equalToConstant: 430).isActive = true
        backgroundBottomImageView.heightAnchor.constraint(equalToConstant: 188).isActive = true
        backgroundBottomImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        topStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        topStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        centerStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor).isActive = true
        centerStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 6).isActive = true
        centerStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        centerStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -76).isActive = true
        
        ranks.forEach { rank in
            rank.leadingAnchor.constraint(equalTo: centerStackView.leadingAnchor).isActive = true
            rank.trailingAnchor.constraint(equalTo: centerStackView.trailingAnchor).isActive = true
        }
        


//        myRank.topAnchor.constraint(equalTo: centerStackView.bottomAnchor, constant: 30).isActive = true
//        myRank.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20).isActive = true
//        myRank.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20).isActive = true
//        myRank.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20).isActive = true
    }
}
