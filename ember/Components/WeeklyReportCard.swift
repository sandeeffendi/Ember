//
//  WeeklyReportCard.swift
//  ember
//
//  Advanced homepage card showing weekly activity preview with mood indicators
//

import SwiftUI

struct WeeklyReportCard<Destination: View>: View {
    let weekLabel: String
    let completionRate: Double
    let weekDays: [WeekDay]
    let averageMood: Double
    let averageEnergy: Double
    let averageStress: Double
    let destination: () -> Destination
    
    @State private var showDaySheet: Bool = false
    @State private var selectedDay: WeekDay?
    @State private var animatedProgress: Double = 0
    
    init(
        weekLabel: String = DateUtils.weekLabel(),
        completionRate: Double = 0,
        weekDays: [WeekDay] = [],
        averageMood: Double = 0,
        averageEnergy: Double = 0,
        averageStress: Double = 0,
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        self.weekLabel = weekLabel
        self.completionRate = completionRate
        self.weekDays = weekDays
        self.averageMood = averageMood
        self.averageEnergy = averageEnergy
        self.averageStress = averageStress
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink(destination: destination()) {
            VStack(alignment: .leading, spacing: Spacing.md) {
                headerSection
                
                calendarSection
                
                progressSection
                
                quickStatsSection
            }
            .padding(Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: CornerRadius.extraLarge)
                    .fill(Color.AppColors.cardBackground)
                    .shadow(color: AppShadow.medium.color, radius: AppShadow.medium.radius, x: AppShadow.medium.x, y: AppShadow.medium.y)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showDaySheet) {
            if let day = selectedDay {
                DayDetailSheet(day: day)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.3)) {
                animatedProgress = completionRate
            }
        }
        .onChange(of: completionRate) { _, newValue in
            withAnimation(.easeOut(duration: 0.3)) {
                animatedProgress = newValue
            }
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text("Weekly Report")
                    .font(.headline)
                    .foregroundColor(Color.AppColors.textPrimary)
                
                Text(weekLabel)
                    .font(.caption)
                    .foregroundColor(Color.AppColors.textSecondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.subheadline)
                .foregroundColor(Color.AppColors.textTertiary)
        }
    }
    
    // MARK: - Calendar Section
    private var calendarSection: some View {
        EnhancedWeekCalendar(
            days: weekDays,
            onDayTap: { day in
                selectedDay = day
                showDaySheet = true
            }
        )
    }
    
    // MARK: - Progress Section
    private var progressSection: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            HStack {
                Text("\(Int(animatedProgress * 7)) of 7 days")
                    .font(.caption)
                    .foregroundColor(Color.AppColors.textSecondary)
                
                Spacer()
                
                Text("\(Int(animatedProgress * 100))%")
                    .font(.caption.bold())
                    .foregroundColor(Color.AppColors.secondary)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.15))
                        .frame(height: 6)
                    
                    RoundedRectangle(cornerRadius: 3)
                        .fill(LinearGradient.AppGradients.secondary)
                        .frame(width: geometry.size.width * animatedProgress, height: 6)
                }
            }
            .frame(height: 6)
        }
    }
    
    // MARK: - Quick Stats Section
    private var quickStatsSection: some View {
        HStack(spacing: Spacing.md) {
            QuickStatBadge(
                label: "Mood",
                value: averageMood,
                icon: "face.smiling",
                color: moodColor
            )
            
            QuickStatBadge(
                label: "Energy",
                value: averageEnergy,
                icon: "bolt.fill",
                color: Color.AppColors.warning
            )
            
            QuickStatBadge(
                label: "Stress",
                value: averageStress,
                icon: "brain.head.profile",
                color: Color.AppColors.error
            )
        }
    }
    
    private var moodColor: Color {
        switch averageMood {
        case 4...5: return Color.AppColors.secondary
        case 3: return Color.AppColors.warning
        case 1...2: return Color.AppColors.error
        default: return Color.AppColors.textTertiary
        }
    }
}

// MARK: - Enhanced Week Calendar
struct EnhancedWeekCalendar: View {
    let days: [WeekDay]
    let onDayTap: (WeekDay) -> Void
    
    var body: some View {
        HStack(spacing: Spacing.xs) {
            ForEach(days) { day in
                DayCell(
                    day: day,
                    onTap: { onDayTap(day) }
                )
            }
        }
    }
}

// MARK: - Day Cell
struct DayCell: View {
    let day: WeekDay
    let onTap: () -> Void
    
    @State private var isPressed: Bool = false
    
    private var backgroundColor: Color {
        if day.isFuture {
            return Color.clear
        }
        
        if day.hasCheckIn {
            switch day.moodStatus {
            case .high:
                return Color.AppColors.secondary.opacity(0.15)
            case .medium:
                return Color.AppColors.warning.opacity(0.15)
            case .low:
                return Color.AppColors.error.opacity(0.15)
            case .noData:
                return Color.gray.opacity(0.1)
            }
        }
        
        return Color.gray.opacity(0.08)
    }
    
    private var iconColor: Color {
        if day.isFuture {
            return Color.AppColors.textTertiary.opacity(0.3)
        }
        
        if day.hasCheckIn {
            switch day.moodStatus {
            case .high: return Color.AppColors.secondary
            case .medium: return Color.AppColors.warning
            case .low: return Color.AppColors.error
            case .noData: return Color.AppColors.textSecondary
            }
        }
        
        return Color.AppColors.textTertiary
    }
    
    private var iconName: String {
        if day.isFuture {
            return "ellipsis"
        }
        
        if day.hasCheckIn {
            return "checkmark"
        }
        
        return "minus"
    }
    
    private var borderColor: Color {
        day.isToday ? Color.AppColors.primary : Color.clear
    }
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Text("\(day.dayNumber)")
                    .font(.caption2)
                    .foregroundColor(day.isFuture ? Color.AppColors.textTertiary.opacity(0.5) : Color.AppColors.textSecondary)
                
                ZStack {
                    Circle()
                        .fill(backgroundColor)
                        .frame(width: 32, height: 32)
                    
                    if day.isFuture {
                        Circle()
                            .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [3]))
                            .foregroundColor(Color.AppColors.textTertiary.opacity(0.3))
                            .frame(width: 32, height: 32)
                    }
                    
                    Image(systemName: iconName)
                        .font(.caption.bold())
                        .foregroundColor(iconColor)
                }
                .overlay(
                    Circle()
                        .stroke(borderColor, lineWidth: day.isToday ? 2 : 0)
                )
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isPressed ? 0.9 : 1.0)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = false
                    }
                }
        )
    }
}

// MARK: - Quick Stat Badge
struct QuickStatBadge: View {
    let label: String
    let value: Double
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption2)
                .foregroundColor(color)
            
            Text(String(format: "%.1f", value))
                .font(.caption.bold())
                .foregroundColor(Color.AppColors.textPrimary)
            
            Text("/5")
                .font(.caption2)
                .foregroundColor(Color.AppColors.textTertiary)
        }
        .padding(.horizontal, Spacing.sm)
        .padding(.vertical, Spacing.xs)
        .background(
            RoundedRectangle(cornerRadius: CornerRadius.small)
                .fill(color.opacity(0.1))
        )
    }
}
