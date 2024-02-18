//
//  AccountViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 12/1/23.
//

import UIKit

class AccountViewController: UIViewController {

    private let loginView = LoginView()
    private var nickName: String? = nil
    weak var delegate: delegateViewController? = nil
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAddTarget()
        setupAutoLayout()
        configureUI()
    }
    
    func setupAddTarget() {
        loginView.startButton.addTarget(self, action: #selector(moveView), for: .touchUpInside)
        loginView.nickNameTextField.addTarget(self, action: #selector(checkText(_:)), for: .editingChanged)
    }
    
    @objc func checkText(_ textField: UITextField) {
        if isVaildText(textField.text ?? "") {
            loginView.validationText.text = "올바른 닉네임입니다."
            loginView.validationText.textColor = UIColor(hexCode: "21C131")
            nickName = textField.text ?? ""
        } else {
            loginView.validationText.text = "잘못된 형식의 닉네임입니다."
            loginView.validationText.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }
    
    func isVaildText(_ text: String) -> Bool {
        let nicknameRegex = "^[a-zA-Z0-9가-힣]{1,8}$"
        let nicknamePredicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegex)
        return nicknamePredicate.evaluate(with: text)
    }
    
    @objc func moveView() {
        if nickName != nil {
            delegate?.moveView()
        } else {
            completedAlert(message: "닉네임을 다시 확인해주세요.")
        }
    }
    
    
    func configureUI() {
        loginView.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
    }
    
    func setupAutoLayout() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.leadingAnchor.constraint(equalTo: super.view.leadingAnchor, constant: 0).isActive = true
        loginView.topAnchor.constraint(equalTo: super.view.topAnchor, constant: 0).isActive = true
        loginView.trailingAnchor.constraint(equalTo: super.view.trailingAnchor, constant: 0).isActive = true
        loginView.bottomAnchor.constraint(equalTo: super.view.bottomAnchor, constant: 0).isActive = true
    }
}
