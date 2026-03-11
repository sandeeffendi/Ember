Week Calculation
Weeks start on Monday.

weekStartDate = startOfWeek(currentDate)

weekEndDate = weekStartDate + 6 days
Daily Check-In Logic
A user may submit one daily check-in per day.

Check-in date is stored using ISO date format.

If a check-in exists for today:

show completed state in calendar preview.

If not:

show empty state.
Weekly Report Aggregation
Weekly report aggregates all daily check-ins within:

weekStartDate ≤ date ≤ weekEndDate