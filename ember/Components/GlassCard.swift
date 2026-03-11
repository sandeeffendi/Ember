//
//  GlassCard.swift
//  ember
//
//  Glassmorphism style card component
//

import SwiftUI

struct GlassCard<Content: View>: View {
    let content: Content
    var cornerRadius: CGFloat = CornerRadius.extraLarge
    var padding: CGFloat = Spacing.md
    var blurEffect: CGFloat = 10
    var opacity: Double = 0.2
    
    init(
        cornerRadius: CGFloat = CornerRadius.extraLarge,
        padding: CGFloat = Spacing.md,
        blurEffect: CGFloat = 10,
        opacity: Double = 0.2,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.blurEffect = blurEffect
        self.opacity = opacity
    }
    
    var body: some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.regularMaterial)
                    .opacity(opacity)
            )
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.3),
                                Color.white.opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        Color.white.opacity(0.3),
                        lineWidth: 1
                    )
            )
            .shadow(
                color: Color.black.opacity(0.1),
                radius: 8,
                x: 0,
                y: 4
            )
    }
}

// MARK: - GlassCard Preview

struct GlassCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 16) {
                GlassCard {
                    Text("Glass Card")
                        .foregroundColor(.white)
                }
                
                GlassCard(blurEffect: 15, opacity: 0.3) {
                    VStack {
                        Text("Custom Blur")
                            .foregroundColor(.white)
                        Text("With higher opacity")
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
            }
            .padding()
        }
    }
}
