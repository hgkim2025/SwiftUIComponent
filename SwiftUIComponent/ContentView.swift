//
//  ContentView.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear{
            Log.setLogLevel(LogLevel.DEBUG)
            Log.tag(.CALL).t("message")
            Log.tag(.GROUP).tag(.URI).tag(.FLOOR).e("message")
            Log.tag([.CALL, Tag.URI]).d("message")
            Log.tag([.MESSAGE, .NOTIFY]).tag(.URI).d("message")
            Log.tag(.CALL).tag([.URI, .NAME]).d("message")
        }
    }
}

#Preview {
    ContentView()
}
