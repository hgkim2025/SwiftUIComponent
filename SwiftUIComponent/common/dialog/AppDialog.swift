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
    VStack {
        AppButton(title: "title only") {
            UIApplication.showDialog { dismiss in
                AppDialog(
                    model: AppDialogModel(
                        title: "삭제하시겠습니까?",
                        confirmBtnTitle: "네",
                        cancelBtnTitle: "아니오"
                    ),
                    dismiss: dismiss
                )
            } // Dialog
        } // : BTN
        
        AppButton(title: "content only") {
            UIApplication.showDialog { dismiss in
                AppDialog(
                    model: AppDialogModel(
                        content: "어떤 개발자가 좋은 개발자일까요?",
                        confirmBtnTitle: "생각해볼게요",
                        cancelBtnTitle: "몰라요"
                    ),
                    dismiss: dismiss
                )
            } // Dialog
        } // : BTN
        
        AppButton(title: "title and content") {
            UIApplication.showDialog { dismiss in
                AppDialog(
                    model: AppDialogModel(
                        title: "코드 리뷰",
                        content: "어떤 코드가 좋은 코드일까요?",
                        confirmBtnTitle: "생각해볼게요",
                        cancelBtnTitle: "몰라요"
                    ),
                    dismiss: dismiss
                )
            } // Dialog
        } // : BTN
        
        AppButton(title: "all") {
            UIApplication.showDialog { dismiss in
                AppDialog(
                    model: AppDialogModel(
                        title: "정답을 골라주세요.",
                        content: "과연 정답이 있을까요? 이 방향이 맞을까요?",
                        highlightTexts: ["정답", "방향"],
                        highlightColors: [.primaryNormal, .purple],
                        confirmBtnTitle: "믿고 가시죠",
                        cancelBtnTitle: "몰라요"
                    ),
                    dismiss: dismiss
                )
            } // Dialog
        } // : BTN
    } // : VS
    .padding(64)
}
