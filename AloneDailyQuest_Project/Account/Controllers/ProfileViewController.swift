//
//  SettingViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 2/6/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileView: UIView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = profileView
        configureUI()
    }
    
    func configureUI() {
        profileView.backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
    }
}
