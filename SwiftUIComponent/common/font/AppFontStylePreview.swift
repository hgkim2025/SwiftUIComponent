//
//  AppFontStylePreview.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

struct AppFontStylePreview: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(AppFontStyle.allCases, id: \.self) { style in
                    Text("\(style)")
                        .fontStyle(style)
                } // : FOR
            } // : VS
        } // : SCROLL
    }
}

#Preview {
    AppFontStylePreview()
}
