# Task 11 — Weekly Report Domain Model

Objective

Define the data models required for weekly reports.

Models

WeeklyReport
DailyCheckIn

Fields

WeeklyReport

id
weekStartDate
weekEndDate
dailyCheckIns
averageMood
completionRate

DailyCheckIn

id
date
moodScore
energyLevel
stressLevel
note

Rules

Dates must use Date type.

DailyCheckIn must be uniquely identified by date.