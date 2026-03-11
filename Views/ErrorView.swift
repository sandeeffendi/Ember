//
//  ErrorView.swift
//  ember
//
//  Created by Sande Effendi on 11/03/26.
//

    // Views/ErrorView.swift
    import SwiftUI

    struct ErrorView: View {
        @EnvironmentObject var viewModel: AssessmentViewModel
        let message: String

        var body: some View {
            VStack(spacing: 24) {
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 56))
                    .foregroundStyle(.red)

                VStack(spacing: 8) {
                    Text("Terjadi Kesalahan")
                        .font(.headline)
                    Text(message)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }

                Button(action: viewModel.restart) {
                    Text("Coba Lagi")
                        .font(.headline)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 12)
                        .background(.tint, in: Capsule())
                        .foregroundStyle(.white)
                }
            }
        }
    }
