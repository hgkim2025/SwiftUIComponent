//
//  AppDialogModel.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/25/25.
//

import Foundation

struct AppDialogModel {
    let title: String
    let content: String
    let highlightTexts: [String]
    let highlightColors: [AppColor]
    let confirmBtnTitle: String
    let cancelBtnTitle: String
    let onConfirm: (() -> Void)?
    let onCancel: (() -> Void)?
    let onDismiss: (() -> Void)?
    let dismissOnOutsideTap: Bool
    
    init(
        title: String = "",
        content: String = "",
        highlightTexts: [String] = [],
        highlightColors: [AppColor] = [],
        confirmBtnTitle: String = "",
        cancelBtnTitle: String = "",
        onConfirm: (() -> Void)? = nil,
        onCancel: (() -> Void)? = nil,
        onDismiss: (() -> Void)? = nil,
        dismissOnOutsideTap: Bool = true
    ) {
        self.title = title
        self.content = content
        self.highlightTexts = highlightTexts
        self.highlightColors = highlightColors
        self.confirmBtnTitle = confirmBtnTitle
        self.cancelBtnTitle = cancelBtnTitle
        self.onConfirm = onConfirm
        self.onCancel = onCancel
        self.onDismiss = onDismiss
        self.dismissOnOutsideTap = dismissOnOutsideTap
    }
}
