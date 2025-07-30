//
//  AppColorPreView.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

struct AppColorPreview: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("App Color View")
                    .fontStyle(.extraTitle)
                    .foregroundColor(color: .textStrong)
                    .padding()
                    
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
    AppColorPreview()
}
