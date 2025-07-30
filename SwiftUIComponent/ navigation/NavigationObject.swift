//
//  navigationData.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/30/25.
//

import Foundation
import SwiftUI

enum NavigationStackType: String, CaseIterable {
    case dialog
    case toast
    case button
    case color
    case fontStyle
}

class NavigationObject: ObservableObject {
    
    static let shared = NavigationObject()
    @Published var path = NavigationPath()
    
    @MainActor
    func clear() {
        path.removeLast(path.count)
    }
    
    func push(_ type: NavigationStackType) {
        Log.tag(.ROUTER).d("push - \(type.rawValue)")
        path.append(type.rawValue)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func removePaths(upto type: NavigationStackType) {
        removePaths(upto: type.rawValue)
    }
    
    func removePaths(upto target: String) {
        if let codable = path.codable {
            
            do {
                let data = try JSONEncoder().encode(codable)
                let str = String(decoding: data, as: UTF8.self)
                Log.tag(.ROUTER).d(String(decoding: data, as: UTF8.self))
                let list = str
                    .replacingOccurrences(of: " ", with: "")
                    .replacingOccurrences(of: "[", with: "")
                    .replacingOccurrences(of: "]", with: "")
                    .replacingOccurrences(of: "\"", with: "")
                    .replacingOccurrences(of: "\\", with: "")
                    .split(separator: ",").filter { $0 != "Swift.String" }
                
                var find = false
                var count = 0
                
                for item in list {
                    let str = String(item)
                    if str == target {
                        find = true
                        break
                    }
                    Log.tag(.ROUTER).d("pop - \(str)")
                    count += 1
                }
                
                assert(find)
                assert(count <= path.count)
                
                path.removeLast(count)
            } catch {
                assert(false)
            }
        }
    }
}
