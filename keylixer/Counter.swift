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


    var hours : [Hour]
    var updateDisplayCount : (Int) -> ()
    
    /**
        This init() function just asks for a function handle it
        can shoot count updated events at. It tries loading the hours
        in the background.
    */
    init(updateDisplayCount: (Int) -> ()) {
        self.updateDisplayCount = updateDisplayCount

        if let hours = Archiver.unarchiveHours() {
            self.hours = hours
        } else {
            self.hours = [Hour]()
        }
    }
    
    /**
        Do the actual counting.
    */
    func count(key: UInt16) {

        let now = Hour()
        
        if hours.isEmpty {
            hours.append(now)
        }

        if hours.last! != now {
            hours += now.hoursSince(hours.last!)
            hours.append(now)
        }
        
        hours.last!.inc()
        updateDisplayCount(hours.last!.count)
    }

    func archive() {
        Archiver.archiveHours(self.hours)
    }
}
