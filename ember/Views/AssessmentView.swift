//
//  AssessmentView.swift
//  ember
//
//  Assessment questionnaire screen
//

import SwiftUI

struct AssessmentView: View {
    @EnvironmentObject var viewModel: AssessmentViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ProgressIndicator(
                    current: viewModel.currentQuestionIndex + 1,
                    total: viewModel.questions.count
                )
                .padding(.horizontal, Spacing.md)
                .padding(.top, Spacing.md)

                Spacer()

                if let question = viewModel.currentQuestion {
                    VStack(spacing: Spacing.lg) {
                        Text(question.text)
                            .font(Font.AppTypography.title3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, Spacing.lg)
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))

                        VStack(spacing: Spacing.sm) {
                            ForEach(question.options) { option in
                                let isSelected = viewModel.answers[question.id] == option.score
                                SelectableCard(
                                    text: option.text,
                                    isSelected: isSelected
                                ) {
                                    withAnimation(.spring(duration: 0.3)) {
                                        viewModel.selectAnswer(score: option.score)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, Spacing.md)
                    }
                }

                Spacer()
            }
            .background(Color.AppColors.background.ignoresSafeArea())
            .navigationTitle("Asesmen Burnout")
            .navigationBarTitleDisplayMode(.inline)
        }
        .animation(.spring(duration: 0.4), value: viewModel.currentQuestionIndex)
    }
}
