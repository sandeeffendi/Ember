//
//  ResultView.swift
//  ember
//
//  Assessment result screen
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var viewModel: AssessmentViewModel
    let result: BurnoutResult

    private var phase: BurnoutPhase {
        BurnoutPhase(rawValue: result.phase) ?? .healthy
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    StageIndicator(
                        phase: phase,
                        label: result.phaseLabel,
                        score: result.scores.total
                    )

                    HStack(spacing: Spacing.sm) {
                        ScoreCard(label: "Emosional", dimension: "EE",
                                  score: result.scores.ee, max: 12)
                        ScoreCard(label: "Fisik", dimension: "PE",
                                  score: result.scores.pe, max: 8)
                        ScoreCard(label: "Depersonalisasi", dimension: "DP",
                                  score: result.scores.dp, max: 12)
                    }
                    .padding(.horizontal, Spacing.md)

                    InfoCard(
                        icon: "text.quote",
                        title: "Analisis",
                        content: result.narrative
                    )

                    InfoCard(
                        icon: "lightbulb.fill",
                        title: "Rekomendasi",
                        content: result.recommendations
                    )

                    PrimaryButton(title: "Ulangi Asesmen") {
                        viewModel.restart()
                    }
                    .padding(.horizontal, Spacing.md)
                    .padding(.bottom, Spacing.xl)
                }
            }
            .background(Color.AppColors.background.ignoresSafeArea())
            .navigationTitle("Hasil Asesmen")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ScoreCard: View {
    let label: String
    let dimension: String
    let score: Int
    let max: Int

    var body: some View {
        VStack(spacing: Spacing.xs) {
            Text(dimension)
                .font(.caption)
                .foregroundColor(Color.AppColors.textSecondary)
            Text("\(score)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color.AppColors.textPrimary)
            Text("dari \(max)")
                .font(.caption2)
                .foregroundColor(Color.AppColors.textTertiary)
            Text(label)
                .font(.caption2)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.AppColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(Spacing.sm)
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.medium)
                .fill(Color.AppColors.cardBackground)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
}

struct InfoCard: View {
    let icon: String
    let title: String
    let content: String

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
