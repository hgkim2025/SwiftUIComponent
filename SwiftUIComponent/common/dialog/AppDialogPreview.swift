//
//  AppDialogPreview.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/30/25.
//

import SwiftUI

struct AppDialogPreview: View {
    var body: some View {
        VStack {
            Text("App Dialog View")
                .fontStyle(.extraTitle)
                .foregroundColor(color: .textStrong)
                .padding()
            
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
                } // : Dialog
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
                } // : Dialog
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
                } // : Dialog
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
                } // : Dialog
            } // : BTN
        } // : VS
        .padding(64)
    }
}

#Preview {
    AppDialogPreview()
}
