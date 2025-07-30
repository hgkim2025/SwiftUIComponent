//
//  SwiftUIComponentApp.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

@main
struct SwiftUIComponentApp: App {
    
    @StateObject var navigationObject = NavigationObject.shared
    
    init() {
        UIApplication.startKeyboardObserver()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationObject)
        }
    }
}
