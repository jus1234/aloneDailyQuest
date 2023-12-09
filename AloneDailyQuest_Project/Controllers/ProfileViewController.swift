//
//  ProfileViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Joy Kim on 2023/12/13.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profileView = ProfileView()
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    func makeUI() {
      

    }

    
}

