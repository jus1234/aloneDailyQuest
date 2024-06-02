//
//  RankingViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 3/24/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class RankingViewController: UIViewController {
    private let profileBoxView = ProfileBoxView()
    private let tabView = TabView()
    private let backgroundBottomImageView = UIImageView()
    private let titleText = UILabel()
    private let titleBackgroundText = UILabel()
    private let rankingLabel = UILabel()
    private let nickNameLabel = UILabel()
    private let levelLabel = UILabel()
    private var rankFirst = UIStackView()
    private var rankSecond = UIStackView()
    private var rankThird = UIStackView()
    private var rankFourth = UIStackView()
    private var rankFifth = UIStackView()
    private var rankSixth = UIStackView()
    private var rankSeventh = UIStackView()
    private var rankEighth = UIStackView()
    private var rankNinth = UIStackView()
    private var rankTenth = UIStackView()
    private lazy var topStackView = UIStackView()
    private lazy var centerStackView = UIStackView()
    private lazy var myRank = UIStackView()
    private lazy var backgroundView = UIImageView()
    
    private lazy var ranks = [rankFirst, rankSecond, rankThird, rankFourth, rankFifth, rankSixth, rankSeventh, rankEighth, rankNinth, rankTenth]
    
    private let viewModel: RankingViewModel
    private var disposeBag = DisposeBag()
    
    init(viewModel: RankingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayout()
        bindOutput()
        setupProfile()
    }
    
}

extension RankingViewController {
    private func bindOutput() {
        let input = RankingViewModel.Input(
            viewWillAppear: rx.viewWillAppear,
            qeusetViewEvent: tabView.questButton.rx.tap,
            rankViewEvent: tabView.rankListButton.rx.tap,
            profileViewEvent: tabView.profileButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.rankingList
            .asDriver(onErrorJustReturn: [])
            .drive(with: self) { owner, rankingList in
                zip(rankingList, owner.ranks).forEach { user, rankBoxLow in
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
            .disposed(by: disposeBag)
        
        output.myRanking
            .asDriver(onErrorJustReturn: 0)
            .drive(with: self) { owner, myRanking in
                guard let ranking = owner.myRank.arrangedSubviews[0] as? UILabel else { return }
                ranking.text = "\(myRanking)위"
            }
            .disposed(by: disposeBag)
        
        output.errorMessage
            .asDriver(onErrorJustReturn: "")
            .drive(with: self) { owner,_ in
                owner.completedAlert(message: "네트워크 오류가 발생했습니다.")
            }
            .disposed(by: disposeBag)
    }
}

extension RankingViewController {
    private func setStyle() {
        view.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
        
        backgroundBottomImageView.do { $0.image = UIImage(named: "image_background_bottom") }
        
        titleText.do {
            $0.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.textAlignment = .center
            $0.attributedText = makeAttributedTitle(title: "월드랭킹")
        }
        
        titleBackgroundText.do {
            $0.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.textAlignment = .center
            $0.attributedText = makeAttributedTitleBackground(title: "월드랭킹")
        }
        
        rankingLabel.do {
            $0.text = "랭킹"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont(name: "DungGeunMo", size: 14)
        }
        
        nickNameLabel.do {
            $0.text = "닉네임"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont(name: "DungGeunMo", size: 14)
        }
        
        levelLabel.do {
            $0.text = "레벨"
            $0.textColor = .black
            $0.textAlignment = .center
            $0.font = UIFont(name: "DungGeunMo", size: 14)
        }
        
        topStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.alignment = .center
        }
        
        centerStackView.do {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.alignment = .bottom
        }
        
        backgroundView.do {
            $0.image = UIImage(named: "img_background_history")
            $0.contentMode = .scaleToFill
        }
        
        zip(ranks, 1...10).forEach { rankStackView, ranking in
            rankStackView.do {
                $0.addArrangedSubviews([makeRankView(rank: ranking), makeLabel(text: "-", size: 14), makeLabel(text: "-", size: 14)])
                $0.axis = .horizontal
                $0.distribution = .fillEqually
                $0.alignment = .center
                if ranking % 2 == 0 {
                    $0.backgroundColor =  UIColor(hexCode: "FEE5C8")
                }
            }
        }
        
        myRank.do {
            $0.addArrangedSubviews([makeLabel(text: "-", size: 25), makeLabel(text: "-", size: 25), makeLabel(text: "-", size: 25)])
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.alignment = .center
        }
    }
    
    private func setLayout() {
        view.addSubviews([titleBackgroundText, titleText, backgroundBottomImageView,
                          profileBoxView, backgroundView, topStackView,
                          centerStackView, myRank, tabView])
        topStackView.addArrangedSubviews([rankingLabel, nickNameLabel, levelLabel])
        centerStackView.addArrangedSubviews(ranks)
        
        titleText.snp.makeConstraints {
            $0.width.equalTo(123)
            $0.height.equalTo(33)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(63)
        }
        
        titleBackgroundText.snp.makeConstraints {
            $0.width.equalTo(123)
            $0.height.equalTo(33)
            $0.centerX.equalToSuperview().inset(3)
            $0.top.equalToSuperview().inset(66)
        }
        
        profileBoxView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleText.snp.bottom).offset(20)
            $0.width.equalTo(500)
            $0.height.equalTo(104)
        }
        
        backgroundView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileBoxView.snp.bottom).offset(20)
            $0.width.equalTo(374)
            $0.height.equalTo(404)
        }
        
        backgroundBottomImageView.snp.makeConstraints {
            $0.width.equalTo(430)
            $0.height.equalTo(188)
            $0.bottom.equalToSuperview()
        }
        
        tabView.snp.makeConstraints {
            $0.height.equalTo(146)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        topStackView.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.top)
            $0.leading.equalTo(backgroundView.snp.leading)
            $0.trailing.equalTo(backgroundView.snp.trailing)
            $0.height.equalTo(44)
        }
        
        centerStackView.snp.makeConstraints {
            $0.top.equalTo(topStackView.snp.bottom)
            $0.leading.equalTo(backgroundView.snp.leading)
            $0.trailing.equalTo(backgroundView.snp.trailing)
            $0.bottom.equalTo(backgroundView.snp.bottom).offset(-65)
        }
        
        ranks.forEach {
            $0.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(10)
                $0.trailing.equalToSuperview().inset(4)
            }
        }
        
        myRank.snp.makeConstraints {
            $0.top.equalTo(centerStackView.snp.bottom).offset(15)
            $0.leading.equalTo(backgroundView.snp.leading)
            $0.trailing.equalTo(backgroundView.snp.trailing)
            $0.bottom.equalTo(backgroundView.snp.bottom).offset(-20)
        }
    }
}

