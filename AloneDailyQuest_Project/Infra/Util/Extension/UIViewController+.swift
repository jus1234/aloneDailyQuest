//
//  UIViewController+.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 2/1/24.
//

import UIKit

extension UIViewController {
    public func customAlert(title: String? = nil,
                               message: String,
                               actions: [UIAlertAction],
                               completion: (() -> ())? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alertViewController.addAction(action)
        }
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    public func completedAlert(title: String? = nil,
                               message: String,
                               okAction: ((UIAlertAction) -> ())? = nil,
                               completion: (() -> ())? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    func makeCancelAlert(title: String? = nil,
                          message: String,
                          destructiveAction: ((UIAlertAction) -> Void)?,
                          cancelAction: ((UIAlertAction) -> Void)? = nil,
                          completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let destruction = UIAlertAction(title: "탈퇴", style: .destructive, handler: destructiveAction)
        alertViewController.addAction(destruction)

        let cancellation = UIAlertAction(title: "취소", style: .cancel, handler: cancelAction)
        alertViewController.addAction(cancellation)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    func makeAttributedTitle(title: String) -> NSAttributedString {
        return NSAttributedString(
            string: title,
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 30) ?? UIFont.systemFont(ofSize: 30),
                NSAttributedString.Key.strokeWidth: -2.5
            ]
        )
    }
    
    func makeAttributedTitleBackground(title: String) -> NSAttributedString {
        return  NSAttributedString(
            string: title,
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor(red: 0.128, green: 0.345, blue: 0.345, alpha: 1),
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 30) ?? UIFont.systemFont(ofSize: 30),
                NSAttributedString.Key.strokeWidth: -2.5
            ]
        )
    }
    
    func makeAttribueTitleButton(title: String) -> NSAttributedString {
        return NSAttributedString(
            string: title,
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font : UIFont(name: "DungGeunMo", size: 22) ?? UIFont.systemFont(ofSize: 22),
                NSAttributedString.Key.strokeWidth: -2.0
            ]
        )
    }
}

import SwiftUI

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
#endif
