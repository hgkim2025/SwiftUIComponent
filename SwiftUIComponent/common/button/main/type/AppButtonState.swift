//
//  ButtonActionType.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import Foundation

enum AppButtonState {
    case idle
    case pressed
    case disabled
    case enabled
   
    var clickDelay: TimeInterval {
        switch self {
        case .idle:
            return 0.07
        case .pressed:
            return 0.14
        case .disabled, .enabled:
            return 0.33
        }
    }
}
