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

    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("keylixer")

    var hours : [Hour]
    var updateDisplayCount : (Int) -> ()
    
    /**
        This init() function just asks for a function handle it
        can shoot count updated events at.
    */
    init(updateDisplayCount: (Int) -> ()) {
        self.updateDisplayCount = updateDisplayCount
        self.hours = Counter.loadHours()
    }
    
    /**
        Do the actual counting.
    
    */
    func count(key: UInt16) {

        let now = Hour()
        
        if hours.last == nil {
            hours.append(Hour())
        }
        
        if hours.last! != now {
            hours += now.hoursSince(hours.last!)
            hours.append(now)
        }
        
        hours.last!.inc()
        
        if let hour = hours.last {
            updateDisplayCount(hour.count)
        }
    }

    func archive() {
        NSKeyedArchiver.archiveRootObject(self.hours, toFile: Counter.ArchiveURL.path!)
    }

    class func loadHours() -> [Hour] {
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(Counter.ArchiveURL.path!) {
            return NSKeyedUnarchiver.unarchiveObjectWithFile(Counter.ArchiveURL.path!) as! [Hour]
        } else {
            return [Hour]()
        }
    }

}
