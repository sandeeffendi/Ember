//
//  CheckInView.swift
//  ember
//

import SwiftUI

struct CheckInView: View {
    @StateObject private var viewModel = CheckInViewModel()

    var body: some View {
        Group {
            if viewModel.isSubmitted {
                submittedView
            } else {
                formView
            }
        }
        .navigationTitle("Daily Check-In")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Form View
    private var formView: some View {
        ScrollView {
            VStack(spacing: 28) {

                // Phase indicator
                VStack(spacing: 8) {
                    Image(systemName: viewModel.currentPhase.icon)
                        .font(.system(size: 44))
                        .foregroundStyle(.tint)
                    Text(viewModel.currentPhase.label + " Check")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("Takes less than 10 seconds")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 8)

                // Sliders
                VStack(spacing: 20) {
                    SliderRow(
                        label: "Mood",
                        icon: "face.smiling",
                        value: $viewModel.moodLevel,
                        color: .orange
                    )
                    SliderRow(
                        label: "Energy",
                        icon: "bolt.fill",
                        value: $viewModel.energyLevel,
                        color: .yellow
                    )
                    SliderRow(
                        label: "Stress",
                        icon: "brain.head.profile",
                        value: $viewModel.stressLevel,
                        color: .red
                    )
                }
                .padding()
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)

                // Submit
                Button(action: viewModel.submit) {
                    Text("Submit Check-In")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.tint, in: RoundedRectangle(cornerRadius: 14))
                        .foregroundStyle(.white)
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
        }
    }

    // MARK: - Success View
    private var submittedView: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 64))
                .foregroundStyle(.teal)
            Text("Check-In Complete!")
                .font(.title2)
                .fontWeight(.bold)
            Text("Your wellbeing has been recorded.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Slider Row Component
private struct SliderRow: View {
    let label: String
    let icon: String
    @Binding var value: Double
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label(label, systemImage: icon)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(color)
                Spacer()
                Text("\(Int(value)) / 5")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Slider(value: $value, in: 1...5, step: 1)
                .tint(color)
        }
    }
}
