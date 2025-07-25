//
//  ButtonSizeType.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import Foundation

enum AppButtonSize {
    case large
    case middle
    case small
    
    var radius: CGFloat {
        return height / 2
    }
    
    var height: CGFloat {
        switch self {
        case .large:  return 52
        case .middle: return 44
        case .small:  return 32
        }
    }
    
    var font: AppFontStyle {
        switch self {
        case .large:  return .buttonL
        case .middle: return .buttonM
        case .small:  return .buttonS
        }
    }
}
