import UIKit

class ProfileView: UIView {
    lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_profile_background")
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_profile_Lv1-10")
        return view
    }()
    
    lazy var nickNameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        return label
    }()
    
    lazy var nickNameText: UILabel = {
        let label = UILabel()
        label.text = "매튜"
        return label
    }()
    
    lazy var nickNameStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nickNameTitleLabel, nickNameText])
        return stack
    }()
    
    lazy var levelTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "레벨"
        return label
    }()
    
    lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "LV.1"
        return label
    }()
    
    lazy var levelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [levelTitleLabel, levelLabel])
        return stack
    }()
    
    lazy var firstStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImage,nickNameStackView, levelStackView])
        return stack
    }()
    
    lazy var experienceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "경험치"
        return label
    }()
    
    lazy var experienceBar: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "img_level_bar")
        let attrString = NSAttributedString(
            string: "0/10",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 16)
            ]
        )
        view.layer.backgroundColor = UIColor(red: 0.261, green: 0.872, blue: 0.248, alpha: 1).cgColor
        view.accessibilityAttributedLabel = attrString
        return view
    }()
    
    lazy var secondStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [experienceTitleLabel, experienceBar])
        return stack
    }()
    
    lazy var allStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [firstStackView, secondStackView])
//        stack.
        return stack
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
        self.addSubview(backgroundView)
        self.addSubview(allStackView)
    }
    
    func autoLayoutConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        allStackView.translatesAutoresizingMaskIntoConstraints = false
        allStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        allStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
