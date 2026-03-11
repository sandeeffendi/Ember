//
//  ProfileView.swift
//  ember
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                if let assessment = viewModel.assessment {

                    // MARK: - Burnout Stage Badge
                    VStack(spacing: 10) {
                        Image(systemName: stageIcon(for: assessment.burnoutStage))
                            .font(.system(size: 56))
                            .foregroundStyle(stageColor(for: assessment.burnoutStage))

                        Text(assessment.burnoutStage)
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("Assessment completed \(assessment.timestamp, style: .date)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 24)

                    // MARK: - AI Analysis
                    InfoBlock(
                        title: "Analysis",
                        icon: "text.quote",
                        content: assessment.analysis
                    )

                    // MARK: - AI Recommendation
                    InfoBlock(
                        title: "Recommendation",
                        icon: "lightbulb.fill",
                        content: assessment.recommendation
                    )

                    // MARK: - Retake
                    Button(role: .destructive) {
                        appViewModel.resetAssessment()
                    } label: {
                        Label("Retake Assessment", systemImage: "arrow.counterclockwise")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 32)

                } else {
                    // No assessment yet (should not normally happen via this path)
                    VStack(spacing: 12) {
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 48))
                            .foregroundStyle(.secondary)
                        Text("No assessment data found.")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 60)
                }
            }
        }
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
        if lower.contains("healthy") || lower.contains("aman") { return .green }
        if lower.contains("dini") || lower.contains("warning") { return .yellow }
        if lower.contains("aktif") || lower.contains("active") { return .orange }
        return .red
    }
}

// MARK: - Reusable Info Block
private struct InfoBlock: View {
    let title: String
    let icon: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.headline)
            Text(content)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}
