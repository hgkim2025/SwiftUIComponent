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
            
            Button {
                UIApplication.makeToast("Hello, World!")
            } label: {
                
                RoundedRectangle(cornerRadius: 16)
                    .fill(color: .primaryNormal)
                    .frame(width: 200, height: 100)
                    .overlay {
                        Text("Show Taost")
                            .fontStyle(.title1)
                            .foregroundColor(color: .textWhite)
                    }
            } // : BTN
        } // : VS
    }
}

#Preview {
    AppToastPreview()
}
