//
//  ContentView.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationObject: NavigationObject
    let padding: CGFloat = 64
    let spacing: CGFloat = 8
    
    
    var body: some View {
        NavigationStack(path: $navigationObject.path) {
            VStack(spacing: spacing) {
                ForEach(NavigationStackType.allCases, id: \.self) { stack in
                    AppButton(title: "\(stack)") {
                        navigationObject.push(stack)
                    }
                }
            }
            .padding(.horizontal, padding)
            .navigationDestination(for: String.self) { value in
                if let navigationStackType = NavigationStackType(rawValue: value) {
                    switch navigationStackType {
                    case .dialog:
                        AppDialogPreview()
                    case .toast:
                        AppToastPreview()
                    case .button:
                        AppButtonPreview()
                    case .color:
                        AppColorPreview()
                    case .fontStyle:
                        AppFontStylePreview()
                    }
                } else {
                    VStack(spacing: 16) {
                        Text("⚠️ Unknown Page")
                            .font(.title)
                        Text("Raw value: \(value)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NavigationObject.shared)
}
