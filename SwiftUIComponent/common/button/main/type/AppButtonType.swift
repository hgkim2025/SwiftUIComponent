//
//  ButtonType.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import Foundation

enum AppButtonType: CaseIterable {
    case primary
    case primaryLine
    case grayLine
    case textOnly
    
    func getFontColor(state: AppButtonState) -> AppColor {
        switch self {
        case .primary:
            return AppColor.white
        case .primaryLine:
            switch state {
            case .idle, .enabled:
                return AppColor.primaryNormal
            case .disabled:
                return AppColor.primaryAlternative
            case .pressed:
                return AppColor.primarySupport
            }
        case .grayLine:
            switch state {
            case .idle, .enabled:
                return AppColor.textStrong
            case .disabled:
                return AppColor.disabledLight
            case .pressed:
                return AppColor.textSupport
            }
        case .textOnly:
            switch state {
            case .idle, .enabled:
                return AppColor.primaryNormal
            case .disabled:
                return AppColor.textCaption
            case .pressed:
                return AppColor.primarySupport
            }
        }
    }
    
    func getBGColor(state: AppButtonState) -> AppColor {
        switch self {
        case .primary:
            switch state {
            case .idle, .enabled:
                return AppColor.primaryNormal
            case .disabled:
                return AppColor.primaryAlternative
            case .pressed:
                return AppColor.primarySupport
            }
        case .primaryLine:
            switch state {
            case .idle, .enabled:
                return AppColor.clear
            case .disabled:
                return AppColor.clear
            case .pressed:
                return AppColor.primaryBackground
            }
        case .grayLine:
            switch state {
            case .idle, .enabled:
                return AppColor.clear
            case .disabled:
                return AppColor.clear
            case .pressed:
                return AppColor.disabledLight
            }
        case .textOnly:
            return AppColor.clear
        }
    }
    
    func getBorderColor(state: AppButtonState) -> AppColor {
        switch self {
        case .primary:
            return AppColor.clear
        case .primaryLine:
            switch state {
            case .idle, .enabled:
                return AppColor.primaryNormal
            case .disabled:
                return AppColor.primaryAlternative
            case .pressed:
                return AppColor.primarySupport
            }
        case .grayLine:
            switch state {
            case .idle, .enabled:
                return AppColor.textStrong
            case .disabled:
                return AppColor.disabledLight
            case .pressed:
                return AppColor.textSupport
            }
        case .textOnly:
            return AppColor.clear
        }
    }
}
