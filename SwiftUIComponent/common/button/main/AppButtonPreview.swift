//
//  PrevieButtonView.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/30/25.
//

import SwiftUI

struct AppButtonPreview: View {
    @State var disabled: Bool = false
    let padding: CGFloat = 64
    let spacing: CGFloat = 8
    
    var body: some View {
        VStack {
            ScrollView (showsIndicators: false) {
                VStack(alignment: .leading, spacing: spacing) {
                    ForEach(AppButtonType.allCases, id: \.self) { type in
                        Text("\(type)")
                            .fontStyle(.title2)
                        AppButton(
                            title: "Large",
                            size: .large,
                            type: type,
                            icon: .right,
                            disabled: $disabled,
                            action: {}
                        )
                        AppButton(
                            title: "Middle",
                            size: .middle,
                            type: type,
                            icon: .none,
                            disabled: $disabled,
                            action: {}
                        )
                        AppButton(
                            title: "Small",
                            size: .small,
                            type: type,
                            icon: .left,
                            disabled: $disabled,
                            action: {}
                        )
                        Spacer()
                            .frame(height: spacing)
                    } // : FOR
                    
                } // : VS
                .padding(.horizontal, padding)
            } // : SCROLL
            
            AppButton(
                title: disabled ? "active all" : "disable all",
                size: .large,
                type: .primary,
                icon: .none,
                action: {
//                    UIApplication.makeToast("disabled - \(disabled)")
                    disabled = !disabled
                }
            )
            .padding(.horizontal, padding)
        } // : VS
        .animation(.default, value: disabled)
    }
}

#Preview {
    AppButtonPreview()
}
