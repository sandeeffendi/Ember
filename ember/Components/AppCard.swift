//
//  AppCard.swift
//  ember
//
//  Card component with elevation and styling
//

import SwiftUI

struct AppCard<Content: View>: View {
    let content: Content
    var elevation: Elevation = .low
    var showBorder: Bool = true
    var padding: CGFloat = Spacing.md
    var cornerRadius: CGFloat = CornerRadius.extraLarge
    
    init(
        elevation: Elevation = .low,
        showBorder: Bool = true,
        padding: CGFloat = Spacing.md,
        cornerRadius: CGFloat = CornerRadius.extraLarge,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.elevation = elevation
        self.showBorder = showBorder
        self.padding = padding
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.AppColors.cardBackground)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        showBorder ? Color.AppColors.cardBorder : Color.clear,
                        lineWidth: 1
                    )
            )
            .shadow(
                color: elevation.shadow.color,
                radius: elevation.shadow.radius,
                x: elevation.shadow.x,
                y: elevation.shadow.y
            )
    }
}

// MARK: - AppCard Preview

struct AppCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            AppCard(elevation: .low) {
                Text("Low Elevation Card")
            }
            
            AppCard(elevation: .medium) {
                Text("Medium Elevation Card")
            }
            
            AppCard(elevation: .high) {
                Text("High Elevation Card")
            }
            
            AppCard(elevation: .low, showBorder: false) {
                Text("No Border Card")
            }
        }
        .padding()
        .background(Color.AppColors.background)
    }
}
