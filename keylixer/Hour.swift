//
//  Hour.swift
//  keylixer
//
//  Created by Doug Black on 2/10/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Foundation

class Hour : NSObject, NSCoding {

    var count: Int
    var timestamp : NSTimeInterval

    override init() {
        self.timestamp = Hour.now()
        self.count = 0
    }

    init(timestamp: NSTimeInterval) {
        self.timestamp = timestamp
        self.count = 0
    }

    // MARK: Time Helper

    class func now() -> NSTimeInterval {
        let timestamp = NSDate().timeIntervalSince1970
        return timestamp - fmod(timestamp, 3600)
    }

    // MARK: Coding

    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInt(Int32(self.count), forKey: "count")
        coder.encodeDouble(self.timestamp, forKey: "timestamp")
    }

    required init?(coder decoder: NSCoder) {
        self.count = Int(decoder.decodeIntegerForKey("count"))
        self.timestamp = NSTimeInterval(decoder.decodeDoubleForKey("timestamp"))
    }

    func date() -> NSDateComponents {
        let date = NSDate(timeIntervalSince1970: timestamp)
        return NSCalendar.currentCalendar().components([.Year, .Month, .WeekOfMonth, .Day], fromDate: date)


    }
}

// MARK: Comparisons

func ==(lhs: Hour, rhs: Hour) -> Bool {
    return lhs.timestamp == rhs.timestamp
}

func !=(lhs: Hour, rhs: Hour) -> Bool {
    return !(lhs == rhs)
}

postfix func ++(hour: Hour) {
    hour.count++
}
