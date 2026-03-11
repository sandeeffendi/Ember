//
//  DesignTokens.swift
//  ember
//
//  Design System: Colors, Typography, and Spacing
//

import SwiftUI

// MARK: - App Colors

extension Color {
    enum AppColors {
        static let primary = Color(hex: "4A90D9")
        static let secondary = Color(hex: "4CAF50")
        static let warning = Color(hex: "FF9800")
        static let error = Color(hex: "F44336")
        static let background = Color(hex: "F8F9FA")
        
        static let cardBackground = Color.white
        static let cardBorder = Color.gray.opacity(0.2)
        static let textPrimary = Color.primary
        static let textSecondary = Color.secondary
        static let textTertiary = Color.gray.opacity(0.7)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - App Typography

extension Font {
    enum AppTypography {
        static let largeTitle = Font.largeTitle.bold()
        static let title2 = Font.title2.bold()
        static let title3 = Font.title3.weight(.medium)
        static let body = Font.body
        static let caption = Font.caption
        static let captionBold = Font.caption.bold()
    }
}

// MARK: - Spacing

enum Spacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
}

// MARK: - Corner Radius

enum CornerRadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 16
    static let extraLarge: CGFloat = 20
}
