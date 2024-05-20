//
//  NoticeView.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/13/24.
//

import UIKit

class NoticeView: UIView {
    let tabView = TabView()
    
    let titleText: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        let attrString = NSAttributedString(
            string: "공지사항",
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
    
    private lazy var noticeTitleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 18)
        label.text = "[필독사항] - 공지사항 안내"
        label.textColor = UIColor(hexCode: "000000")
        label.textAlignment = .left
        return label
    }()
    
    private lazy var noticeWriterLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 14)
        label.text = "작성자 : 관리자              작성일자 : 2024.05.19"
        label.textColor = UIColor(hexCode: "848484")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var noticeContentLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "DungGeunMo", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        let fullText =
                    """
                    1. 닉네임 변경 불가
                       사용자 닉네임은 최초 설정 후 변경이 불가합니다.
                    2. 로그아웃 경고
                       로그아웃 시 기존 데이터를 복구할 수 없으며, 
                       기존 닉네임도 재사용할 수 없습니다.
                    3. 앱 삭제 시 데이터 소멸
                       앱을 삭제하면 모든 데이터가 영구 삭제되며, 
                       삭제된 데이터는 복구할 수 없습니다.
                    4. 부적절한 닉네임
                       부적절한 닉네임은 관리자에 의해 강제로 삭제될 
                       수 있습니다.
                    5. 복구 요청 불가
                       문의하기를 통해서도 데이터 복구 요청은 
                       불가능합니다.
                    6. 문의사항 안내
                       기타 문의사항은 앱 내 문의하기 기능을 통해 
                       접수해 주시기 바랍니다.
                    7. 이용 제한 안내
                       부적절한 행동이나 규칙 위반 시 서비스 이용이 
                       제한될 수 있습니다.
                    8. 버그 신고
                       앱 사용 중 발견된 버그는 문의하기를 통해 신고해 
                       주시면 신속히 처리하겠습니다.
                    
                    이 공지사항을 통해 사용자 여러분께 더욱 나은 
                    서비스를 제공하고자 합니다. 
                    
                    감사합니다.
                    """
        label.textColor = UIColor(hexCode: "3D3D3D")
        let attributedText = NSMutableAttributedString(string: fullText)
        let pointText = UIColor(hexCode: "000000")
        let pointFont = UIFont(name: "DungGeunMo", size: 14)!
        let pointTexts = [
            "1. 닉네임 변경 불가",
            "2. 로그아웃 경고",
            "3. 앱 삭제 시 데이터 소멸",
            "4. 부적절한 닉네임",
            "5. 복구 요청 불가",
            "6. 문의사항 안내",
            "7. 이용 제한 안내",
            "8. 버그 신고",
            "이 공지사항을 통해 사용자 여러분께 더욱 나은",
            "서비스를 제공하고자 합니다.",
            "감사합니다."
        ]
        for text in pointTexts {
            let range = (fullText as NSString).range(of: text)
            if range.location != NSNotFound {
                attributedText.addAttribute(.foregroundColor, value: pointText, range: range)
                attributedText.addAttribute(.font, value: pointFont, range: range)
            }
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.5

        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedText.length))
        
        label.attributedText = attributedText
        return label
    }()
    
    private lazy var noticeImageView: UIImageView = {
        var view = UIImageView()
        view.image = UIImage(named: "img_notice_background")
        return view
    }()
    
    let titleBackgroundText: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        let attrString = NSAttributedString(
            string: "공지사항",
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
    
    lazy var backButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "btn_back_normal"), for: .normal)
        button.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        return button
    }()
    
    var didBackButtonTap: Observable<Void> = Observable(())
    
    func addSubviews() {
        addSubview(tabView)
        addSubview(titleBackgroundText)
        addSubview(titleText)
        addSubview(backgroundBottomImageView)
        addSubview(backButton)
        addSubview(noticeImageView)
        addSubview(noticeTitleLabel)
        addSubview(noticeWriterLabel)
        addSubview(noticeContentLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraint()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.backgroundColor = UIColor(hexCode: "38C8C8")
    }
    
    @objc private func tapBackButton() {
        didBackButtonTap.value = ()
    }
    
    func setupConstraint() {
        noticeImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundBottomImageView.translatesAutoresizingMaskIntoConstraints = false
        tabView.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleBackgroundText.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        noticeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        noticeWriterLabel.translatesAutoresizingMaskIntoConstraints = false
        noticeContentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        noticeContentLabel.topAnchor.constraint(equalTo: noticeWriterLabel.bottomAnchor, constant: 14).isActive = true
        noticeContentLabel.leadingAnchor.constraint(equalTo: noticeImageView.leadingAnchor, constant: 20).isActive = true
        noticeContentLabel.trailingAnchor.constraint(equalTo: noticeImageView.trailingAnchor, constant: -10).isActive = true
        
        noticeWriterLabel.topAnchor.constraint(equalTo: noticeTitleLabel.bottomAnchor, constant: 10).isActive = true
        noticeWriterLabel.leadingAnchor.constraint(equalTo: noticeImageView.leadingAnchor, constant: 20).isActive = true
        noticeWriterLabel.trailingAnchor.constraint(equalTo: noticeImageView.trailingAnchor, constant: -20).isActive = true
        
        noticeTitleLabel.topAnchor.constraint(equalTo: noticeImageView.topAnchor, constant: 20).isActive = true
        noticeTitleLabel.leadingAnchor.constraint(equalTo: noticeImageView.leadingAnchor, constant: 20).isActive = true
        noticeTitleLabel.trailingAnchor.constraint(equalTo: noticeImageView.trailingAnchor, constant: -20).isActive = true
        
        noticeImageView.topAnchor.constraint(equalTo: titleBackgroundText.bottomAnchor, constant: 30).isActive = true
        noticeImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        noticeImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        noticeImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        backgroundBottomImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundBottomImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundBottomImageView.heightAnchor.constraint(equalToConstant: 188).isActive = true
        backgroundBottomImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
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
        
        backButton.centerYAnchor.constraint(equalTo: titleText.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    }
}

//struct PreView: PreviewProvider {
//    static var previews: some View {
//        NoticeViewController().toPreview()
//    }
//}
