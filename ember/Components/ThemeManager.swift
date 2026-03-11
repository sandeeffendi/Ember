//
//  ThemeManager.swift
//  ember
//
//  Theme management for light/dark mode support
//

import SwiftUI
internal import Combine

// MARK: - App Theme

enum AppThemeType: String, CaseIterable {
    case light
    case dark
    case system
}

// MARK: - Theme Manager

@MainActor
final class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var currentTheme: AppThemeType = .system
    
    private init() {
        loadSavedTheme()
    }
    
    var colorScheme: ColorScheme? {
        switch currentTheme {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
    
    func setTheme(_ theme: AppThemeType) {
        currentTheme = theme
        saveTheme()
    }
    
    private func loadSavedTheme() {
        if let saved = UserDefaults.standard.string(forKey: "app_theme"),
           let theme = AppThemeType(rawValue: saved) {
            currentTheme = theme
        }
    }
    
    private func saveTheme() {
        UserDefaults.standard.set(currentTheme.rawValue, forKey: "app_theme")
    }
}

// MARK: - View Extension

extension View {
    func theme(_ themeManager: ThemeManager) -> some View {
        self.preferredColorScheme(themeManager.colorScheme)
    }
}
