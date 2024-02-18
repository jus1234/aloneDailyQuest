//
//  RepeatDay.swift
//  AloneDailyQuest_Project
//
//  Created by 오정석 on 1/2/2024.
//

import UIKit

enum RepeatDay: Int64 {
    case sun = 1
    case mon = 2
    case tue = 3
    case wed = 4
    case thu = 5
    case fri = 6
    case sat = 7
    
    var repeatday: Bool {
        switch self {
        case .sun:
            return true
        case .mon:
            return true
        case .tue:
            return true
        case .wed:
            return true
        case .thu:
            return true
        case .fri:
            return true
        case .sat:
            return true
        }
    }
}
