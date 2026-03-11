//
//  SelectableCard.swift
//  ember
//
//  Reusable selectable card for answer options
//

import SwiftUI

struct SelectableCard: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(text)
                    .font(.body)
                    .foregroundColor(isSelected ? .white : Color.AppColors.textPrimary)
                
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.body)
                    .foregroundColor(isSelected ? .white : Color.AppColors.textTertiary)
            }
            .padding(Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: CornerRadius.medium)
                    .fill(isSelected ? Color.AppColors.primary : Color.AppColors.cardBackground)
            )
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.medium)
                    .stroke(isSelected ? Color.AppColors.primary : Color.AppColors.cardBorder, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .opacity(isPressed ? 0.8 : 1.0)
        .animation(.easeInOut(duration: 0.12), value: isPressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}

struct SelectableCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 12) {
            SelectableCard(text: "Hampir tidak pernah", isSelected: false) {}
            SelectableCard(text: "Kadang-kadang", isSelected: true) {}
            SelectableCard(text: "Sering", isSelected: false) {}
            SelectableCard(text: "Hampir selalu", isSelected: false) {}
        }
        .padding()
    }
}
