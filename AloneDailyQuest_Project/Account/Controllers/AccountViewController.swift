//
//  AccountViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 12/1/23.
//

import UIKit

class AccountViewController: UIViewController {

    private let loginView = LoginView()
    
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
