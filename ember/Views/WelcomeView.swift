//
//  WelcomeView.swift
//  ember
//
//  Assessment entry screen
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var viewModel: AssessmentViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: Spacing.xl) {
                Spacer()

                VStack(spacing: Spacing.md) {
                    Image(systemName: "heart.text.clipboard.fill")
                        .font(.system(size: 72))
                        .foregroundColor(Color.AppColors.primary)

                    Text("Pahami Tingkat Burnoutmu")
                        .font(Font.AppTypography.largeTitle)
                        .multilineTextAlignment(.center)

                    Text("Asesmen singkat ini membantu kamu memahami kondisi mental saat ini dan mengidentifikasi tanda-tanda awal burnout.")
                        .font(Font.AppTypography.body)
                        .foregroundColor(Color.AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, Spacing.lg)
                }

                AppCard(elevation: .low) {
                    VStack(spacing: Spacing.sm) {
                        InfoRow(icon: "list.number", text: "8 pertanyaan singkat")
                        InfoRow(icon: "clock", text: "Selesai dalam 2–3 menit")
                        InfoRow(icon: "brain.head.profile", text: "Dianalisis oleh AI berbasis MBI")
                    }
                }
                .padding(.horizontal, Spacing.md)

                Spacer()

                PrimaryButton(title: "Mulai Asesmen") {
                    viewModel.startAssessment()
                }
                .padding(.horizontal, Spacing.md)
                .padding(.bottom, Spacing.xl)
            }
            .background(Color.AppColors.background.ignoresSafeArea())
        }
    }
}

struct InfoRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: icon)
                .foregroundColor(Color.AppColors.primary)
                .frame(width: 24)
            Text(text)
                .font(.subheadline)
                .foregroundColor(Color.AppColors.textPrimary)
            Spacer()
        }
    }
}
