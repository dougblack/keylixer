## Goals

1. Quickly update counts for the following granularities:
    - Last 24 hours.
        - One increment of "hot data".
    - Last one week.
        - One increment of "colder data".
    - Last one month.
        - One increment of "colder data".
    - Last one year.
        - One increment of "colder data".


Datastructure

YearDict = (Year : MonthDict)
MonthDict = (Month: WeekDict)
WeekDict = (Week: DayDict)
DayDict = (Day: Count)

New keystroke -> Update ephemeral day count.
    - If app ever quits, save day count.
    - (?) Find out how to get notified when a new day arrives (store this in UTC).
    - When days roll over, update day/week/year count.

Alternative:
DayDict = (Day: HourDict)
HourDict = (Hour: Count)

Where Day is UTC start of day.
Where Hour is UTC start of hour.

- Report keystrokes per hour.
    - Report Count value in HourDict.
- Report keystrokes per day.
    - Sum last HourDict.
- Report keystrokes per week.
    - Sum last 7 HourDicts.
- Report keystrokes per month.
    - Sum last 30 HourDicts.
- Report keystrokes per year.
    - Sum last 365 HourDicts.
