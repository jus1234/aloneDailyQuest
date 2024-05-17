//
//  NoticeViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 5/13/24.
//

import UIKit

class NoticeViewController: UIViewController {
    
    let notice = NoticeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = notice
    }
}
