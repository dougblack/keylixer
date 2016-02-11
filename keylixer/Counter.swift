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

    var hours = [Hour]();
    var updateDisplayCount : (Int) -> ();
    
    /**
        This init() function just asks for a function handle it
        can shoot count updated events at.
    */
    init(updateDisplayCount: (Int) -> ()) {
        self.updateDisplayCount = updateDisplayCount
    }
    
    func updateHours() {
        
    }
    
     /**
     Do the actual counting. Here we ask for a key code and manipulate that
     into our three datastructures.
    
     */
    func count(key: UInt16) {

        let now = Hour()
        let last = self.hours.last
        
        if last == nil {
            self.hours.append(Hour())
        }
        
        if self.hours.last! != now {
            self.hours += now.hoursSince(self.hours.last!)
            self.hours.append(now)
        }
        
        self.hours.last!.inc()
        
        if let hour = self.hours.last {
            self.updateDisplayCount(hour.count)
        }
    }
}
