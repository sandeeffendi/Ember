//
//  DayDetailSheet.swift
//  ember
//
//  Bottom sheet showing detailed check-in data for a specific day
//

import SwiftUI

struct DayDetailSheet: View {
    let day: WeekDay
    @Environment(\.dismiss) private var dismiss
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    headerSection
                    
                    if day.hasCheckIn {
                        metricsSection
                        
                        if let note = day.note, !note.isEmpty {
                            noteSection(note)
                        }
                        
                        statusBadge
                    } else {
                        emptyStateSection
                    }
                }
                .padding(Spacing.md)
            }
            .background(Color.AppColors.background)
            .navigationTitle("Day Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: Spacing.sm) {
            Text(dateFormatter.string(from: day.date))
                .font(Font.AppTypography.title3)
                .foregroundColor(Color.AppColors.textPrimary)
            
            Text(day.label)
                .font(.subheadline)
                .foregroundColor(Color.AppColors.textSecondary)
        }
        .padding(.top, Spacing.md)
    }
    
    // MARK: - Metrics Section
    private var metricsSection: some View {
        VStack(spacing: Spacing.md) {
            HStack(spacing: Spacing.md) {
                MetricCard(
                    title: "Mood",
                    value: day.moodLevel ?? 0,
                    icon: "face.smiling",
                    color: moodColor
                )
                
                MetricCard(
                    title: "Energy",
                    value: day.energyLevel ?? 0,
                    icon: "bolt.fill",
                    color: Color.AppColors.warning
                )
                
                MetricCard(
                    title: "Stress",
                    value: day.stressLevel ?? 0,
                    icon: "brain.head.profile",
                    color: Color.AppColors.error
                )
            }
        }
        .padding(Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.large)
                .fill(Color.AppColors.cardBackground)
                .shadow(color: AppShadow.small.color, radius: AppShadow.small.radius, x: AppShadow.small.x, y: AppShadow.small.y)
        )
    }
    
    // MARK: - Note Section
    private func noteSection(_ note: String) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Label("Notes", systemImage: "note.text")
                .font(.headline)
                .foregroundColor(Color.AppColors.textPrimary)
            
            Text(note)
                .font(.body)
                .foregroundColor(Color.AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.md)
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.large)
                .fill(Color.AppColors.cardBackground)
                .shadow(color: AppShadow.small.color, radius: AppShadow.small.radius, x: AppShadow.small.x, y: AppShadow.small.y)
        )
    }
    
    // MARK: - Status Badge
    private var statusBadge: some View {
        HStack {
            Image(systemName: day.hasCheckIn ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(day.hasCheckIn ? Color.AppColors.secondary : Color.AppColors.textTertiary)
            
            Text(day.hasCheckIn ? "Check-in Completed" : "No Check-in")
                .font(.subheadline)
                .foregroundColor(Color.AppColors.textSecondary)
        }
        .padding(Spacing.sm)
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.medium)
                .fill(day.hasCheckIn ? Color.AppColors.secondary.opacity(0.1) : Color.gray.opacity(0.1))
        )
    }
    
    // MARK: - Empty State
    private var emptyStateSection: some View {
        VStack(spacing: Spacing.md) {
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 48))
                .foregroundColor(Color.AppColors.textTertiary)
            
            Text("No check-in recorded")
                .font(.headline)
                .foregroundColor(Color.AppColors.textPrimary)
            
            Text("Start your day with a check-in to track your wellbeing.")
                .font(.subheadline)
                .foregroundColor(Color.AppColors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(Spacing.xl)
    }
    
    private var moodColor: Color {
        guard let mood = day.moodLevel else { return Color.AppColors.textTertiary }
        switch mood {
        case 4...5: return Color.AppColors.secondary
        case 3: return Color.AppColors.warning
        case 1...2: return Color.AppColors.error
        default: return Color.AppColors.textTertiary
        }
    }
}

// MARK: - Metric Card
private struct MetricCard: View {
    let title: String
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
            
            Text(title)
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
