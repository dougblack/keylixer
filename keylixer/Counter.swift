//
//  Counter.swift
//  keylixer
//
//  Created by Doug Black on 2/8/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Cocoa

class Counter : NSObject {

    var hours : [Hour]
    
    override init() {
        self.hours = [Hour()]
        super.init()
        self.unarchive()
    }

    func count(event: NSEvent) {

        let now = Hour()
        
        if hours.isEmpty {
            hours.append(now)
        }

        if hours.last! != now {
            hours += now.andHoursSince(hours.last!)
        }
        
        hours.last!.inc()

    }

    func unarchive() {
        if var hours = Archiver.unarchiveHours() {
            self.hours = hours
            let now = Hour()
            if hours.last! != now {
                hours += now.andHoursSince(hours.last!)
            }
        }
    }

    func archive() {
        Archiver.archiveHours(self.hours)
    }
}