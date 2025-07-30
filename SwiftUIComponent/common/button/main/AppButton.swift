//
//  PrimaryButton.swift
//  SwiftUIComponent
//
//  Created by 김현구 on 7/24/25.
//

import SwiftUI

struct AppButton: View {
    
    let title: String
    let size: AppButtonSize
    let type: AppButtonType
    let icon: AppButtonIcon
    @Binding var disabled: Bool
    let action: () -> Void
    
    @State private var state: AppButtonState
    @State private var buttonFrame: CGRect = .zero
    
    init(
        title: String,
        size: AppButtonSize = .large,
        type: AppButtonType = .primary,
        icon: AppButtonIcon = .none,
        disabled: Binding<Bool> = .constant(false),
        action: @escaping () -> Void
    ) {
        self.title = title
        self.size = size
        self.type = type
        self.icon = icon
        self._disabled = disabled
        self.action = action
        
        if disabled.wrappedValue {
            self.state = .disabled
        } else {
            self.state = .idle
        }
    }
    
    var body: some View {
        let fontColor = type.getFontColor(state: state)
        let backgroundColor = type.getBGColor(state: state)
        let borderColor = type.getBorderColor(state: state)
        let lineWidth = 1.0
        
        RoundedRectangle(cornerRadius: size.radius)
            .foregroundColor(color: backgroundColor)
            .frame(maxWidth: .infinity)
            .frame(height: size.height)
            .overlay {
                ZStack {
                    let imageHeight: CGFloat = size.font.size - 4.0
                    let imageWidth: CGFloat = imageHeight * 5.0/9.0
                    let imagePadding: CGFloat = 5.0
                    
                    HStack(spacing: 0) {
                        // MARK: - left icon
                        if icon == .left {
                            Image(app: .left_chevron)
                                .resizable()
                                .foregroundColor(color: fontColor)
                                .frame(width: imageWidth, height: imageHeight)
                                .padding(.trailing, imagePadding)
                        } // : IF
                        
                        // MARK: - title
                        Text(title)
                            .fontStyle(size.font)
                            .foregroundColor(color: fontColor)
                        
                        // MARK: - right icon
                        if icon == .right {
                            Image(app: .right_chevron)
                                .resizable()
                                .foregroundColor(color: fontColor)
                                .frame(width: imageWidth, height: imageHeight)
                                .padding(.leading, imagePadding)
                        } // : IF
                    } // : HS
                    
                    // MARK: - set button frame for checking isTouchInsideButton
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    buttonFrame = geometry.frame(in: .global)
                                }
                            }
                    } // : GR
                    
                    RoundedRectangle(cornerRadius: size.radius)
                        .stroke(borderColor.color, lineWidth: lineWidth)
                        .padding(lineWidth)
                } // : ZS
            } // : OVERLAY
            .contentShape(Rectangle())
        // MARK: - Gesture
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if !disabled {
                            state = .pressed
                        }
                    }
                    .onEnded { value in
                        if state == .pressed {
                            DispatchQueue.main.asyncAfter(deadline: .now() + state.clickDelay) {
                                state = .idle
                                if isTouchInsideButton(endLocation: value.location, buttonFrame: buttonFrame) {
                                    action()
//                                    UIApplication.makeToast("action()")
                                }
                            }
                        }
                    }
            )
        // MARK: - Animation
            .scaleEffect(state == .pressed ? 0.96 : 1.0)
            .buttonAnimation(value: state)
            .onChange(of: disabled) { newValue in
                state = disabled ? .disabled : .enabled
            }
    }
    
    private func isTouchInsideButton(endLocation: CGPoint, buttonFrame: CGRect) -> Bool {
//        Log.tag(.POINT).d("endLocation: \(endLocation), buttonFrame: \(buttonFrame)")
        let threshold: CGFloat = 8
        
        let checkX = -threshold <= endLocation.x && endLocation.x <= buttonFrame.size.width + threshold
        let checkY = -threshold <= endLocation.y && endLocation.y <= buttonFrame.size.height + threshold
        
        if checkX && checkY {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    AppButtonPreview()
}
