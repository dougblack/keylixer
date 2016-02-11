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
    
    init(timestamp: NSTimeInterval = Hour.now()) {
        self.timestamp = timestamp
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
        return Int(timestamp - start.timestamp)
    }
    
    func hoursSince(start: Hour) -> [Hour] {
        let hourRange = 1...(since(start) / 3600)
        return hourRange.map(Hour.init)
    }
    
    func inc() {
        self.count++
    }

    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInt(Int32(self.count), forKey: "count")
        coder.encodeDouble(self.timestamp, forKey: "timestamp")
    }

    required init?(coder decoder: NSCoder) {
        self.count = Int(decoder.decodeIntegerForKey("count"))
        self.timestamp = NSTimeInterval(decoder.decodeDoubleForKey("timestamp"))
    }
}

func ==(lhs: Hour, rhs: Hour) -> Bool {
    return lhs.timestamp == rhs.timestamp
}

func !=(lhs: Hour, rhs: Hour) -> Bool {
    return !(lhs == rhs)
}