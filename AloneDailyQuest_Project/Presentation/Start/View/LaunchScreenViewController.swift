//
//  LaunchScreenViewController.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 6/2/24.
//

import UIKit
import Lottie

final class LaunchScreenViewController: UIViewController {
    
    private let animationView: LottieAnimationView = {
        let lottieAnimationView = LottieAnimationView(name: "aloneDailyQuestLottie")
        lottieAnimationView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        lottieAnimationView.contentMode = .scaleAspectFill
        return lottieAnimationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(animationView)
        animationView.center = view.center
    }
    
    func start(completion: @escaping () -> Void) {
        animationView.play { _ in
            UIView.animate(withDuration: 0.2, animations: {
                self.animationView.alpha = 0
            }, completion: { _ in
                self.animationView.isHidden = true
                self.animationView.removeFromSuperview()
                completion()
            })
        }
    }
    
}
