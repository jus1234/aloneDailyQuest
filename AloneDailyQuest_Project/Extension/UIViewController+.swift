//
//  UIViewController+.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 2/1/24.
//

import UIKit

extension UIViewController {
    public func completedAlert(title: String? = nil,
                               message: String,
                               okAction: ((UIAlertAction) -> ())? = nil,
                               completion: (() -> ())? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}
