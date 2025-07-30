//
//  AppDialog.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/25/25.
//

import SwiftUI

struct AppDialog: View {
    let model: AppDialogModel
    let dismiss: (() -> Void)?

    init(
        model: AppDialogModel,
        dismiss: (() -> Void)? = nil
    ) {
        self.model = model
        self.dismiss = dismiss
    }

    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Title
            if !model.title.isEmpty {
                Text(model.title)
                    .foregroundColor(color: .textStrong)
                    .fontStyle(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
            }
            
            // MARK: - Text
            if !model.content.isEmpty {
                HighlightedText(fullText: model.content,
                                highlightedTexts: model.highlightTexts,
                                highlightColors: model.highlightColors,
                                defaultColor: model.title.isEmpty ? .textNormal : .textAlternative)
                .fontStyle(model.title.isEmpty ? .body1 : .body2)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
            }
            
            // MARK: - Button
            HStack(spacing: 12) {
                if !model.cancelBtnTitle.isEmpty {
                    AppButton(
                        title: model.cancelBtnTitle,
                        size: .middle,
                        type: .primaryLine
                    ) {
                        model.onCancel?()
                        dismiss?()
                    } // : BTN
                } // : IF
                
                if !model.confirmBtnTitle.isEmpty {
                    AppButton(
                        title: model.confirmBtnTitle,
                        size: .middle,
                        type: .primary
                    ) {
                        model.onConfirm?()
                        dismiss?()
                    } // : BTN
                } // IF
            } // : HS
            
        } // : VS
        .frame(width: 260)
        .padding(.vertical, 32)
        .padding(.horizontal, 24)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(color: .white)
        }
    }
}

// MARK: - Preview
#Preview {
    AppDialogPreview()
}
