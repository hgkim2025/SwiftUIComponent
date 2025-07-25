//
//  Toast.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import UIKit

extension UIApplication {

    var keyWindow: UIWindow? {
        return connectedScenes
            .first { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive }
            .map { $0 as? UIWindowScene }
            .map { $0?.windows.first } ?? UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow
    }
    
    static func makeToast(_ message: String?) {
        makeCustomToast(message: message!)
    }
    
    static func makeToastAsync(_ message: String?) async {
        makeCustomToast(message: message!)
    }
    
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIApplication {
    
    private static var keyboardHeight: CGFloat = 0
    private static var activeToasts: [(view: UIView, bottomConstraint: NSLayoutConstraint)] = []
    
    static func startKeyboardObserver() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: .main) { notification in
            if activeToasts.isEmpty {
                return
            }
            
            if let userInfo = notification.userInfo,
               let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                keyboardHeight = UIScreen.main.bounds.height - endFrame.origin.y
            }
            
            for (view, constraint) in activeToasts {
                let screenHeight = UIScreen.main.bounds.height
                let newOffset = max(screenHeight * 0.2, keyboardHeight + 20)
                constraint.constant = -newOffset

                UIView.animate(withDuration: 0.3) {
                    view.superview?.layoutIfNeeded()
                }
            }
        }
    }
    
    private static func makeCustomToast(message: String) {
        DispatchQueue.main.async {
            let toastView = CustomToastView(message: message)
            toastView.translatesAutoresizingMaskIntoConstraints = false
            guard let window = UIApplication.shared.keyWindow else { return }
            
            window.addSubview(toastView)
            
            let screenHeight = UIScreen.main.bounds.height
            let bottomOffset = max(screenHeight * 0.2, UIApplication.keyboardHeight + 20)
            let bottomConstraint = toastView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -bottomOffset)
            
            NSLayoutConstraint.activate([
                toastView.centerXAnchor.constraint(equalTo: window.centerXAnchor),
                bottomConstraint,
                toastView.widthAnchor.constraint(lessThanOrEqualToConstant: window.frame.width - 40),
            ])
            
            activeToasts.append((view: toastView, bottomConstraint: bottomConstraint))
            toastView.alpha = 0
            
            
            UIView.animate(withDuration: 0.3, animations: {
                toastView.alpha = 1
            }) { _ in
                UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseInOut, animations: {
                    toastView.alpha = 0
                }) { _ in
                    if let index = activeToasts.firstIndex(where: { $0.view === toastView }) {
                        activeToasts.remove(at: index)
                    }
                    toastView.removeFromSuperview()
                }
            }
        }
    }
    
    private static func makeCustomToastAsync(message: String) async {
        makeCustomToast(message: message)
    }
}

class CustomToastView: UIView {
    private var message: String

    init(message: String) {
        self.message = message
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = AppColor.backgroundDimmed.uiColor
        layer.cornerRadius = 20
        clipsToBounds = true
        setupIconAndMessage()
        
        let screenHeight = UIScreen.main.bounds.height
        let maxHeight = screenHeight * 0.8
        heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight).isActive = true
    }
    
    private func setupIconAndMessage() {
        let iconSize: CGFloat = 24
        let iconImageView = UIImageView()
        iconImageView.setImage(from: .toast_icon)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.cornerRadius = iconSize * 0.4
        iconImageView.layer.masksToBounds = true

        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = AppColor.white.uiColor
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [iconImageView, messageLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            iconImageView.widthAnchor.constraint(equalToConstant: iconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: iconSize)
        ])
    }
}
