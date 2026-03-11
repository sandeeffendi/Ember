//
//  ResultView.swift
//  ember
//
//  Created by Sande Effendi on 11/03/26.
//

    // Views/ResultView.swift
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
                    VStack(spacing: 24) {
                        // Phase Badge
                        VStack(spacing: 12) {
                            Image(systemName: phase.icon)
                                .font(.system(size: 56))
                                .foregroundStyle(phase.color)

                            Text(result.phaseLabel)
                                .font(.title2)
                                .fontWeight(.bold)

                            Text("Skor Total: \(result.scores.total)/32")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top, 32)

                        // Skor Dimensi
                        HStack(spacing: 16) {
                            ScoreCard(label: "Emosional", dimension: "EE",
                                      score: result.scores.ee, max: 12)
                            ScoreCard(label: "Fisik", dimension: "PE",
                                      score: result.scores.pe, max: 8)
                            ScoreCard(label: "Depersonalisasi", dimension: "DP",
                                      score: result.scores.dp, max: 12)
                        }
                        .padding(.horizontal)

                        // Narasi
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Analisis", systemImage: "text.quote")
                                .font(.headline)
                            Text(result.narrative)
                                .font(.body)
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal)

                        // Rekomendasi
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Rekomendasi", systemImage: "lightbulb.fill")
                                .font(.headline)
                            Text(result.recommendations)
                                .font(.body)
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal)

                        // Tombol Ulangi
                        Button(action: viewModel.restart) {
                            Text("Ulangi Asesmen")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.regularMaterial,
                                            in: RoundedRectangle(cornerRadius: 14))
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 32)
                    }
                }
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
            VStack(spacing: 6) {
                Text(dimension)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("\(score)")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("dari \(max)")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                Text(label)
                    .font(.caption2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
        }
    }
