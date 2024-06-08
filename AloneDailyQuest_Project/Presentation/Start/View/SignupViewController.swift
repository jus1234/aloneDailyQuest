//
//  AccountViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 12/1/23.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

class SignupViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private let startButton = UIButton()
    private let validationText = UILabel()
    private let nickNameTextField = UITextField()
    private let info2Text = UILabel()
    private let infoText = UILabel()
    private let backgroundBottomImageView = UIImageView()
    private let nickNameImageView = UIImageView()
    private let logoText = UILabel()
    private let logoBackgroundText = UILabel()
    
    private let viewModel: SignupViewModel
    private lazy var input = SignupViewModel.Input(
        signupEvent: PublishRelay(),
        nickNameValidationEvent: nickNameTextField.rx.text.orEmpty)
    
    init(viewModel: SignupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLayour()
        setupAddTarget()
        bindOutput()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        regiterNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unRegisterNotification()
    }
}

extension SignupViewController {
    private func bindOutput() {
        
        let output = viewModel.transform(input: input)
        
        output.isValidNickName
            .asDriver(onErrorJustReturn: false)
            .drive(with: self) {owner, isValid in
                guard isValid else {
                    owner.startButton.isEnabled = false
                    owner.validationText.text = "잘못된 형식의 닉네임입니다."
                    owner.validationText.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
                    return
                }
                owner.startButton.isEnabled = true
                owner.validationText.text = "올바른 닉네임입니다."
                owner.validationText.textColor = UIColor(hexCode: "21C131")
            }
            .disposed(by: disposeBag)
        
        output.errorMessage
            .asDriver(onErrorJustReturn: "")
            .drive(with: self) { owner, error in
                owner.completedAlert(message: error)
            }
            .disposed(by: disposeBag)
    }
}

extension SignupViewController {
    private func setupAddTarget() {
        startButton.addTarget(self, action: #selector(signup), for: .touchUpInside)
    }
    
    @objc private func signup() {
        guard let nickName = nickNameTextField.text else {
            return
        }
        input.signupEvent.accept(nickName)
    }
    
    private func regiterNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardEvent), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardEvent), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    private func unRegisterNotification() {
        NotificationCenter.default.removeObserver(self,name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self,name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardEvent(notiInfo: Notification){
        if notiInfo.name == UIResponder.keyboardWillShowNotification {
            nickNameImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        }else{
            nickNameImageView.topAnchor.constraint(equalTo: logoBackgroundText.bottomAnchor, constant: 60).isActive = true
        }
    }
}

extension SignupViewController {
    private func setStyle() {
        view.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
        
        backgroundBottomImageView.do { $0.image = UIImage(named: "image_background_bottom") }
        
        startButton.do {
            $0.setBackgroundImage(UIImage(named: "btn_account_normal"), for: .normal)
            $0.frame = CGRect(x: 0, y: 0, width: 300, height: 64)
            $0.setAttributedTitle(makeAttribueTitleButton(title: "시작하기"), for: .normal)
            $0.titleLabel?.layer.shadowColor = UIColor.black.cgColor
            $0.titleLabel?.layer.shadowOffset = CGSize(width: -2.0, height: 2.0)
            $0.titleLabel?.layer.shadowOpacity = 1.0
            $0.titleLabel?.layer.shadowRadius = 0
            $0.titleLabel?.layer.masksToBounds = false
            $0.isEnabled = false
        }
        
        validationText.do {
            $0.font = UIFont(name: "DungGeunMo", size: 14)
            $0.textAlignment = .center
            $0.text = ""
        }
        
        nickNameTextField.do {
            $0.frame = CGRect(x: 0, y: 0, width: 350, height: 50)
            $0.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            $0.textAlignment = .center
            $0.font = UIFont(name: "DungGeunMo", size: 16)
            $0.textColor = .black
        }
        
        info2Text.do {
            $0.frame = CGRect(x: 0, y: 0, width: 222, height: 12)
            $0.textColor = UIColor(red: 0.443, green: 0.218, blue: 0.04, alpha: 1)
            $0.font = UIFont(name: "DungGeunMo", size: 12)
            $0.textAlignment = .left
            $0.text = "* 닉네임에는 영문자와 숫자, 한글만 사용할 수 있습니다. \n* 닉네임은 설정시 변경할 수 없습니다."
            $0.numberOfLines = 0
            $0.setLineSpacing(spacing: 8.0)
        }
        
        infoText.do {
            $0.frame = CGRect(x: 0, y: 0, width: 279, height: 18)
            $0.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            $0.font = UIFont(name: "DungGeunMo", size: 18)
            $0.textAlignment = .center
            $0.text = "사용하실 닉네임을 입력해주세요."
        }
        
        nickNameImageView.do {
            $0.frame = CGRect(x: 0, y: 0, width: 394, height: 204)
            $0.image = UIImage(named: "img_account_background")
        }
        
        logoText.do {
            $0.frame = CGRect(x: 0, y: 0, width: 200, height: 80)
            $0.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.textAlignment = .center
            $0.attributedText = makeAttributedTitle(title: "나혼자만\n일일퀘스트")
        }
        
        logoBackgroundText.do {
            $0.frame = CGRect(x: 0, y: 0, width: 200, height: 80)
            $0.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.textAlignment = .center
            $0.attributedText = makeAttributedTitleBackground(title: "나혼자만\n일일퀘스트")
        }
    }
    
    private func setLayour() {
        view.addSubviews(
            [logoBackgroundText, logoText, backgroundBottomImageView,
             nickNameImageView, nickNameTextField, infoText,
             info2Text, validationText, startButton])
        
        logoText.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(120)
        }
        
        logoBackgroundText.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview().inset(3)
            $0.top.equalToSuperview().inset(123)
        }
        
        backgroundBottomImageView.snp.makeConstraints {
            $0.width.equalTo(430)
            $0.height.equalTo(188)
            $0.bottom.equalToSuperview()
        }
        
        nickNameImageView.snp.makeConstraints {
            $0.width.equalTo(394)
            $0.height.equalTo(204)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoBackgroundText.snp.bottom).offset(60)
        }
        
        infoText.snp.makeConstraints {
            $0.width.equalTo(279)
            $0.height.equalTo(18)
            $0.top.equalTo(nickNameImageView.snp.top).offset(20)
            $0.centerX.equalTo(nickNameImageView.snp.centerX)
        }
        
        info2Text.snp.makeConstraints {
            $0.width.equalTo(324)
            $0.height.equalTo(50)
            $0.top.equalTo(nickNameImageView.snp.top).offset(40)
            $0.centerX.equalTo(nickNameImageView.snp.centerX)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.height.equalTo(50)
            $0.top.equalTo(nickNameImageView.snp.top).offset(96)
            $0.centerX.equalTo(nickNameImageView.snp.centerX)
        }
        
        validationText.snp.makeConstraints {
            $0.top.equalTo(nickNameImageView.snp.top).offset(156)
            $0.centerX.equalTo(nickNameImageView.snp.centerX)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(nickNameImageView.snp.bottom).offset(36)
            $0.centerX.equalToSuperview()
        }
    }
}
