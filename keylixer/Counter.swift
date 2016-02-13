//
//  Counter.swift
//  keylixer
//
//  Created by Doug Black on 2/8/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Cocoa

class Counter : NSObject {

    var hours = [Hour()]
    
    override init() {
        super.init()
        self.unarchive()
    }

    func count(event: NSEvent) {
        catchUp()
        hours.last!.inc()
    }

    func catchUp() {
        let now = Hour()
        if hours.last! != now {
            hours += hours.last!...now
        }
    }

    // MARK: Archival

    func unarchive() {
        if let hours = Archiver.unarchiveHours() {
            self.hours = hours
            catchUp()
        }
    }

    func archive() {
        Archiver.archiveHours(self.hours)
    }
}