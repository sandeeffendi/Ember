//
//  CheckInView.swift
//  ember
//
//  Daily check-in screen
//

import SwiftUI

struct CheckInView: View {
    @StateObject private var viewModel = CheckInViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Group {
            if !viewModel.isPhaseAvailable {
                unavailableView
            } else if viewModel.isSubmitted {
                submittedView
            } else {
                formView
            }
        }
        .background(Color.AppColors.background.ignoresSafeArea())
        .navigationTitle("Daily Check-In")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.refresh()
        }
    }

    // MARK: - Unavailable View (Phase not started)
    private var unavailableView: some View {
        VStack(spacing: Spacing.lg) {
            Image(systemName: "clock.badge.exclamationmark")
                .font(.system(size: 64))
                .foregroundColor(Color.AppColors.textTertiary)
            
            Text("Check-In Not Available")
                .font(Font.AppTypography.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.AppColors.textPrimary)
            
            Text(viewModel.statusMessage)
                .font(.body)
                .foregroundColor(Color.AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.xl)
            
            VStack(spacing: Spacing.sm) {
                Text("Available times:")
                    .font(.caption)
                    .foregroundColor(Color.AppColors.textTertiary)
                
                ForEach(CheckInPhase.allCases, id: \.self) { phase in
                    HStack {
                        Image(systemName: phase.icon)
                            .foregroundColor(phase.isAvailable ? Color.AppColors.secondary : Color.AppColors.textTertiary)
                        Text(phase.label)
                            .foregroundColor(Color.AppColors.textPrimary)
                        Spacer()
                        Text(phase.timeRange)
                            .font(.caption)
                            .foregroundColor(Color.AppColors.textSecondary)
                    }
                    .padding(.horizontal, Spacing.md)
                }
            }
            .padding(Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: CornerRadius.large)
                    .fill(Color.AppColors.cardBackground)
            )
            .padding(.horizontal, Spacing.md)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Form View
    private var formView: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                headerSection

                slidersSection

                PrimaryButton(
                    title: viewModel.isUpdating ? "Update Check-In" : "Submit Check-In",
                    isEnabled: viewModel.canSubmit
                ) {
                    viewModel.submit()
                    dismiss()
                }
                .padding(.horizontal, Spacing.md)
                .padding(.bottom, Spacing.lg)
            }
        }
    }

    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: Spacing.sm) {
            Image(systemName: viewModel.currentPhase.icon)
                .font(.system(size: 44))
                .foregroundColor(Color.AppColors.primary)
            
            Text(viewModel.currentPhase.label + " Check")
                .font(Font.AppTypography.title3)
            
            Text(viewModel.statusMessage)
                .font(Font.AppTypography.caption)
                .foregroundColor(Color.AppColors.textSecondary)
        }
        .padding(.top, Spacing.sm)
    }

    // MARK: - Sliders Section
    private var slidersSection: some View {
        VStack(spacing: Spacing.md) {
            MoodSlider(
                label: "Mood",
                icon: "face.smiling",
                value: $viewModel.moodLevel,
                color: moodColor(for: Int(viewModel.moodLevel))
            )
            MoodSlider(
                label: "Energy",
                icon: "bolt.fill",
                value: $viewModel.energyLevel,
                color: Color.AppColors.warning
            )
            MoodSlider(
                label: "Stress",
                icon: "brain.head.profile",
                value: $viewModel.stressLevel,
                color: Color.AppColors.error
            )
        }
        .padding(Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.extraLarge)
                .fill(Color.AppColors.cardBackground)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 2)
        )
        .padding(.horizontal, Spacing.md)
    }

    // MARK: - Submitted View
    private var submittedView: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                VStack(spacing: Spacing.md) {
                    Image(systemName: viewModel.isUpdating ? "arrow.triangle.2.circlepath" : "checkmark.seal.fill")
                        .font(.system(size: 64))
                        .foregroundColor(Color.AppColors.secondary)
                    
                    Text(viewModel.isUpdating ? "Check-In Updated!" : "Check-In Complete!")
                        .font(Font.AppTypography.title2)
                        .fontWeight(.bold)
                    
                    Text("Your wellbeing has been recorded.")
                        .font(.body)
                        .foregroundColor(Color.AppColors.textSecondary)
                }
                .padding(.top, Spacing.xl)

                // Show existing data
                if let checkIn = viewModel.existingCheckIn {
                    VStack(alignment: .leading, spacing: Spacing.md) {
                        Text("Your response")
                            .font(.headline)
                            .foregroundColor(Color.AppColors.textPrimary)
                        
                        HStack(spacing: Spacing.md) {
                            MetricDisplay(
                                label: "Mood",
                                value: checkIn.moodLevel,
                                icon: "face.smiling",
                                color: moodColor(for: checkIn.moodLevel)
                            )
                            
                            MetricDisplay(
                                label: "Energy",
                                value: checkIn.energyLevel,
                                icon: "bolt.fill",
                                color: Color.AppColors.warning
                            )
                            
                            MetricDisplay(
                                label: "Stress",
                                value: checkIn.stressLevel,
                                icon: "brain.head.profile",
                                color: Color.AppColors.error
                            )
                        }
                    }
                    .padding(Spacing.md)
                    .background(
                        RoundedRectangle(cornerRadius: CornerRadius.large)
                            .fill(Color.AppColors.cardBackground)
                            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    )
                    .padding(.horizontal, Spacing.md)
                }

                // Update button
                PrimaryButton(title: "Update Response") {
                    // Allow update - switch to form
                }
                .padding(.horizontal, Spacing.md)
                .padding(.bottom, Spacing.lg)
            }
        }
    }

    private func moodColor(for level: Int) -> Color {
        switch level {
        case 4...5: return Color.AppColors.secondary
        case 3: return Color.AppColors.warning
        case 1...2: return Color.AppColors.error
        default: return Color.AppColors.textTertiary
        }
    }
}

// MARK: - Mood Slider Component
private struct MoodSlider: View {
    let label: String
    let icon: String
    @Binding var value: Double
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                Label(label, systemImage: icon)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(color)
                Spacer()
                Text("\(Int(value)) / 5")
                    .font(Font.AppTypography.caption)
                    .foregroundColor(Color.AppColors.textSecondary)
            }
            Slider(value: $value, in: 1...5, step: 1)
                .tint(color)
        }
    }
}

// MARK: - Metric Display
private struct MetricDisplay: View {
    let label: String
    let value: Int
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: Spacing.xs) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text("\(value)/5")
                .font(.headline)
                .foregroundColor(Color.AppColors.textPrimary)
            
            Text(label)
                .font(.caption)
                .foregroundColor(Color.AppColors.textSecondary)
            
            HStack(spacing: 2) {
                ForEach(1...5, id: \.self) { index in
                    Circle()
                        .fill(index <= value ? color : color.opacity(0.2))
                        .frame(width: 8, height: 8)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
