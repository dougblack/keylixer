//
//  NSTimeInterval.swift
//  keylixer
//
//  Created by Doug Black on 2/10/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Foundation

class Hour : NSObject {
    
    var count: Int
    var timestamp : NSTimeInterval
    
    init(initTimestamp: NSTimeInterval = Hour.now()) {
        self.timestamp = initTimestamp
        self.count = 0
    }
    
    init(initWithHours: Int) {
        self.timestamp = NSTimeInterval(initWithHours * 3600)
        self.count = 0
    }
    
    class func now() -> NSTimeInterval {
        let timestamp = NSDate().timeIntervalSince1970
        return timestamp - fmod(timestamp, 3600)
    }
    
    func since(start: Hour)  -> Int {
        return Int(self.timestamp - start.timestamp)
    }
    
    func hoursSince(start: Hour) -> [Hour] {
        let hourRange = 1...(self.since(start) / 3600)
        return hourRange.map(Hour.init)
    }
    
    func inc() {
        self.count++
    }
}

func ==(lhs: Hour, rhs: Hour) -> Bool {
    return lhs.timestamp == rhs.timestamp
}

func !=(lhs: Hour, rhs: Hour) -> Bool {
    return !(lhs == rhs)
}