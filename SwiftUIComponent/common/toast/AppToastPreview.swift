//
//  ToastPreview.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

struct AppToastPreview: View {
    var body: some View {
        VStack {
            Text("App Toast View")
                .fontStyle(.extraTitle)
                .foregroundColor(color: .textStrong)
                .padding()
            
            AppButton(title: "Show Taost") {
                UIApplication.makeToast("Hello, World!")
            } // : BTN
            .padding(.horizontal, 64)
        } // : VS
    }
}

#Preview {
    AppToastPreview()
}
