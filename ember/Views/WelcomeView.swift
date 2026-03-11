//
//  WelcomeView.swift
//  ember
//
//  Created by Sande Effendi on 11/03/26.
//

    // Views/WelcomeView.swift
    import SwiftUI

    struct WelcomeView: View {
        @EnvironmentObject var viewModel: AssessmentViewModel

        var body: some View {
            NavigationStack {
                VStack(spacing: 32) {
                    Spacer()

                    // Icon & Title
                    VStack(spacing: 16) {
                        Image(systemName: "heart.text.clipboard.fill")
                            .font(.system(size: 72))
                            .foregroundStyle(.tint)

                        Text("Burnout Check")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Kenali kondisi mentalmu lebih baik melalui asesmen singkat berbasis AI")
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }

                    // Info Cards
                    VStack(spacing: 12) {
                        InfoRow(icon: "list.number",
                                text: "8 pertanyaan singkat")
                        InfoRow(icon: "clock",
                                text: "Selesai dalam 2–3 menit")
                        InfoRow(icon: "brain.head.profile",
                                text: "Dianalisis oleh AI berdasarkan metode MBI")
                    }
                    .padding()
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)

                    Spacer()

                    // CTA Button
                    Button(action: viewModel.startAssessment) {
                        Text("Mulai Asesmen")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.tint, in: RoundedRectangle(cornerRadius: 14))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                }
            }
        }
    }

    struct InfoRow: View {
        let icon: String
        let text: String

        var body: some View {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundStyle(.tint)
                    .frame(width: 24)
                Text(text)
                    .font(.subheadline)
                Spacer()
            }
        }
    }
