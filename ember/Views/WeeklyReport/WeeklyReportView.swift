//
//  WeeklyReportView.swift
//  ember
//
//  Weekly report screen with detailed insights
//

import SwiftUI

struct WeeklyReportView: View {
    @StateObject private var viewModel = WeeklyReportViewModel()

    var body: some View {
        ScreenContainer {
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    weekSummarySection
                    
                    weeklyInsightSection
                    
                    Spacer(minLength: Spacing.xl)
                }
                .padding(.top, Spacing.md)
            }
        }
        .navigationTitle("Weekly Report")
        .navigationBarTitleDisplayMode(.large)
        .onAppear { viewModel.load() }
    }
    
    // MARK: - Week Summary Section
    private var weekSummarySection: some View {
        SectionHeader(
            title: "This Week",
            icon: "calendar"
        )
        
        return AppCard(elevation: .low) {
            HStack(spacing: 0) {
                ForEach(viewModel.weekDays) { day in
                    CalendarDayView(
                        day: day,
                        isToday: day.date == DateUtils.startOfDay(for: Date())
                    )
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, Spacing.md)
    }
    
    // MARK: - Weekly Insight Section
    private var weeklyInsightSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            SectionHeader(
                title: "Weekly Insight",
                icon: "lightbulb.fill"
            )
            
            if viewModel.weekDays.filter(\.hasCheckIn).isEmpty {
                emptyStateView
            } else {
                insightCardsView
            }
        }
        .padding(.horizontal, Spacing.md)
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        AppCard(elevation: .low) {
            VStack(spacing: Spacing.sm) {
                Image(systemName: "chart.bar.doc.horizontal")
                    .font(.system(size: 36))
                    .foregroundColor(Color.AppColors.textSecondary)
                Text("No check-ins yet this week.")
                    .font(.subheadline)
                    .foregroundColor(Color.AppColors.textSecondary)
                Text("Start your daily check-ins to see insights here.")
                    .font(.caption)
                    .foregroundColor(Color.AppColors.textTertiary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(Spacing.md)
        }
    }
    
    // MARK: - Insight Cards
    private var insightCardsView: some View {
        VStack(spacing: Spacing.sm) {
            InsightCard(
                label: "Avg Mood",
                value: viewModel.averageMood,
                icon: "face.smiling",
                color: .orange
            )
            
            InsightCard(
                label: "Avg Energy",
                value: viewModel.averageEnergy,
                icon: "bolt.fill",
                color: Color.AppColors.warning
            )
            
            InsightCard(
                label: "Avg Stress",
                value: viewModel.averageStress,
                icon: "brain.head.profile",
                color: Color.AppColors.error
            )
        }
    }
}

// MARK: - Insight Card
private struct InsightCard: View {
    let label: String
    let value: Double
    let icon: String
    let color: Color
    
    var body: some View {
        AppCard(elevation: .low) {
            HStack {
                Label(label, systemImage: icon)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(color)
                Spacer()
                HStack(spacing: 4) {
                    ForEach(1...5, id: \.self) { dot in
                        Circle()
                            .fill(dot <= Int(value.rounded()) ? color : color.opacity(0.2))
                            .frame(width: 10, height: 10)
                    }
                }
                Text(String(format: "%.1f", value))
                    .font(Font.AppTypography.caption)
                    .foregroundColor(Color.AppColors.textSecondary)
                    .frame(width: 28, alignment: .trailing)
            }
        }
    }
}
