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
