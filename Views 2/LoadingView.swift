//
//  LoadingView.swift
//  ember
//
//  Created by Sande Effendi on 11/03/26.
//

    // Views/LoadingView.swift
    import SwiftUI

    struct LoadingView: View {
        @State private var isAnimating = false

        var body: some View {
            VStack(spacing: 24) {
                ZStack {
                    Circle()
                        .stroke(.tint.opacity(0.2), lineWidth: 6)
                        .frame(width: 80, height: 80)

                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(.tint, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(
                            .linear(duration: 1).repeatForever(autoreverses: false),
                            value: isAnimating
                        )

                    Image(systemName: "brain.head.profile")
                        .font(.title2)
                        .foregroundStyle(.tint)
                }

                VStack(spacing: 8) {
                    Text("AI sedang menganalisis...")
                        .font(.headline)
                    Text("Mohon tunggu sebentar")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .onAppear { isAnimating = true }
        }
    }
