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
    }
    
    func setupAddTarget() {
        
    }
    
}
