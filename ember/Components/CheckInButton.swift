//
//  CheckInButton.swift
//  ember
//

import SwiftUI
internal import Combine

/// A pill-shaped button showing one daily check-in phase (Morning / Midday / Shutdown).
struct CheckInButton: View {
    let phase: CheckInPhase
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: phase.icon)
                Text(phase.label)
                    .fontWeight(.medium)
            }
            .font(.subheadline)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                isActive
                    ? AnyShapeStyle(.tint)
                    : AnyShapeStyle(.regularMaterial)
            )
            .foregroundStyle(isActive ? .white : .primary)
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
