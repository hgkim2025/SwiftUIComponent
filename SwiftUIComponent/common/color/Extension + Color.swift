//
//  Extension + Color.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var cleanHex = hex
        while cleanHex.hasPrefix("#") {
            cleanHex.removeFirst()
        }
        
        let scanner = Scanner(string: cleanHex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r, g, b, a: Double
        
        if cleanHex.count == 8 { // #AARRGGBB
            a = Double((rgb >> 24) & 0xFF) / 255.0
            r = Double((rgb >> 16) & 0xFF) / 255.0
            g = Double((rgb >>  8) & 0xFF) / 255.0
            b = Double((rgb >>  0) & 0xFF) / 255.0
        } else if cleanHex.count == 6 { // #RRGGBB
            a = 1.0
            r = Double((rgb >> 16) & 0xFF) / 255.0
            g = Double((rgb >>  8) & 0xFF) / 255.0
            b = Double((rgb >>  0) & 0xFF) / 255.0
        } else {
            // Handle invalid hex string
            r = 0.0
            g = 0.0
            b = 0.0
            a = 1.0
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    init(color: AppColor) {
        self.init(hex: color.hex)
    }
}

extension View {
    func foregroundColor(color: AppColor) -> some View {
        self.foregroundColor(color.color)
    }
    
    func background(color: AppColor) -> some View {
        self.background(color.color)
    }
}

extension Shape {
    
    func fill(color: AppColor) -> some View {
        fill(color.color)
    }
    
    func stroke(color: AppColor, lineWidth: CGFloat = 1.0) -> some View {
        stroke(color.color, lineWidth: lineWidth)
    }
}

