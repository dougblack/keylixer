//
//  Statistician.swift
//  keylixer
//
//  Created by Doug Black on 2/10/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Foundation

class Statistician {

    let counter : Counter

    init(counter: Counter) {
        self.counter = counter
    }

    func stats() -> [String: Int] {

        var stats = [
            "week": 0,
            "yesterday": 0,
            "today": 0,
            "total": 0
        ]
        let calendar = NSCalendar.currentCalendar()
        let today = calendar.components([.Year, .Month, .WeekOfMonth, .Day], fromDate: NSDate())
        let yesterdayDate = calendar.dateByAddingUnit(.Day, value: -1, toDate: NSDate(), options: [])!
        let yesterday = calendar.components([.Year, .Month, .WeekOfMonth, .Day], fromDate: yesterdayDate)

        for hour in self.counter.hours {
            let hourDate = hour.date()
            stats["total"]! += hour.count
            if hourDate.year == today.year {
                if hourDate.month == today.month {
                    if hourDate.weekOfMonth == today.weekOfMonth {
                        stats["week"]! += hour.count
                    }
                    if hourDate.day == yesterday.day {
                        stats["yesterday"]! += hour.count
                    } else if hourDate.day == today.day {
                        stats["today"]! += hour.count
                    }
                }
            }

        }
        return stats
    }
}