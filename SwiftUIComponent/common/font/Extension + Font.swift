//
//  Extension + Font.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

extension Font {
    static func pretendard(_ type: Pretendard, size: CGFloat) -> Font {
        return .custom(type.rawValue, size: size)
    }
}


extension View {
    func fontStyle(_ appFontStyle: AppFontStyle) -> some View {
        self.modifier(AppFontModifier(appFontStyle: appFontStyle))
    }
}


private struct AppFontModifier: ViewModifier {
    let appFontStyle: AppFontStyle
    func body(content: Content) -> some View {
        let uiFontStyle = UIFont(name: appFontStyle.pretendard.rawValue, size: appFontStyle.size) ?? UIFont.systemFont(ofSize: appFontStyle.size)
        let lineSpacing = appFontStyle.lineHeight - uiFontStyle.lineHeight
        
        return content
            .font(.pretendard(appFontStyle.pretendard, size: appFontStyle.size))
            .lineSpacing(lineSpacing)
            .tracking(appFontStyle.letterSpacing)
            .padding(.vertical, lineSpacing / 2)
            .padding(.trailing, appFontStyle.paragraphSpacing)
    }
}
