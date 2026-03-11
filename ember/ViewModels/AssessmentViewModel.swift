//
//  AssessmentViewModel.swift
//  ember
//
//  Created by Sande Effendi on 11/03/26.
//

    // ViewModels/AssessmentViewModel.swift
    import Foundation
    import SwiftUI
    internal import Combine

    // State halaman yang sedang aktif
    enum AppScreen {
        case welcome
        case assessment
        case loading
        case result(BurnoutResult)
        case error(String)
    }

    @MainActor
    final class AssessmentViewModel: ObservableObject {
        // MARK: - Published State
        @Published var currentScreen: AppScreen = .welcome
        @Published var currentQuestionIndex: Int = 0
        @Published var answers: [Int: Int] = [:] // [questionId: score]

        // MARK: - Dependencies
        private let geminiService = GeminiService()
        let questions = Question.all

        // MARK: - Computed
        var currentQuestion: Question? {
            guard currentQuestionIndex < questions.count else { return nil }
            return questions[currentQuestionIndex]
        }

        var progress: Double {
            guard !questions.isEmpty else { return 0 }
            return Double(currentQuestionIndex) / Double(questions.count)
        }

        var isLastQuestion: Bool {
            currentQuestionIndex == questions.count - 1
        }

        // MARK: - Actions

        func startAssessment() {
            answers = [:]
            currentQuestionIndex = 0
            currentScreen = .assessment
        }

        // User memilih jawaban untuk pertanyaan saat ini
        func selectAnswer(score: Int) {
            guard let question = currentQuestion else { return }
            answers[question.id] = score

            if isLastQuestion {
                Task { await submitAssessment() }
            } else {
                withAnimation(.spring(duration: 0.3)) {
                    currentQuestionIndex += 1
                }
            }
        }

        func restart() {
            withAnimation {
                currentScreen = .welcome
            }
        }

        // MARK: - Private

        private func submitAssessment() async {
            withAnimation { currentScreen = .loading }

            do {
                let result = try await geminiService.analyze(answers: answers)
                withAnimation { currentScreen = .result(result) }
            } catch {
                withAnimation {
                    currentScreen = .error(
                        error.localizedDescription
                    )
                }
            }
        }
    }
