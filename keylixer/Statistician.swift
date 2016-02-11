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

        var stats : [String: Int] = ["year": 0, "month": 0, "week": 0, "day": 0, "total": 0]
        let calendar = NSCalendar.currentCalendar()
        let currentComponents = calendar.components(NSCalendarUnit(), fromDate: NSDate())

        for hour in self.counter.hours {
            let date = NSDate(timeIntervalSince1970: hour.timestamp)
            let dateComponents = calendar.components(NSCalendarUnit(), fromDate: date)
            stats["total"]! += hour.count
            if dateComponents.year == currentComponents.year {
                stats["year"]! += hour.count
                if currentComponents.month == dateComponents.month {
                    stats["month"]! += hour.count
                    if currentComponents.weekOfMonth == dateComponents.weekOfMonth {
                        stats["week"]! += hour.count
                        if currentComponents.day == dateComponents.day {
                            stats["day"]! += hour.count
                        }
                    }
                }
            }
        }
        return stats
    }

}