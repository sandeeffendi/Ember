//
//  WeeklyReportViewModel.swift
//  ember
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class WeeklyReportViewModel: ObservableObject {

    @Published var weekDays: [WeekDay] = []
    @Published var averageMood: Double = 0
    @Published var averageEnergy: Double = 0
    @Published var averageStress: Double = 0

    private let persistence = PersistenceService.shared

    init() {
        load()
    }

    func load() {
        let checkIns = persistence.loadCheckIns()
        weekDays = buildWeek(from: checkIns)
        computeAverages(from: checkIns)
    }

    // MARK: - Private

    private func buildWeek(from checkIns: [DailyCheckIn]) -> [WeekDay] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        let weekday = calendar.component(.weekday, from: today)
        let daysFromMonday = (weekday + 5) % 7
        guard let monday = calendar.date(byAdding: .day, value: -daysFromMonday, to: today) else {
            return []
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"

        let checkedDates = Set(checkIns.map { $0.calendarDate })

        return (0..<7).compactMap { offset in
            guard let day = calendar.date(byAdding: .day, value: offset, to: monday) else { return nil }
            return WeekDay(
                date: day,
                label: formatter.string(from: day),
                hasCheckIn: checkedDates.contains(day),
                dayNumber: calendar.component(.day, from: day)
            )
        }
    }

    private func computeAverages(from checkIns: [DailyCheckIn]) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let daysFromMonday = (calendar.component(.weekday, from: today) + 5) % 7
        guard let monday = calendar.date(byAdding: .day, value: -daysFromMonday, to: today),
              let sunday = calendar.date(byAdding: .day, value: 6, to: monday) else { return }

        let thisWeek = checkIns.filter { $0.calendarDate >= monday && $0.calendarDate <= sunday }
        guard !thisWeek.isEmpty else { return }

        let count = Double(thisWeek.count)
        averageMood = thisWeek.map { Double($0.moodLevel) }.reduce(0, +) / count
        averageEnergy = thisWeek.map { Double($0.energyLevel) }.reduce(0, +) / count
        averageStress = thisWeek.map { Double($0.stressLevel) }.reduce(0, +) / count
    }
}
