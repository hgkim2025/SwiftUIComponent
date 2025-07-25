//
//  Extension + Button.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import Foundation
import SwiftUI

extension View {
    func buttonAnimation<V>(value: V) -> some View where V : Equatable {
        if value is AppButtonState {
            let state = value as! AppButtonState
            switch state {
            case .enabled, .disabled:
                return self.animation(.smooth(duration: state.clickDelay), value: value)
            default:
                return self.animation(.easeOut(duration: state.clickDelay), value: value)
            }
        } else {
            return self.animation(.easeOut, value: value)
        }
    }
}
