//
//  HomeViewModel.swift
//  ember
//
//  ViewModel for the home screen
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var userName: String = ""
    @Published var weekDays: [WeekDay] = []
    @Published var completionRate: Double = 0
    @Published var averageMood: Double = 0
    @Published var averageEnergy: Double = 0
    @Published var averageStress: Double = 0
    @Published var isLoading: Bool = false
    
    // Daily Check-In data
    @Published var currentPhase: CheckInPhase = .morning
    @Published var currentStreak: Int = 0
    @Published var phaseStatus: [CheckInPhase: DailyCheckIn?] = [:]
    
    private let persistence = PersistenceService.shared
    private let aggregationService = WeeklyAggregationService.shared

    init() {
        loadData()
    }

    /// Time-sensitive greeting for the home screen.
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12:  return "Good Morning"
        case 12..<17: return "Good Afternoon"
        default:      return "Good Evening"
        }
    }
    
    var weekLabel: String {
        DateUtils.weekLabel()
    }
    
    var phaseGreeting: String {
        switch currentPhase {
        case .morning: return "Start your day right"
        case .midday: return "How's your day going?"
        case .shutdown: return "Wind down with a check-in"
        }
    }
    
    func loadData() {
        isLoading = true
        
        loadUser()
        loadDailyCheckInData()
        loadWeeklyData()
        
        isLoading = false
    }
    
    func refresh() {
        loadData()
    }

    private func loadUser() {
        userName = persistence.loadUser()?.name ?? ""
    }
    
    private func loadDailyCheckInData() {
        currentPhase = CheckInPhase.current
        
        // Get phase status for all phases
        phaseStatus = persistence.getTodayPhaseStatus()
        
        // Calculate streak
        let checkIns = persistence.loadCheckIns()
        currentStreak = calculateStreak(from: checkIns)
    }
    
    private func calculateStreak(from checkIns: [DailyCheckIn]) -> Int {
        guard !checkIns.isEmpty else { return 0 }
        
        let sortedCheckIns = checkIns.sorted { $0.date > $1.date }
        let calendar = Calendar.current
        
        var streak = 0
        var currentDate = DateUtils.startOfDay(for: Date())
        
        let uniqueDates = Set(sortedCheckIns.map { DateUtils.startOfDay(for: $0.date) })
            .sorted(by: >)
        
        for date in uniqueDates {
            if date == currentDate {
                streak += 1
                currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
            } else if date < currentDate {
                break
            }
        }
        
        return streak
    }
    
    private func loadWeeklyData() {
        let checkIns = persistence.loadCheckIns()
        
        weekDays = aggregationService.buildWeekDays(from: checkIns)
        
        let thisWeekCheckIns = checkIns.filter { checkIn in
            let checkInDate = DateUtils.startOfDay(for: checkIn.date)
            let weekStart = DateUtils.startOfDay(for: DateUtils.startOfWeek())
            let weekEnd = DateUtils.startOfDay(for: DateUtils.endOfWeek())
            return checkInDate >= weekStart && checkInDate <= weekEnd
        }
        
        completionRate = aggregationService.computeCompletionRate(from: thisWeekCheckIns)
        averageMood = aggregationService.computeAverageMood(from: thisWeekCheckIns)
        averageEnergy = aggregationService.computeAverageEnergy(from: thisWeekCheckIns)
        averageStress = aggregationService.computeAverageStress(from: thisWeekCheckIns)
        
        weekDays = enrichWeekDaysWithCheckInData(weekDays, checkIns: thisWeekCheckIns)
    }
    
    private func enrichWeekDaysWithCheckInData(_ days: [WeekDay], checkIns: [DailyCheckIn]) -> [WeekDay] {
        let calendar = Calendar.current
        
        return days.map { day in
            var updatedDay = day
            
            if let checkIn = checkIns.first(where: { calendar.isDate($0.date, inSameDayAs: day.date) }) {
                updatedDay.moodLevel = checkIn.moodLevel
                updatedDay.energyLevel = checkIn.energyLevel
                updatedDay.stressLevel = checkIn.stressLevel
            }
            
            return updatedDay
        }
    }
}
