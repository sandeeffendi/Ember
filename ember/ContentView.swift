//
//  ContentView.swift
//  ember
//
//  Created by Sande Effendi on 11/03/26.
//
// ContentView.swift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        Group {
            if appViewModel.hasCompletedAssessment {
                HomeView()
            } else {
                AssessmentFlowView(appViewModel: appViewModel)
            }
        }
        .animation(.easeInOut, value: appViewModel.hasCompletedAssessment)
    }
}

// MARK: - Assessment Flow View
struct AssessmentFlowView: View {
    @StateObject private var viewModel: AssessmentViewModel

    init(appViewModel: AppViewModel) {
        _viewModel = StateObject(wrappedValue: AssessmentViewModel(appViewModel: appViewModel))
    }

    var body: some View {
        switch viewModel.currentScreen {
        case .welcome:
            WelcomeView()
                .environmentObject(viewModel)
        case .assessment:
            AssessmentView()
                .environmentObject(viewModel)
        case .loading:
            LoadingView()
                .environmentObject(viewModel)
        case .result(let result):
            ResultView(result: result)
                .environmentObject(viewModel)
        case .error(let message):
            ErrorView(message: message)
                .environmentObject(viewModel)
        }
    }
}
