//
//  HomeView.swift
//  ember
//
//  Main home screen
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    headerSection
                    
                    cardsSection
                    
                    Spacer(minLength: Spacing.xl)
                }
                .padding(.top, Spacing.sm)
            }
            .background(Color.AppColors.background.ignoresSafeArea())
            .navigationTitle("Ember")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.circle.fill")
                            .font(.title2)
                            .foregroundColor(Color.AppColors.primary)
                    }
                }
            }
            .refreshable {
                viewModel.refresh()
            }
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(viewModel.greeting)
                .font(Font.AppTypography.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.AppColors.textPrimary)

            Text("How are you feeling today?")
                .font(.subheadline)
                .foregroundColor(Color.AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Spacing.md)
    }
    
    // MARK: - Cards Section
    private var cardsSection: some View {
        VStack(spacing: Spacing.sm) {
            DailyCheckInCard(
                currentPhase: viewModel.currentPhase,
                currentStreak: viewModel.currentStreak,
                phaseGreeting: viewModel.phaseGreeting,
                phaseStatus: viewModel.phaseStatus
            ) {
                CheckInView()
            }

            WeeklyReportCard(
                weekLabel: viewModel.weekLabel,
                completionRate: viewModel.completionRate,
                weekDays: viewModel.weekDays,
                averageMood: viewModel.averageMood,
                averageEnergy: viewModel.averageEnergy,
                averageStress: viewModel.averageStress
            ) {
                WeeklyReportView()
            }
        }
        .padding(.horizontal, Spacing.md)
    }
}
