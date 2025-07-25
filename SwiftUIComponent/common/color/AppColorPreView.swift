//
//  AppColorPreView.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

struct AppColorPreView: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(AppColor.allCases, id: \.self) { color in
                    Text("\(color)")
                        .fontStyle(.subtitle1)
                        .foregroundColor(color: .primaryAlternative)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(color: color)
                        
                } // : FOR
            } // : VS
        } // : SCROLL
    }
}

#Preview {
    AppColorPreView()
}
