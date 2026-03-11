//
//  ScreenContainer.swift
//  ember
//
//  Main screen container with safe area and background
//

import SwiftUI

struct ScreenContainer<Content: View>: View {
    let content: Content
    var showBackground: Bool = true
    var padding: EdgeInsets = EdgeInsets(
        top: Spacing.md,
        leading: Spacing.md,
        bottom: Spacing.md,
        trailing: Spacing.md
    )
    
    init(
        showBackground: Bool = true,
        padding: EdgeInsets = EdgeInsets(
            top: Spacing.md,
            leading: Spacing.md,
            bottom: Spacing.md,
            trailing: Spacing.md
        ),
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.showBackground = showBackground
        self.padding = padding
    }
    
    var body: some View {
        content
            .padding(padding)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Group {
                    if showBackground {
                        Color.AppColors.background
                            .ignoresSafeArea()
                    }
                }
            )
    }
}

// MARK: - ScreenContainer Preview

struct ScreenContainer_Previews: PreviewProvider {
    static var previews: some View {
        ScreenContainer {
            Text("Screen Content")
        }
    }
}
