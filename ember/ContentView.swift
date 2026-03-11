//
//  ContentView.swift
//  ember
//
//  Created by Sande Effendi on 11/03/26.
//
// ContentView.swift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AssessmentViewModel

    var body: some View {
        switch viewModel.currentScreen {
        case .welcome:
            WelcomeView()
        case .assessment:
            AssessmentView()
        case .loading:
            LoadingView()
        case .result(let result):
            ResultView(result: result)
        case .error(let message):
            ErrorView(message: message)
        }
    }
}
