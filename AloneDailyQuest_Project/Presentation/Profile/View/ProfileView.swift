//
//  SettingView.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 2/6/24.
//

import UIKit
//import SwiftUI

class ProfileView: UIView {
    lazy var tabView = TabView()
    
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
            string: "프로필",
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
            string: "프로필",
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
    
    private lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_profile_Lv1-10")
        return view
    }()
    
    private lazy var nickNameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textColor = UIColor(hexCode: "71380A")
        label.attributedText = NSMutableAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        return label
    }()
    
    private lazy var nickNameText: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textColor = UIColor(hexCode: "000000")
        label.textAlignment = .left
        return label
    }()
    
    private lazy var nickNameStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nickNameTitleLabel, nickNameText])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    private lazy var levelTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textColor = UIColor(hexCode: "71380A")
        label.attributedText = NSMutableAttributedString(string: "레벨", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        return label
    }()
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textColor = UIColor(hexCode: "000000")
        label.textAlignment = .left
        return label
    }()
    
    private lazy var levelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [levelTitleLabel, levelLabel])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 20
        return stack
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nickNameStackView, levelStackView])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    private lazy var firstStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImage, infoStackView])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 16
        return stack
    }()
    
    private lazy var experienceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textColor = UIColor(hexCode: "71380A")
        label.attributedText = NSMutableAttributedString(string: "경험치", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        return label
    }()
    
    private lazy var experienceBar: UIView = {
        let view = UIView()

        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_level_bar")
        imageView.contentMode = .center
        imageView.frame = CGRect(x: 0, y: 0, width: 270, height: 18)
        
        let label = UILabel()
        label.text = "1/10"
        label.textColor = UIColor(hexCode: "000000")
        label.font = UIFont(name: "DungGeunMo", size: 16) ?? UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        label.center = view.center
        label.textAlignment = .center
        
        let totalHeight = max(imageView.frame.size.height, label.frame.size.height)
        view.frame = CGRect(x: 0, y: 0, width: 270, height: totalHeight)

        imageView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        label.center = imageView.center

        let experienceLayer = CALayer()
        experienceLayer.backgroundColor = UIColor(red: 0.261, green: 0.872, blue: 0.248, alpha: 1).cgColor
        experienceLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 10, height: view.bounds.height)
            
        
        view.layer.addSublayer(experienceLayer)
        view.addSubview(imageView)
        view.addSubview(label)

        return view
    }()
    
    private lazy var secondStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [experienceTitleLabel, experienceBar])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 16
        return stack
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstStackView, secondStackView])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 16
        return stack
    }()
    
    private lazy var limitExperienceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textColor = UIColor(hexCode: "71380A")
        label.attributedText = NSMutableAttributedString(string: "일일 경험치한계", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        return label
    }()
    
    private lazy var limitExperienceNumerLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textColor = UIColor(hexCode: "000000")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var limitExperienceInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 12)
        label.text = "* 일일 경험치한계를 넘은 경험치는 추가되지 않습니다."
        label.textColor = UIColor(hexCode: "FF0000")
        label.textAlignment = .left
        return label
    }()
    
    private lazy var limitExperienceFirstStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [limitExperienceTitleLabel, limitExperienceNumerLabel])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    private lazy var limitExperienceAllStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [limitExperienceFirstStackView, limitExperienceInfoLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    lazy var profileView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_profilePage_background")
        view.contentMode = .scaleAspectFit
        return view
    }()

    let lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "E9D8C0")
        return view
    }()
    
    let lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "E9D8C0")
        return view
    }()
    
    let lineView3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "E9D8C0")
        return view
    }()
    
    let lineView4: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "E9D8C0")
        return view
    }()
    
    let noticeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.setTitle("공지사항", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "DungGeunMo", size: 16) ?? UIFont.systemFont(ofSize: 16)
        
        button.setImage(UIImage(named: "btn_arrow_normal"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 320, bottom: 0, right: 0)

        button.addTarget(self, action: #selector(tapNoticeButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let contactButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.setTitle("문의하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "DungGeunMo", size: 16) ?? UIFont.systemFont(ofSize: 16)
        
        button.setImage(UIImage(named: "btn_arrow_normal"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 320, bottom: 0, right: 0)

        button.addTarget(self, action: #selector(tapContactButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let leaveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "DungGeunMo", size: 16) ?? UIFont.systemFont(ofSize: 16)
        
        button.setImage(UIImage(named: "btn_arrow_normal"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 320, bottom: 0, right: 0)

        button.addTarget(self, action: #selector(tapLeaveButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var didNoticeButtonTap: Observable<Void> = Observable(())
    var didContactButton: Observable<Void> = Observable(())
    var didLeaveButtonTap: Observable<Void> = Observable(())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        autoLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapNoticeButton() {
        didNoticeButtonTap.value = ()
    }
    
    @objc private func tapContactButton() {
        didContactButton.value = ()
    }
    
    @objc private func tapLeaveButton() {
        didLeaveButtonTap.value = ()
    }
    
    func addViews() {
        addSubview(backgroundBottomImageView)
        addSubview(titleBackgroundText)
        addSubview(titleText)
        addSubview(profileView)
        addSubview(userInfoStackView)
        addSubview(lineView1)
        addSubview(limitExperienceAllStackView)
        addSubview(lineView2)
        addSubview(noticeButton)
        addSubview(lineView3)
        addSubview(contactButton)
        addSubview(lineView4)
        addSubview(leaveButton)
        addSubview(tabView)
    }
    
    func autoLayoutConstraints() {
        backgroundBottomImageView.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleBackgroundText.translatesAutoresizingMaskIntoConstraints = false
        profileView.translatesAutoresizingMaskIntoConstraints = false
        userInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        nickNameText.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView1.translatesAutoresizingMaskIntoConstraints = false
        limitExperienceAllStackView.translatesAutoresizingMaskIntoConstraints = false
        limitExperienceNumerLabel.translatesAutoresizingMaskIntoConstraints = false
        limitExperienceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView2.translatesAutoresizingMaskIntoConstraints = false
        noticeButton.translatesAutoresizingMaskIntoConstraints = false
        lineView3.translatesAutoresizingMaskIntoConstraints = false
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        lineView4.translatesAutoresizingMaskIntoConstraints = false
        leaveButton.translatesAutoresizingMaskIntoConstraints = false
        tabView.translatesAutoresizingMaskIntoConstraints = false
        
        tabView.heightAnchor.constraint(equalToConstant: 146).isActive = true
        tabView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tabView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tabView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        leaveButton.topAnchor.constraint(equalTo: lineView4.bottomAnchor, constant: 16).isActive = true
        leaveButton.widthAnchor.constraint(equalToConstant: 340).isActive = true
        leaveButton.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 24).isActive = true
        leaveButton.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        lineView4.heightAnchor.constraint(equalToConstant: 2).isActive = true
        lineView4.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 7).isActive = true
        lineView4.trailingAnchor.constraint(equalTo: profileView.trailingAnchor
                                            , constant: -3).isActive = true
        lineView4.topAnchor.constraint(equalTo: contactButton.bottomAnchor, constant: 16).isActive = true
        
        contactButton.topAnchor.constraint(equalTo: lineView3.bottomAnchor, constant: 16).isActive = true
        contactButton.widthAnchor.constraint(equalToConstant: 340).isActive = true
        contactButton.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 24).isActive = true
        contactButton.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        lineView3.heightAnchor.constraint(equalToConstant: 2).isActive = true
        lineView3.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 7).isActive = true
        lineView3.trailingAnchor.constraint(equalTo: profileView.trailingAnchor
                                            , constant: -3).isActive = true
        lineView3.topAnchor.constraint(equalTo: noticeButton.bottomAnchor, constant: 16).isActive = true
        
        noticeButton.topAnchor.constraint(equalTo: lineView2.bottomAnchor, constant: 16).isActive = true
        noticeButton.widthAnchor.constraint(equalToConstant: 340).isActive = true
        noticeButton.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 24).isActive = true
        noticeButton.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        lineView2.heightAnchor.constraint(equalToConstant: 2).isActive = true
        lineView2.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 7).isActive = true
        lineView2.trailingAnchor.constraint(equalTo: profileView.trailingAnchor
                                            , constant: -3).isActive = true
        lineView2.topAnchor.constraint(equalTo: limitExperienceAllStackView.bottomAnchor, constant: 16).isActive = true
        
        limitExperienceTitleLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        limitExperienceNumerLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        limitExperienceAllStackView.topAnchor.constraint(equalTo: lineView1.bottomAnchor
                                                         , constant: 16).isActive = true
        limitExperienceAllStackView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 24).isActive = true
        
        
        lineView1.heightAnchor.constraint(equalToConstant: 2).isActive = true
        lineView1.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 7).isActive = true
        lineView1.trailingAnchor.constraint(equalTo: profileView.trailingAnchor
                                            , constant: -3).isActive = true
        lineView1.topAnchor.constraint(equalTo: userInfoStackView.bottomAnchor, constant: 16).isActive = true
        
        nickNameText.widthAnchor.constraint(equalToConstant: 200).isActive = true
        levelLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        profileImage.widthAnchor.constraint(equalToConstant: 46).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        userInfoStackView.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 20).isActive = true
        userInfoStackView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 24).isActive = true
        
        
        profileView.topAnchor.constraint(equalTo: titleBackgroundText.bottomAnchor, constant: 20).isActive = true
        profileView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        titleText.widthAnchor.constraint(equalToConstant: 123).isActive = true
        titleText.heightAnchor.constraint(equalToConstant: 33).isActive = true
        titleText.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleText.topAnchor.constraint(equalTo: topAnchor, constant: 63).isActive = true
        
        titleBackgroundText.widthAnchor.constraint(equalToConstant: 123).isActive = true
        titleBackgroundText.heightAnchor.constraint(equalToConstant: 33).isActive = true
        titleBackgroundText.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -3).isActive = true
        titleBackgroundText.topAnchor.constraint(equalTo: topAnchor, constant: 66).isActive = true
        
        backgroundBottomImageView.widthAnchor.constraint(equalToConstant: 430).isActive = true
        backgroundBottomImageView.heightAnchor.constraint(equalToConstant: 188).isActive = true
        backgroundBottomImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    func configureLabel(nickName: String, level: String) {
        nickNameText.text = nickName
        levelLabel.text = "LV.\(level)"
    }
    func updateExperienceBar(currentExp: Int) {
        let label = experienceBar.subviews.compactMap { $0 as? UILabel }.first
        let imageView = experienceBar.subviews.compactMap { $0 as? UIImageView }.first
        let experienceLayer = experienceBar.layer.sublayers?.compactMap { $0 as? CALayer }.first

        let progressFraction = CGFloat(currentExp) / 10.0
        label?.text = "\(currentExp)/10"
        label?.sizeToFit()
        if let imageView = imageView {
            label?.center = CGPoint(x: imageView.bounds.midX, y: imageView.bounds.midY)
        }

        experienceLayer?.frame = CGRect(x: 0, y: 0, width: experienceBar.bounds.width * progressFraction, height: experienceBar.bounds.height)
    }
}

//struct PreView: PreviewProvider {
//    static var previews: some View {
//        let navi = UINavigationController()
//        let profileVC = ProfileViewController(viewModel: ProfileViewModel(usecase: DefaultProfileUsecase(repository: DefaultProfileRepository(networkService: DefaultNetworkService())), coordinator: DefaultProfileCoordinator(navi)))
//        profileVC.toPreview()
//    }
//}
