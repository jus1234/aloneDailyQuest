import UIKit

class ProfileBoxView: UIView {
    private lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_profile_background")
        return view
    }()
    
    private lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_profile_Lv1-10")
        return view
    }()
    
    private lazy var nickNameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textColor = UIColor(red: 0.443, green: 0.218, blue: 0.04, alpha: 1)
        label.attributedText = NSMutableAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        return label
    }()
    
    private lazy var nickNameText: UILabel = {
        let label = UILabel()
        label.text = user.value.fetchNickName()
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
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
        label.textColor = UIColor(red: 0.443, green: 0.218, blue: 0.04, alpha: 1)
        label.attributedText = NSMutableAttributedString(string: "레벨", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        return label
    }()
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "LV.\(user.value.fetchLevel())"
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
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
    
    private lazy var firstStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImage,nickNameStackView, levelStackView])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 16
        return stack
    }()
    
    private lazy var experienceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 16)
        label.textColor = UIColor(red: 0.443, green: 0.218, blue: 0.04, alpha: 1)
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
        label.textColor = UIColor.black
        label.font = UIFont(name: "DungGeunMo", size: 16) ?? UIFont.systemFont(ofSize: 16)
        label.sizeToFit()
        label.center = view.center
        label.textAlignment = .center
        
        let totalHeight = max(imageView.frame.size.height, label.frame.size.height)
        view.frame = CGRect(x: 0, y: 0, width: 270, height: totalHeight)

        imageView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        label.center = imageView.center

        let firstHalfLayer = CALayer()
        firstHalfLayer.backgroundColor = UIColor(red: 0.261, green: 0.872, blue: 0.248, alpha: 1).cgColor
        firstHalfLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width / 10, height: view.bounds.height)
        
        let secondHalfLayer = CALayer()
        secondHalfLayer.backgroundColor = UIColor.clear.cgColor
        secondHalfLayer.frame = CGRect(x: view.bounds.width / 10, y: 0, width: view.bounds.width / 10, height: view.bounds.height)
        
        view.layer.addSublayer(firstHalfLayer)
        view.layer.addSublayer(secondHalfLayer)
        view.addSubview(imageView)
        view.addSubview(label)

        return view
    }()
    
    private func setLevelBar(_ input: Int) -> CGFloat {
        let result: CGFloat = CGFloat(input)
        
        return result
    }
    
    private lazy var secondStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [experienceTitleLabel, experienceBar])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 16
        return stack
    }()
    
    private lazy var allStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [firstStackView, secondStackView])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 12
        return stack
    }()
    
    var user: Observable<UserInfo> = Observable(UserInfo(nickName: UserDefaults.standard.string(forKey: "nickName")!,
                                                         experience: UserDefaults.standard.integer(forKey: "experience")))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        autoLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindExperience() {
        user.bind { [weak self] newValue in
            self?.levelLabel.text = "LV. \(newValue.fetchLevel())"
            self?.nickNameText.text = newValue.fetchNickName()
        }
    }
    
    func setupProfile(user: Observable<UserInfo>) {
        self.user = user
        nickNameText.text = user.value.fetchNickName()
        levelLabel.text = "LV.\(String(describing: user.value.fetchLevel()))"
        bindExperience()
    }
    
    private func addViews() {
        self.addSubview(backgroundView)
        self.addSubview(allStackView)
    }
    
    private func autoLayoutConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalToConstant: 374).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 104).isActive = true
        
        profileImage.widthAnchor.constraint(equalToConstant: 26).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        allStackView.translatesAutoresizingMaskIntoConstraints = false
        allStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        allStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        allStackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20).isActive = true
        allStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20).isActive = true
    }
}
