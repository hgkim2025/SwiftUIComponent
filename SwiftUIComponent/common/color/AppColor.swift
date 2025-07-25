//
//  AppColor.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

enum AppColor: CaseIterable {
    // MARK: - Primary
    case primaryNormal
    case primarySupport
    case primaryAlternative
    case primaryAssistive
    case primaryBackground
    case primaryGradientLight
    case primaryGradientDark
    case primaryGradient

    // MARK: - Text
    case textStrong
    case textNormal
    case textSupport
    case textAlternative
    case textAssistive
    case textCaption
    case textWhite
    
    // MARK: - Common
    case blue
    case blueLight
    case red
    case redLight
    case orange
    case orangeLight
    case yellow
    case yellowLight
    case green
    case greenLight
    case purple
    case purpleLight
    case disabled
    case disabledLight
    case gray
    case shadow
    case lightShadow
    case colorShadow
    
    // MARK: - Background
    case backgroundNormal
    case backgroundAssistive
    case backgroundDimmed
    case backgroundLightDimmed
    case backgroundLightDimmedStart
    case backgroundLightDimmedEnd
    case imageDimmed
    
    // MARK: - ETC
    case black
    case white
    case clear
    
    // MARK: - Line
    case lineOnWhite
    case lineOnColor
    case lineOnSupport
    
    // MARK: - Gradient
    
    case silder
//    case stick
    
    var color: Color {
        return Color(color: self)
    }
    
    var uiColor: UIColor {
        return UIColor(color)
    }

    var hex: String {
        switch self {
        case .primaryNormal: return "2A81B7"
        case .primarySupport: return "37197D"
        case .primaryAlternative: return "C4E9F5"
        case .primaryAssistive: return "EEF9FB"
        case .primaryBackground: return "EEFBFB"
        case .primaryGradientLight: return "26A6CC"
        case .primaryGradientDark: return "37197D"
        case .primaryGradient: return AppColor.primaryNormal.hex
            
        case .textStrong: return "101219"
        case .textNormal: return "2E3142"
        case .textSupport: return "535968"
        case .textAlternative: return "787E8B"
        case .textAssistive: return "9AA1AB"
        case .textCaption: return "C4C7CE"
        case .textWhite: return "FFFFFF"
            
        case .blue: return "3181F5"
        case .blueLight: return "EFF8FF"
        case .red: return "F86754"
        case .redLight: return "FEF0EE"
        case .orange: return "FB9E7D"
        case .orangeLight: return "FEEFE8"
        case .yellow: return "FFBB1E"
        case .yellowLight: return "FFFADD"
        case .green: return "2BC96B"
        case .greenLight: return "EDFCF4"
        case .purple: return "7F5CEB"
        case .purpleLight: return "F4F2FE"
        case .disabled: return "BDBDBD"
        case .disabledLight: return "E8E8EB"
        case .gray: return "EDF0F4"
        case .shadow: return "141C1C1C"
        case .colorShadow: return "2941B7FF"
        case .lightShadow: return "FFE8E8EB"
            
        case .backgroundNormal: return "FFFFFF"
        case .backgroundAssistive: return "F5F9FB"
        case .backgroundDimmed: return "b2344854"
        case .backgroundLightDimmed: return "20000000"
        case .backgroundLightDimmedStart: return "00686868"
        case .backgroundLightDimmedEnd: return "88282C2F"
        case .imageDimmed: return "FF282C2F"
            
        case .black: return "000000"
        case .white: return "FFFFFF"
        case .clear: return "00000000"
            
        case .lineOnWhite: return "E8E9ED"
        case .lineOnColor: return "E3EDEE"
        case .lineOnSupport: return "ABD0E7"
            
        case .silder: return "FFFFFF"
        }
    }
    
    var gradient: LinearGradient {
        return switch self {
        case .backgroundLightDimmed:
            LinearGradient(
                colors: self.gradientColors,
                startPoint: .top,
                endPoint: .bottom
            )
        case .imageDimmed:
            LinearGradient(
                colors: self.gradientColors,
                startPoint: UnitPoint(x: 0.5, y: 0.25),
                endPoint: .bottom
            )
            
        case .primaryGradient :
            LinearGradient(
                colors: self.gradientColors,
                startPoint: .top,
                endPoint: .bottom
            )
            
        case .silder:
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "371A7E"),
                                            Color(hex: "2E60A5"),
                                            Color(hex: "6989C4"),
                                            Color(hex: "E098DB"),
                                            Color(hex: "FB999D"),
                                            Color(hex: "FFB888"),
                                            Color(hex: "FFDF96")]),
                startPoint: .leading,
                endPoint: .trailing)
            
        default:
            LinearGradient(colors: [], startPoint: .top, endPoint: .bottom)
        }
    }
    
    var invertGradient: LinearGradient {
        return switch self {
        case .primaryGradient:
            LinearGradient(
                colors: self.invertGradientColors,
                startPoint: .top,
                endPoint: .bottom
            )
        default:
            LinearGradient(colors: [], startPoint: .top, endPoint: .bottom)
        }
    }
    
    var gradientColors: [Color] {
        return switch self {
        case .backgroundLightDimmed:
            [Color(color: .backgroundLightDimmedStart), Color(color: .backgroundLightDimmedEnd)]
            
        case .imageDimmed:
            [Color(color: .backgroundLightDimmedStart), Color(color: .imageDimmed)]
            
        case .primaryGradient:
            [Color(color: .primaryGradientLight), Color(color: .primaryGradientDark)]
            
        default:
            []
        }
    }
    
    var invertGradientColors: [Color] {
        return switch self {
        case .primaryGradient:
            [Color(color: .primaryGradientDark), Color(color: .primaryGradientLight)]
            
        default:
            []
        }
    }

}

