//
//  Archiver.swift
//  keylixer
//
//  Created by Doug Black on 2/10/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Foundation

class Archiver: NSObject {

    static let DocumentsDirectory = NSFileManager().URLsForDirectory(
        .DocumentDirectory, inDomains: .UserDomainMask
    ).first!
    static let PATH = DocumentsDirectory.URLByAppendingPathComponent("keylixer").path!

    class func unarchiveHours() -> [Hour]? {
        if NSFileManager.defaultManager().fileExistsAtPath(Archiver.PATH) {
            return NSKeyedUnarchiver.unarchiveObjectWithFile(Archiver.PATH) as? [Hour]
        } else {
            return nil
        }
    }

    class func archiveHours(hours: [Hour]) -> Bool {
        return NSKeyedArchiver.archiveRootObject(hours, toFile: Archiver.PATH)
    }
}