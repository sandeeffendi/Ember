//
//  ContentStack.swift
//  ember
//
//  Container for consistent spacing between components
//

import SwiftUI

struct ContentStack<Content: View>: View {
    let content: () -> Content
    var spacing: CGFloat = Spacing.md
    var alignment: HorizontalAlignment = .leading
    
    init(
        spacing: CGFloat = Spacing.md,
        alignment: HorizontalAlignment = .leading,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.spacing = spacing
        self.alignment = alignment
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            content()
        }
    }
}

// MARK: - Adaptive Stack

struct AdaptiveStack<Content: View>: View {
    let content: () -> Content
    var spacing: CGFloat = Spacing.md
    var axis: Axis = .vertical
    
    init(
        spacing: CGFloat = Spacing.md,
        axis: Axis = .vertical,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.spacing = spacing
        self.axis = axis
    }
    
    var body: some View {
        switch axis {
        case .vertical:
            VStack(spacing: spacing) {
                content()
            }
        case .horizontal:
            HStack(spacing: spacing) {
                content()
            }
        }
    }
}

// MARK: - Card Stack

struct CardStack<Content: View>: View {
    let content: () -> Content
    var spacing: CGFloat = Spacing.md
    var elevation: Elevation = .low
    
    init(
        spacing: CGFloat = Spacing.md,
        elevation: Elevation = .low,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.spacing = spacing
        self.elevation = elevation
    }
    
    var body: some View {
        VStack(spacing: spacing) {
            content()
        }
    }
}

// MARK: - ContentStack Preview

struct ContentStack_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: Spacing.lg) {
            ContentStack(spacing: Spacing.sm) {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
            }
            
            AdaptiveStack(spacing: Spacing.md, axis: .horizontal) {
                Text("Horizontal")
                Text("Stack")
            }
        }
        .padding()
        .background(Color.AppColors.background)
    }
}
