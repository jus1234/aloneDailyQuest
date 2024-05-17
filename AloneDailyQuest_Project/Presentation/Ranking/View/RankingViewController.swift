//
//  RankingViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 3/24/24.
//

import UIKit

class RankingViewController: UIViewController {
    private let profileBoxView: ProfileBoxView = ProfileBoxView()
    private let tabView: TabView = TabView()
    private lazy var backgroundBottomImageView: UIImageView = {
        var view = UIImageView()
        
        view.image = UIImage(named: "image_background_bottom")
        return view
    }()
    private let titleText: UILabel = {
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
    private let titleBackgroundText: UILabel = {
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
    private let rankingLabel: UILabel = {
        var label = UILabel()
        label.text = "랭킹"
        label.textAlignment = .center
        label.font = UIFont(name: "DungGeunMo", size: 14)
        return label
    }()
    private let nickNameLabel: UILabel = {
        var label = UILabel()
        label.text = "닉네임"
        label.textAlignment = .center
        label.font = UIFont(name: "DungGeunMo", size: 14)
        return label
    }()
    private let levelLabel: UILabel = {
        var label = UILabel()
        label.text = "레벨"
        label.textAlignment = .center
        label.font = UIFont(name: "DungGeunMo", size: 14)
        return label
    }()
    private var rank1: UIStackView = {
        var rankImg = UIImage(named: "img_rank_first")
        var rankImgView = UIImageView(image: rankImg)
        rankImgView.translatesAutoresizingMaskIntoConstraints = false
        rankImgView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        var imageStackView = UIStackView()
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.addSubview(rankImgView)
        imageStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        rankImgView.leadingAnchor.constraint(equalTo: imageStackView.leadingAnchor, constant: 35).isActive = true
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [imageStackView, nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    private var rank2: UIStackView = {
        var rankImg = UIImage(named: "img_rank_second")
        var rankImgView = UIImageView(image: rankImg)
        rankImgView.translatesAutoresizingMaskIntoConstraints = false
        rankImgView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        var imageStackView = UIStackView()
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.addSubview(rankImgView)
        imageStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        rankImgView.leadingAnchor.constraint(equalTo: imageStackView.leadingAnchor, constant: 35).isActive = true
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [imageStackView, nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.backgroundColor = UIColor(hexCode: "FEE5C8")
        return stack
    }()
    private var rank3: UIStackView = {
        var rankImg = UIImage(named: "img_rank_third")
        var rankImgView = UIImageView(image: rankImg)
        rankImgView.translatesAutoresizingMaskIntoConstraints = false
        rankImgView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        var imageStackView = UIStackView()
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.addSubview(rankImgView)
        imageStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        rankImgView.leadingAnchor.constraint(equalTo: imageStackView.leadingAnchor, constant: 35).isActive = true
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 14)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 14)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [imageStackView, nickName, level])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    private var rank4: UIStackView = {
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
    private var rank5: UIStackView = {
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
    private var rank6: UIStackView = {
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
    private var rank7: UIStackView = {
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
    private var rank8: UIStackView = {
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
    private var rank9: UIStackView = {
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
    private var rank10: UIStackView = {
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
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [rankingLabel, nickNameLabel, levelLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    private lazy var ranks = [rank1, rank2, rank3, rank4, rank5, rank6, rank7, rank8, rank9, rank10,]
    
    private lazy var centerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: ranks)
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .bottom
        return stack
    }()
    private lazy var myRank: UIStackView = {
        var rank = UILabel()
        rank.text = "-"
        rank.font = UIFont(name: "DungGeunMo", size: 25)
        rank.textAlignment = .center
        var nickName = UILabel()
        nickName.text = "-"
        nickName.font = UIFont(name: "DungGeunMo", size: 25)
        nickName.textAlignment = .center
        var level = UILabel()
        level.text = "-"
        level.font = UIFont(name: "DungGeunMo", size: 25)
        level.textAlignment = .center
        let stack = UIStackView(arrangedSubviews: [rank, nickName, level])
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
    
    private let viewModel: RankingViewModel
    private var viewDidLoadEvent: Observable<Void> = Observable(())
    private lazy var input = RankingViewModel.Input(viewDidLoad: viewDidLoadEvent,
                                                    qeusetViewEvent: tabView.qeusetViewEvent,
                                                    rankViewEvent: tabView.rankiViewEvent)
    private lazy var output = viewModel.transform(input: input)
    
    init(viewModel: RankingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addViews()
        autoLayoutConstraints()
        bindOutput()
        setupProfile()
        input.viewDidLoad.value = ()
    }
    
}

extension RankingViewController {
    private func bindOutput() {
        output.rankingList.bind { [weak self] rankingList in
            self?.setupRankingTable(rankingList: rankingList)
        }
        output.myRanking.bind { [weak self] myRanking in
            self?.setupMyRanking(myRanking: myRanking)
        }
        output.errorMessage.bind { [weak self] errorMessage in
            self?.completedAlert(message: "네트워크 오류가 발생했습니다.")
        }
    }
    
    private func setupProfile() {
        guard
            let nickName = myRank.arrangedSubviews[1] as? UILabel,
            let level = myRank.arrangedSubviews[2] as? UILabel
        else {
            return
        }
        let user = UserInfo(nickName: UserDefaults.standard.string(forKey: "nickName")!,
                 experience: UserDefaults.standard.integer(forKey: "experience"))
        nickName.text = user.fetchNickName()
        level.text = "\(user.fetchLevel())"
        profileBoxView.user.value = user
    }
    
    private func setupRankingTable(rankingList: [UserInfo]) {
        for (user, rankBoxLow) in zip(rankingList, ranks) {
            guard
                let nickName = rankBoxLow.arrangedSubviews[1] as? UILabel,
                let level = rankBoxLow.arrangedSubviews[2] as? UILabel
            else {
                return
            }
            nickName.text = user.fetchNickName()
            level.text = "\(user.fetchLevel())"
        }
    }
    
    private func setupMyRanking(myRanking: Int) {
        guard 
            let ranking = myRank.arrangedSubviews[0] as? UILabel
        else {
            return
        }
        ranking.text = "\(myRanking)위"
    }
}

extension RankingViewController {
    func configureUI() {
        view.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
    }
    
    func addViews() {
        view.addSubview(titleBackgroundText)
        view.addSubview(titleText)
        view.addSubview(profileBoxView)
        view.addSubview(backgroundView)
        view.addSubview(topStackView)
        view.addSubview(centerStackView)
        view.addSubview(myRank)
        view.addSubview(backgroundBottomImageView)
        view.addSubview(tabView)
    }
    
    func autoLayoutConstraints() {
        profileBoxView.translatesAutoresizingMaskIntoConstraints = false
        backgroundBottomImageView.translatesAutoresizingMaskIntoConstraints = false
        tabView.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleBackgroundText.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        centerStackView.translatesAutoresizingMaskIntoConstraints = false
        myRank.translatesAutoresizingMaskIntoConstraints = false
        
        profileBoxView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileBoxView.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20).isActive = true
        profileBoxView.widthAnchor.constraint(equalToConstant: 500).isActive = true
        profileBoxView.heightAnchor.constraint(equalToConstant: 104).isActive = true
        
        titleText.widthAnchor.constraint(equalToConstant: 123).isActive = true
        titleText.heightAnchor.constraint(equalToConstant: 33).isActive = true
        titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleText.topAnchor.constraint(equalTo: view.topAnchor, constant: 63).isActive = true
        
        titleBackgroundText.widthAnchor.constraint(equalToConstant: 123).isActive = true
        titleBackgroundText.heightAnchor.constraint(equalToConstant: 33).isActive = true
        titleBackgroundText.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -3).isActive = true
        titleBackgroundText.topAnchor.constraint(equalTo: view.topAnchor, constant: 66).isActive = true
        
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: profileBoxView.bottomAnchor, constant: 20).isActive = true
        backgroundView.widthAnchor.constraint(equalToConstant: 374).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 404).isActive = true
        
        backgroundBottomImageView.widthAnchor.constraint(equalToConstant: 430).isActive = true
        backgroundBottomImageView.heightAnchor.constraint(equalToConstant: 188).isActive = true
        backgroundBottomImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        tabView.heightAnchor.constraint(equalToConstant: 146).isActive = true
        tabView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        tabView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tabView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        topStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        topStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        topStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        centerStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor).isActive = true
        centerStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 6).isActive = true
        centerStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        centerStackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -65).isActive = true
        
        ranks.forEach { rank in
            rank.leadingAnchor.constraint(equalTo: centerStackView.leadingAnchor, constant: 1).isActive = true
            rank.trailingAnchor.constraint(equalTo: centerStackView.trailingAnchor, constant: -4).isActive = true
        }
        
        myRank.topAnchor.constraint(equalTo: centerStackView.bottomAnchor, constant: 15).isActive = true
        myRank.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        myRank.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        myRank.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20).isActive = true
    }
}
