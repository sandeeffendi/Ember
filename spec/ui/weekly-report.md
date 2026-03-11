
## Weekly Report Flow

User opens homepage.

Homepage displays Weekly Report Card.

The card contains:

- week preview calendar
- quick summary of activity

User taps Weekly Report Card.

Application navigates to Weekly Report Screen.

The screen displays detailed weekly insight and trends.
4. UI Specification

Tambahkan file baru:

spec/ui/weekly-report.md
Weekly Report Card (Homepage)
Component

WeeklyReportCard

Description

A card displayed on the homepage showing a preview of the user's weekly activity.

Content

Week label
Mini calendar preview (7 days)
Completion indicators
Quick insight summary

Interaction

Tap → Navigate to Weekly Report Screen
Calendar Preview
Component

WeekCalendarPreview

Layout

7 columns representing days of the week.

Each day displays:

date number
completion indicator

States

completed
missed
today
Weekly Report Screen
Component

WeeklyReportView

Sections

Week summary
Daily check-in overview
Mood trend
Suggestions