//
//  Texts.swift
//  JuiceMaker
//
//  Created by Matthew on 12/19/23.
//

import Foundation

enum JuiceMakerViewObjectTitleText: CustomStringConvertible {
    case mainTitleText
    case editQuantityButtonTitleText
    case closeButtonTitleText
    case fontTitleText
    case detailViewControllerText
    
    var description: String {
        switch self {
        case .mainTitleText:
            return "맛있는 쥬스를 만들어 드려요!"
        case .editQuantityButtonTitleText:
            return "재고수정"
        case .closeButtonTitleText:
            return "닫기"
        case .fontTitleText:
            return "DungGeunMo"
        case .detailViewControllerText:
            return "DetailViewController"
        }
    }
}
