//
//  WeeklyReport.swift
//  ember
//
//  Domain models for weekly report feature
//

import Foundation

struct WeeklyReport: Identifiable {
    let id: UUID
    let weekStartDate: Date
    let weekEndDate: Date
    var dailyCheckIns: [DailyCheckIn]
    var averageMood: Double
    var averageEnergy: Double
    var averageStress: Double
    var completionRate: Double
    
    init(
        id: UUID = UUID(),
        weekStartDate: Date,
        weekEndDate: Date,
        dailyCheckIns: [DailyCheckIn] = [],
        averageMood: Double = 0,
        averageEnergy: Double = 0,
        averageStress: Double = 0,
        completionRate: Double = 0
    ) {
        self.id = id
        self.weekStartDate = weekStartDate
        self.weekEndDate = weekEndDate
        self.dailyCheckIns = dailyCheckIns
        self.averageMood = averageMood
        self.averageEnergy = averageEnergy
        self.averageStress = averageStress
        self.completionRate = completionRate
    }
}

struct WeeklyInsight: Identifiable {
    let id = UUID()
    let type: InsightType
    let title: String
    let description: String
    let priority: InsightPriority
    
    enum InsightType: String {
        case mood
        case energy
        case stress
        case completion
        case trend
    }
    
    enum InsightPriority: Int {
        case low = 0
        case medium = 1
        case high = 2
    }
}
