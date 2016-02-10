//
//  Counter.swift
//  keylixer
//
//  Created by Doug Black on 2/8/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Foundation

class Counter : NSObject {
    /**
        A Counter stores counts. It stores two types of counts.
        - The total keystrokes per hour in a dictionary with one key/value pair per hour.
        - The total counts broken down by each key code.
    */

    var dates = [NSTimeInterval]();
    var counts = [Int]();
    var keys = [UInt16: Int]();
    var updateDisplayCount : (Int) -> ();
    
    /**
        This init() function just asks for a function handle it
        can shoot count updated events at.
    */
    init(updateDisplayCount: (Int) -> ()) {
        self.updateDisplayCount = updateDisplayCount
    }
    
    /**
        Do the actual counting. Here we ask for a key code and manipulate that
        into our two datastructures.
    */
    func count(key: UInt16) {
        
        // Update key stats.
        self.keys[key] = self.keys[key, or: 0] + 1
        
        // Update time total.
        let timestamp = NSDate().timeIntervalSince1970
        let lastHour = timestamp - fmod(timestamp, 3600)

        if self.dates.last == lastHour {
            self.counts[self.counts.endIndex-1] = self.counts.last! + 1
        } else {
            self.dates.append(lastHour)
            self.counts.append(1)
        }
        
        // Update display.
        if let newHourCount = self.counts.last {
            self.updateDisplayCount(newHourCount)
        }
    }
}
