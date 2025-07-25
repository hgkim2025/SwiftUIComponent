//
//  Extension + Dialog.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/25/25.
//

import Foundation
import UIKit
import SwiftUI

class AppDialogView: UIView {
    private let contentView: UIView
    private let dismissOnOutsideTap: Bool
    private let dismissHandler: (() -> Void)?
    private var isBeingDismissed = false

    init(
        content: UIView,
        dismissOnOutsideTap: Bool,
        dismissHandler: (() -> Void)? = nil
    ) {
        self.contentView = content
        self.dismissOnOutsideTap = dismissOnOutsideTap
        self.dismissHandler = dismissHandler
        super.init(frame: .zero)
        setupView()
        prepareInitialState()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = AppColor.backgroundDimmed.uiColor
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width - 60)
        ])

        if dismissOnOutsideTap {
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
            addGestureRecognizer(tap)
        }
    }

    private func prepareInitialState() {
        alpha = 0
        contentView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }

    func animateShow() {
        UIView.animate(
            withDuration: 0.25,
            delay: 0.1,
            usingSpringWithDamping: 0.75,
            initialSpringVelocity: 0.8,
            options: [.curveEaseOut],
            animations: {
                self.alpha = 1
                self.contentView.transform = .identity
            },
            completion: nil
        )
    }

    @objc func dismiss() {
        guard !isBeingDismissed else { return }
        isBeingDismissed = true

        UIView.animate(
            withDuration: 0.2,
            delay: 0.1,
            options: [.curveEaseIn],
            animations: {
                self.alpha = 0
                self.contentView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            },
            completion: { _ in
                self.dismissHandler?()
                self.removeFromSuperview()
            }
        )
    }
}

extension UIApplication {
    static func showDialog<V: View>(
        _ swiftUIView: @escaping (_ dismiss: @escaping () -> Void) -> V,
        onDismiss: (() -> Void)? = nil,
        dismissOnOutsideTap: Bool = true
    ) {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.keyWindow else { return }

            var dialogView: AppDialogView?

            let swiftUIViewWithDismiss = swiftUIView {
                dialogView?.dismiss()
                onDismiss?()
            }

            let controller = UIHostingController(rootView: swiftUIViewWithDismiss)
            controller.view.backgroundColor = .clear

            dialogView = AppDialogView(
                content: controller.view,
                dismissOnOutsideTap: dismissOnOutsideTap,
                dismissHandler: {
                    onDismiss?()
                }
            )

            dialogView?.translatesAutoresizingMaskIntoConstraints = false
            window.addSubview(dialogView!)

            NSLayoutConstraint.activate([
                dialogView!.topAnchor.constraint(equalTo: window.topAnchor),
                dialogView!.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                dialogView!.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                dialogView!.trailingAnchor.constraint(equalTo: window.trailingAnchor)
            ])

            dialogView?.animateShow()
        }
    }
}
