//
//  CalendarDayView.swift
//  ember
//

import SwiftUI

/// A single day cell for the weekly calendar in the Weekly Report view.
struct CalendarDayView: View {
    let day: WeekDay
    let isToday: Bool

    var body: some View {
        VStack(spacing: 6) {
            Text(day.label)
                .font(.caption2)
                .foregroundStyle(.secondary)

            ZStack {
                Circle()
                    .fill(
                        day.hasCheckIn
                            ? AnyShapeStyle(Color.teal.opacity(0.15))
                            : AnyShapeStyle(Color.gray.opacity(0.08))
                    )
                    .frame(width: 36, height: 36)
                    .overlay(
                        Circle()
                            .stroke(isToday ? Color.teal : Color.clear, lineWidth: 2)
                    )

                if day.hasCheckIn {
                    Image(systemName: "checkmark")
                        .font(.caption.bold())
                        .foregroundStyle(.teal)
                } else {
                    Image(systemName: "minus")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
            }
        }
    }
}
