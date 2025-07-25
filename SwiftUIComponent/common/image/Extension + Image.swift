//
//  Extension + Image.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

extension Image {
    
    init(app: AppImage) {
        self.init(app.rawValue)
    }
}

extension UIImage {
    convenience init?(app: AppImage) {
        self.init(named: app.rawValue)
    }
}

extension UIImageView {
    func setImage(from appImage: AppImage) {
        self.image = UIImage(named: appImage.rawValue)
    }
}
