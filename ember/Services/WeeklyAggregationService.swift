//
//  WeeklyAggregationService.swift
//  ember
//
//  Service for computing weekly metrics and insights
//

import Foundation

final class WeeklyAggregationService {
    static let shared = WeeklyAggregationService()
    
    private init() {}
    
    func computeAverageMood(from checkIns: [DailyCheckIn]) -> Double {
        guard !checkIns.isEmpty else { return 0 }
        let total = checkIns.map { Double($0.moodLevel) }.reduce(0, +)
        return total / Double(checkIns.count)
    }
    
    func computeAverageEnergy(from checkIns: [DailyCheckIn]) -> Double {
        guard !checkIns.isEmpty else { return 0 }
        let total = checkIns.map { Double($0.energyLevel) }.reduce(0, +)
        return total / Double(checkIns.count)
    }
    
    func computeAverageStress(from checkIns: [DailyCheckIn]) -> Double {
        guard !checkIns.isEmpty else { return 0 }
        let total = checkIns.map { Double($0.stressLevel) }.reduce(0, +)
        return total / Double(checkIns.count)
    }
    
    func computeCompletionRate(from checkIns: [DailyCheckIn], totalDays: Int = 7) -> Double {
        guard totalDays > 0 else { return 0 }
        let uniqueDays = Set(checkIns.map { DateUtils.startOfDay(for: $0.date) })
        return Double(uniqueDays.count) / Double(totalDays)
    }
    
    func buildWeekDays(from checkIns: [DailyCheckIn]) -> [WeekDay] {
        let dates = DateUtils.daysInWeek()
        let checkedDates = Set(checkIns.map { DateUtils.startOfDay(for: $0.date) })
        
        return dates.map { date in
            WeekDay(
                date: date,
                label: DateUtils.shortDayLabel(for: date),
                hasCheckIn: checkedDates.contains(DateUtils.startOfDay(for: date)),
                dayNumber: DateUtils.dayNumber(for: date)
            )
        }
    }
    
    func generateInsights(from checkIns: [DailyCheckIn]) -> [WeeklyInsight] {
        var insights: [WeeklyInsight] = []
        
        let avgMood = computeAverageMood(from: checkIns)
        let avgEnergy = computeAverageEnergy(from: checkIns)
        let avgStress = computeAverageStress(from: checkIns)
        let completionRate = computeCompletionRate(from: checkIns)
        
        if completionRate >= 0.7 {
            insights.append(WeeklyInsight(
                type: .completion,
                title: "Great Consistency!",
                description: "You've completed check-ins \(Int(completionRate * 100))% of this week. Keep up the good work!",
                priority: .high
            ))
        } else if completionRate > 0 {
            insights.append(WeeklyInsight(
                type: .completion,
                title: "Keep Going",
                description: "You've completed \(Int(completionRate * 100))% of your check-ins. Try to be more consistent!",
                priority: .medium
            ))
        }
        
        if avgMood >= 4 {
            insights.append(WeeklyInsight(
                type: .mood,
                title: "Positive Mood",
                description: "Your average mood is great this week!",
                priority: .low
            ))
        } else if avgMood <= 2 {
            insights.append(WeeklyInsight(
                type: .mood,
                title: "Mood Alert",
                description: "Your mood has been low this week. Consider taking breaks and practicing self-care.",
                priority: .high
            ))
        }
        
        if avgStress >= 4 {
            insights.append(WeeklyInsight(
                type: .stress,
                title: "High Stress Detected",
                description: "Your stress levels are high. Try mindfulness or relaxation techniques.",
                priority: .high
            ))
        }
        
        if avgEnergy <= 2 {
            insights.append(WeeklyInsight(
                type: .energy,
                title: "Low Energy",
                description: "Your energy levels are low. Make sure you're getting enough rest.",
                priority: .medium
            ))
        }
        
        return insights.sorted { $0.priority.rawValue > $1.priority.rawValue }
    }
    
    func createWeeklyReport(from checkIns: [DailyCheckIn]) -> WeeklyReport {
        let weekStart = DateUtils.startOfWeek()
        let weekEnd = DateUtils.endOfWeek()
        
        let thisWeekCheckIns = checkIns.filter {
            let date = DateUtils.startOfDay(for: $0.date)
            return date >= DateUtils.startOfDay(for: weekStart) && 
                   date <= DateUtils.startOfDay(for: weekEnd)
        }
        
        return WeeklyReport(
            weekStartDate: weekStart,
            weekEndDate: weekEnd,
            dailyCheckIns: thisWeekCheckIns,
            averageMood: computeAverageMood(from: thisWeekCheckIns),
            averageEnergy: computeAverageEnergy(from: thisWeekCheckIns),
            averageStress: computeAverageStress(from: thisWeekCheckIns),
            completionRate: computeCompletionRate(from: thisWeekCheckIns)
        )
    }
}
