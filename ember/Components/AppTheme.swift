//
//  AppTheme.swift
//  ember
//
//  Semantic color tokens for light/dark themes
//

import SwiftUI

// MARK: - Semantic Colors

struct SemanticColors {
    let background: Color
    let surface: Color
    let surfaceElevated: Color
    let textPrimary: Color
    let textSecondary: Color
    let textTertiary: Color
    let border: Color
    let divider: Color
}

// MARK: - Light Theme

extension SemanticColors {
    static let light = SemanticColors(
        background: Color(red: 0.97, green: 0.98, blue: 0.98),
        surface: Color.white,
        surfaceElevated: Color.white,
        textPrimary: Color.primary,
        textSecondary: Color.secondary,
        textTertiary: Color.gray.opacity(0.7),
        border: Color.gray.opacity(0.2),
        divider: Color.gray.opacity(0.15)
    )
}

// MARK: - Dark Theme

extension SemanticColors {
    static let dark = SemanticColors(
        background: Color(red: 0.07, green: 0.07, blue: 0.07),
        surface: Color(red: 0.12, green: 0.12, blue: 0.12),
        surfaceElevated: Color(red: 0.17, green: 0.17, blue: 0.17),
        textPrimary: Color.white,
        textSecondary: Color.white.opacity(0.8),
        textTertiary: Color.white.opacity(0.5),
        border: Color.white.opacity(0.15),
        divider: Color.white.opacity(0.1)
    )
}

// MARK: - Theme-aware Color

struct ThemeColor: ViewModifier {
    let light: Color
    let dark: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.primary == .black ? dark : light)
    }
}

extension View {
    func themeColor(light: Color, dark: Color) -> some View {
        self.foregroundColor(Color.primary == .black ? dark : light)
    }
}

// MARK: - Semantic Color Extension

extension Color {
    static var themeBackground: Color {
        Color.primary == .black ? SemanticColors.dark.background : SemanticColors.light.background
    }
    
    static var themeSurface: Color {
        Color.primary == .black ? SemanticColors.dark.surface : SemanticColors.light.surface
    }
    
    static var themeTextPrimary: Color {
        Color.primary == .black ? SemanticColors.dark.textPrimary : SemanticColors.light.textPrimary
    }
    
    static var themeTextSecondary: Color {
        Color.primary == .black ? SemanticColors.dark.textSecondary : SemanticColors.light.textSecondary
    }
    
    static var themeBorder: Color {
        Color.primary == .black ? SemanticColors.dark.border : SemanticColors.light.border
    }
}

// MARK: - Theme Toggle (for testing)

struct ThemeToggle: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text("Current: \(colorScheme == .dark ? "Dark" : "Light")")
    }
}
