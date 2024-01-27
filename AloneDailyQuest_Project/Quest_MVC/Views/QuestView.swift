//
//  QuestView.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 12/12/2023.
//

import UIKit

class QuestView: UIView {

    
    // MARK: - 생성자 셋팅

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.22, green: 0.784, blue: 0.784, alpha: 1)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func makeUI() {
        
    }
    
}
