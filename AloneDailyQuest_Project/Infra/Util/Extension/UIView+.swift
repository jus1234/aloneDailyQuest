//
//  UIView+.swift
//  AloneDailyQuest_Project
//
//  Created by Matthew on 12/16/23.
//

import UIKit

extension UIButton {
    public func setTitleFont(font: UIFont) {
        self.titleLabel?.font = font
    }
}


extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
