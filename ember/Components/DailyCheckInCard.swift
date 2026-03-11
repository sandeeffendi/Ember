//
//  DailyCheckInCard.swift
//  ember
//
//  Enhanced daily check-in card for homepage
//

import SwiftUI

struct DailyCheckInCard<Destination: View>: View {
    let currentPhase: CheckInPhase
    let currentStreak: Int
    let phaseGreeting: String
    let phaseStatus: [CheckInPhase: DailyCheckIn?]
    let destination: () -> Destination
    
    @State private var isPressed: Bool = false
    
    init(
        currentPhase: CheckInPhase,
        currentStreak: Int,
        phaseGreeting: String,
        phaseStatus: [CheckInPhase: DailyCheckIn?],
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        self.currentPhase = currentPhase
        self.currentStreak = currentStreak
        self.phaseGreeting = phaseGreeting
        self.phaseStatus = phaseStatus
        self.destination = destination
    }
    
    private var phaseColor: Color {
        switch currentPhase {
        case .morning: return .orange
        case .midday: return .yellow
        case .shutdown: return .indigo
        }
    }
    
    private var isCurrentPhaseAvailable: Bool {
        currentPhase.isAvailable
    }
    
    private var currentPhaseCheckIn: DailyCheckIn? {
        phaseStatus[currentPhase] ?? nil
    }
    
    private var hasCheckedInCurrentPhase: Bool {
        currentPhaseCheckIn != nil
    }
    
    var body: some View {
        NavigationLink(destination: destination()) {
            VStack(alignment: .leading, spacing: Spacing.md) {
                headerSection
                
                phaseStatusSection
                
                if currentStreak > 0 {
                    streakSection
                }
            }
            .padding(Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: CornerRadius.extraLarge)
                    .fill(Color.AppColors.cardBackground)
                    .shadow(color: AppShadow.medium.color, radius: AppShadow.medium.radius, x: AppShadow.medium.x, y: AppShadow.medium.y)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(phaseColor.opacity(0.15))
                    .frame(width: 52, height: 52)
                Image(systemName: currentPhase.icon)
                    .font(.title2)
                    .foregroundColor(phaseColor)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text("\(currentPhase.label) Check-In")
                        .font(.headline)
                        .foregroundColor(Color.AppColors.textPrimary)
                    
                    if hasCheckedInCurrentPhase {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption)
                            .foregroundColor(Color.AppColors.secondary)
                    }
                }
                
                Text(phaseGreeting)
                    .font(.subheadline)
                    .foregroundColor(Color.AppColors.textSecondary)
                
                Text(currentPhase.timeRange)
                    .font(.caption)
                    .foregroundColor(Color.AppColors.textTertiary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.subheadline)
                .foregroundColor(Color.AppColors.textTertiary)
        }
    }
    
    // MARK: - Phase Status Section
    private var phaseStatusSection: some View {
        VStack(spacing: Spacing.sm) {
            HStack {
                Text("Today's Progress")
                    .font(.caption)
                    .foregroundColor(Color.AppColors.textSecondary)
                Spacer()
            }
            
            HStack(spacing: Spacing.sm) {
                ForEach(CheckInPhase.allCases, id: \.self) { phase in
                    PhaseStatusBadge(
                        phase: phase,
                        checkIn: phaseStatus[phase] ?? nil
                    )
                }
            }
        }
        .padding(Spacing.sm)
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.medium)
                .fill(Color.AppColors.secondary.opacity(0.08))
        )
    }
    
    // MARK: - Streak Section
    private var streakSection: some View {
        HStack {
            Image(systemName: "flame.fill")
                .foregroundColor(.orange)
            
            Text("\(currentStreak) day\(currentStreak == 1 ? "" : "s") streak")
                .font(.caption.bold())
                .foregroundColor(Color.AppColors.textPrimary)
            
            Spacer()
        }
    }
}

// MARK: - Phase Status Badge
private struct PhaseStatusBadge: View {
    let phase: CheckInPhase
    let checkIn: DailyCheckIn?
    
    private var isCompleted: Bool {
        checkIn != nil
    }
    
    private var isCurrent: Bool {
        phase == CheckInPhase.current
    }
    
    private var color: Color {
        if isCompleted {
            return Color.AppColors.secondary
        }
        if isCurrent {
            return Color.AppColors.primary
        }
        return Color.AppColors.textTertiary
    }
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                Circle()
                    .fill(color.opacity(isCurrent ? 0.15 : 0.08))
                    .frame(width: 40, height: 40)
                
                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.caption.bold())
                        .foregroundColor(color)
                } else {
                    Image(systemName: phase.icon)
                        .font(.caption)
                        .foregroundColor(color.opacity(isCurrent ? 1 : 0.5))
                }
            }
            .overlay(
                Circle()
                    .stroke(isCurrent ? Color.AppColors.primary : Color.clear, lineWidth: 2)
            )
            
            Text(phase.label)
                .font(.caption2)
                .foregroundColor(isCurrent ? Color.AppColors.textPrimary : Color.AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Metric Badge
private struct MetricBadge: View {
    let label: String
    let value: Int
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
            
            Text("\(value)/5")
                .font(.subheadline.bold())
                .foregroundColor(Color.AppColors.textPrimary)
            
            Text(label)
                .font(.caption2)
                .foregroundColor(Color.AppColors.textTertiary)
            
            HStack(spacing: 2) {
                ForEach(1...5, id: \.self) { index in
                    Circle()
                        .fill(index <= value ? color : color.opacity(0.2))
                        .frame(width: 6, height: 6)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
