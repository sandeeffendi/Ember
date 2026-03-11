//
//  PrimaryButton.swift
//  ember
//
//  Reusable primary button component with states
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isEnabled: Bool = true
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button(action: {
            guard isEnabled else { return }
            action()
        }) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.md)
                .background(
                    RoundedRectangle(cornerRadius: CornerRadius.medium)
                        .fill(isEnabled ? Color.AppColors.primary : Color.gray.opacity(0.3))
                )
                .foregroundColor(isEnabled ? .white : .gray)
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .opacity(isEnabled ? (isPressed ? 0.85 : 1.0) : 1.0)
        .animation(.easeInOut(duration: 0.12), value: isPressed)
        .disabled(!isEnabled)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if isEnabled { isPressed = true }
                }
                .onEnded { _ in
                    isPressed = false
                }
        )
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            PrimaryButton(title: "Start Assessment") {}
            PrimaryButton(
                title: "Disabled Button",
                action:  {
                }, isEnabled: false)
        }
        .padding()
    }
}
