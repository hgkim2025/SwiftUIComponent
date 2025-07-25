//
//  ToastPreview.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

struct ToastPreview: View {
    var body: some View {
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
        }

    }
}

#Preview {
    ToastPreview()
}
