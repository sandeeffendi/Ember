//
//  ProfileView.swift
//  ember
//
//  Profile screen showing assessment results
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                if let assessment = viewModel.assessment {
                    VStack(spacing: Spacing.sm) {
                        Image(systemName: stageIcon(for: assessment.burnoutStage))
                            .font(.system(size: 56))
                            .foregroundColor(stageColor(for: assessment.burnoutStage))

                        Text(assessment.burnoutStage)
                            .font(Font.AppTypography.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.AppColors.textPrimary)

                        Text("Assessment completed \(assessment.timestamp, style: .date)")
                            .font(Font.AppTypography.caption)
                            .foregroundColor(Color.AppColors.textSecondary)
                    }
                    .padding(.top, Spacing.lg)

                    InfoBlock(
                        title: "Analysis",
                        icon: "text.quote",
                        content: assessment.analysis,
                        iconColor: Color.AppColors.primary
                    )

                    InfoBlock(
                        title: "Recommendation",
                        icon: "lightbulb.fill",
                        content: assessment.recommendation,
                        iconColor: Color.AppColors.warning
                    )

                    Button {
                        appViewModel.resetAssessment()
                    } label: {
                        Label("Retake Assessment", systemImage: "arrow.counterclockwise")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding(Spacing.md)
                            .background(
                                RoundedRectangle(cornerRadius: CornerRadius.medium)
                                    .fill(Color.AppColors.cardBackground)
                                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                            )
                    }
                    .foregroundColor(Color.AppColors.error)
                    .padding(.horizontal, Spacing.md)
                    .padding(.bottom, Spacing.lg)

                } else {
                    VStack(spacing: Spacing.sm) {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 48))
                            .foregroundColor(Color.AppColors.textSecondary)
                        Text("No assessment data found.")
                            .foregroundColor(Color.AppColors.textSecondary)
                    }
                    .padding(.top, Spacing.xl)
                }
            }
        }
        .background(Color.AppColors.background.ignoresSafeArea())
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.large)
        .onAppear { viewModel.load() }
    }

    // MARK: - Helpers
    private func stageIcon(for stage: String) -> String {
        let lower = stage.lowercased()
        if lower.contains("healthy") || lower.contains("aman") { return "checkmark.circle.fill" }
        if lower.contains("dini") || lower.contains("warning") { return "exclamationmark.triangle.fill" }
        if lower.contains("aktif") || lower.contains("active") { return "flame.fill" }
        return "bolt.fill"
    }

    private func stageColor(for stage: String) -> Color {
        let lower = stage.lowercased()
        if lower.contains("healthy") || lower.contains("aman") { return Color.AppColors.secondary }
        if lower.contains("dini") || lower.contains("warning") { return .yellow }
        if lower.contains("aktif") || lower.contains("active") { return Color.AppColors.warning }
        return Color.AppColors.error
    }
}

// MARK: - Info Block
private struct InfoBlock: View {
    let title: String
    let icon: String
    let content: String
    let iconColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Label(title, systemImage: icon)
                .font(.headline)
                .foregroundColor(Color.AppColors.textPrimary)
            Text(content)
                .font(Font.AppTypography.body)
                .foregroundColor(Color.AppColors.textSecondary)
        }
        .padding(Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.large)
                .fill(Color.AppColors.cardBackground)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal, Spacing.md)
    }
}
