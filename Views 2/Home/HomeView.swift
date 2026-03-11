//
//  HomeView.swift
//  ember
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    // MARK: - Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.greeting)
                            .font(.title2)
                            .fontWeight(.semibold)

                        Text("How are you feeling today?")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 8)

                    // MARK: - Activity Cards
                    VStack(spacing: 14) {
                        CardView(
                            title: "Daily Check-In",
                            subtitle: "Record your mood, energy & stress",
                            icon: "checkmark.circle.fill",
                            color: .teal
                        ) {
                            CheckInView()
                        }

                        CardView(
                            title: "Weekly Report",
                            subtitle: "View your wellbeing trends",
                            icon: "chart.bar.fill",
                            color: .indigo
                        ) {
                            WeeklyReportView()
                        }
                    }
                    .padding(.horizontal)

                    Spacer(minLength: 40)
                }
                .padding(.top, 8)
            }
            .navigationTitle("Ember")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.tint)
                    }
                }
            }
        }
    }
}
