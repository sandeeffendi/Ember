//
//  AssessmentViewModel.swift
//  ember
//

import Foundation
import SwiftUI

// State for the assessment onboarding flow screens
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
    @Published var answers: [Int: Int] = [:]

    // MARK: - Dependencies
    private let geminiService = GeminiService()
    private weak var appViewModel: AppViewModel?
    let questions = Question.all

    // MARK: - Init
    init(appViewModel: AppViewModel) {
        self.appViewModel = appViewModel
    }

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
            // Persist result and transition root navigation to the main app
            appViewModel?.completeAssessment(with: result)
        } catch {
            withAnimation {
                currentScreen = .error(error.localizedDescription)
            }
        }
    }
}