extension RankingViewController {
    private func setupProfile() {
        guard
            let nickName = myRank.arrangedSubviews[1] as? UILabel,
            let level = myRank.arrangedSubviews[2] as? UILabel,
            let userNickName = UserDefaults.standard.string(forKey: "nickName")
        else {
            return
        }
        let experience = UserDefaults.standard.integer(forKey: "experience")
        let user = UserInfo(nickName: userNickName, experience: experience)
        profileBoxView.configureLabel(nickName: user.fetchNickName(), level: String(user.fetchLevel()))
        profileBoxView.updateExperienceBar(currentExp: user.fetchExperience() % 10)
        nickName.text = user.fetchNickName()
        level.text = "\(user.fetchLevel())"
    }
    
    private func makeRankView(rank: Int) -> UIView {
        switch rank{
        case 1, 2, 3:
            return makeRankingImage(rank: rank)
        default:
            return makeLabel(text: "\(rank)위", size: 14)
        }
    }
    
    private func makeLabel(text: String, size: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = UIFont(name: "DungGeunMo", size: CGFloat(size))
        label.textAlignment = .center
        return label
    }
    
    private func makeRankingImage(rank: Int) -> UIStackView {
        let rankImg = UIImage(named: makeRankerImage(rank: rank))
        let rankImgView = UIImageView(image: rankImg)
        let imageStackView = UIStackView()
        imageStackView.addSubview(rankImgView)
        imageStackView.snp.makeConstraints { $0.height.equalTo(20) }
        rankImgView.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.leading.equalToSuperview().inset(35)
        }
        return imageStackView
    }
    
    private func makeRankerImage(rank: Int) -> String {
        return switch rank {
        case 1:
            "img_rank_first"
        case 2:
            "img_rank_second"
        default:
            "img_rank_third"
        }
    }
}
