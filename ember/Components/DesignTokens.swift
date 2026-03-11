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

// MARK: - Gradient Colors

extension LinearGradient {
    enum AppGradients {
        static let primary = LinearGradient(
            colors: [Color(hex: "4A90D9"), Color(hex: "6BA3E0")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let secondary = LinearGradient(
            colors: [Color(hex: "4CAF50"), Color(hex: "81C784")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let warning = LinearGradient(
            colors: [Color(hex: "FF9800"), Color(hex: "FFB74D")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let error = LinearGradient(
            colors: [Color(hex: "F44336"), Color(hex: "EF5350")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let background = LinearGradient(
            colors: [Color(hex: "F8F9FA"), Color(hex: "FFFFFF")],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Shadow Tokens

struct AppShadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    static let small = AppShadow(
        color: Color.black.opacity(0.05),
        radius: 4,
        x: 0,
        y: 2
    )
    
    static let medium = AppShadow(
        color: Color.black.opacity(0.08),
        radius: 8,
        x: 0,
        y: 4
    )
    
    static let large = AppShadow(
        color: Color.black.opacity(0.12),
        radius: 16,
        x: 0,
        y: 8
    )
}

// MARK: - Elevation

enum Elevation {
    case none
    case low
    case medium
    case high
    
    var shadow: AppShadow {
        switch self {
        case .none: return AppShadow(color: .clear, radius: 0, x: 0, y: 0)
        case .low: return .small
        case .medium: return .medium
        case .high: return .large
        }
    }
}

// MARK: - Surface Colors

extension Color {
    enum AppSurface {
        static let primary = Color(hex: "4A90D9")
        static let secondary = Color(hex: "4CAF50")
        static let tertiary = Color(hex: "9C27B0")
        static let surface = Color.white
        static let surfaceElevated = Color.white
        static let overlay = Color.black.opacity(0.4)
    }
}

// MARK: - Animation Tokens

enum AppAnimation {
    static let quick: Double = 0.12
    static let standard: Double = 0.2
    static let slow: Double = 0.25
    static let reveal: Double = 0.35
    
    static let spring: SwiftUI.Animation = .spring(duration: 0.3)
    static let springBounce: SwiftUI.Animation = .spring(response: 0.3, dampingFraction: 0.7)
    static let easeInOut: SwiftUI.Animation = .easeInOut(duration: standard)
    static let easeOut: SwiftUI.Animation = .easeOut(duration: standard)
}

// MARK: - View Modifiers for Animations

extension View {
    func cardAppearance(_ isAppearing: Bool = true) -> some View {
        self
            .opacity(isAppearing ? 0 : 1)
            .scaleEffect(isAppearing ? 0.95 : 1)
            .animation(.easeOut(duration: AppAnimation.standard), value: isAppearing)
    }
    
    func buttonPress(_ isPressed: Bool) -> some View {
        self
            .scaleEffect(isPressed ? 0.98 : 1)
            .opacity(isPressed ? 0.85 : 1)
            .animation(.easeInOut(duration: AppAnimation.quick), value: isPressed)
    }
    
    func answerSelection(_ isSelected: Bool) -> some View {
        self
            .scaleEffect(isSelected ? 1.0 : 0.95)
            .opacity(isSelected ? 1.0 : 0.8)
            .animation(.easeInOut(duration: AppAnimation.quick), value: isSelected)
    }
    
    func resultReveal(_ isRevealed: Bool) -> some View {
        self
            .opacity(isRevealed ? 1 : 0)
            .scaleEffect(isRevealed ? 1 : 0.9)
            .animation(.easeOut(duration: AppAnimation.reveal), value: isRevealed)
    }
}
