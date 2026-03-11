//
//  AssessmentView.swift
//  ember
//
//  Created by Sande Effendi on 11/03/26.
//

    // Views/AssessmentView.swift
    import SwiftUI

    struct AssessmentView: View {
        @EnvironmentObject var viewModel: AssessmentViewModel

        var body: some View {
            NavigationStack {
                VStack(spacing: 0) {
                    // Progress Bar
                    ProgressView(value: viewModel.progress)
                        .tint(.accentColor)
                        .padding(.horizontal)
                        .padding(.top)

                    Text("Pertanyaan \(viewModel.currentQuestionIndex + 1) dari \(viewModel.questions.count)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.top, 8)

                    Spacer()

                    // Pertanyaan
                    if let question = viewModel.currentQuestion {
                        VStack(spacing: 28) {
                            Text(question.text)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 24)
                                .transition(.slide)

                            // Pilihan Jawaban
                            VStack(spacing: 12) {
                                ForEach(question.options) { option in
                                    AnswerButton(option: option) {
                                        viewModel.selectAnswer(score: option.score)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    Spacer()
                }
                .navigationTitle("Asesmen Burnout")
                .navigationBarTitleDisplayMode(.inline)
            }
            .animation(.spring(duration: 0.4), value: viewModel.currentQuestionIndex)
        }
    }

    struct AnswerButton: View {
        let option: AnswerOption
        let action: () -> Void

        var body: some View {
            Button(action: action) {
                HStack {
                    Text(option.text)
                        .font(.body)
                        .foregroundStyle(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
            }
            .buttonStyle(.plain)
        }
    }
