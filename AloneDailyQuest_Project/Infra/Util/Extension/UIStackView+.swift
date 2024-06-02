//
//  UIStackView+.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/31/24.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
