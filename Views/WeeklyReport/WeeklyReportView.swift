//
//  WeeklyReportView.swift
//  ember
//

import SwiftUI

struct WeeklyReportView: View {
    @StateObject private var viewModel = WeeklyReportViewModel()

    private var todayStart: Date {
        Calendar.current.startOfDay(for: Date())
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // MARK: - Calendar Row
                VStack(alignment: .leading, spacing: 12) {
                    Text("This Week")
                        .font(.headline)
                        .padding(.horizontal)

                    HStack(spacing: 0) {
                        ForEach(viewModel.weekDays) { day in
                            CalendarDayView(
                                day: day,
                                isToday: day.date == todayStart
                            )
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                }

                // MARK: - Weekly Insight
                VStack(alignment: .leading, spacing: 16) {
                    Text("Weekly Insight")
                        .font(.headline)
                        .padding(.horizontal)

                    if viewModel.weekDays.filter(\.hasCheckIn).isEmpty {
                        VStack(spacing: 8) {
                            Image(systemName: "chart.bar.doc.horizontal")
                                .font(.system(size: 36))
                                .foregroundStyle(.secondary)
                            Text("No check-ins yet this week.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(32)
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)
                    } else {
                        VStack(spacing: 14) {
                            InsightRow(label: "Avg Mood",
                                       value: viewModel.averageMood,
                                       icon: "face.smiling", color: .orange)
                            Divider()
                            InsightRow(label: "Avg Energy",
                                       value: viewModel.averageEnergy,
                                       icon: "bolt.fill", color: .yellow)
                            Divider()
                            InsightRow(label: "Avg Stress",
                                       value: viewModel.averageStress,
                                       icon: "brain.head.profile", color: .red)
                        }
                        .padding()
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)
                    }
                }

                Spacer(minLength: 32)
            }
            .padding(.top, 16)
        }
        .navigationTitle("Weekly Report")
        .navigationBarTitleDisplayMode(.large)
        .onAppear { viewModel.load() }
    }
}

// MARK: - Insight Row
private struct InsightRow: View {
    let label: String
    let value: Double
    let icon: String
    let color: Color

    var body: some View {
        HStack {
            Label(label, systemImage: icon)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(color)
            Spacer()
            // 5-dot indicator
            HStack(spacing: 4) {
                ForEach(1...5, id: \.self) { dot in
                    Circle()
                        .fill(dot <= Int(value.rounded()) ? color : color.opacity(0.2))
                        .frame(width: 10, height: 10)
                }
            }
            Text(String(format: "%.1f", value))
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(width: 28, alignment: .trailing)
        }
    }
}
