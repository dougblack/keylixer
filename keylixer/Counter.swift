//
//  Counter.swift
//  keylixer
//
//  Created by Doug Black on 2/8/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Foundation

class Counter : NSObject {
    var counts = [NSDate: Int]();
    var keys = [UInt16: Int]();
    var lastHour = NSDate();
    var updateDisplayCount : (NSString) -> ();
    
    init(updateDisplayCount: (NSString) -> ()) {
        self.updateDisplayCount = updateDisplayCount
    }
    
    func count(key: UInt16) {
        
        // Update key stats.
        if let keyCount = self.keys[key] {
            self.keys[key] = keyCount + 1
        } else {
            self.keys[key] = 1
        }
        
        // Update time total.
        let timestamp = NSDate().timeIntervalSince1970
        let lastHour = timestamp - fmod(timestamp, 3600)
        let date = NSDate(timeIntervalSince1970: lastHour)
        
        if let hourCount = self.counts[date] {
            self.counts[date] = hourCount + 1
        } else {
            self.counts[date] = 1
        }
        
        if let newHourCount = self.counts[date] {
            self.updateDisplayCount("\(newHourCount)")
        }
    }
}
