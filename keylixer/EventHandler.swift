//
//  EventHandler.swift
//  keylixer
//
//  Created by Doug Black on 2/11/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Cocoa

class EventHandler : NSObject {

    static let MOUSE_EVENT : NSEventMask = [NSEventMask.LeftMouseDownMask, NSEventMask.RightMouseDownMask]
    static let KEY_EVENT = NSEventMask.KeyDownMask

    class func register(masks: NSEventMask, handler: (NSEvent) -> ()) {
        NSEvent.addGlobalMonitorForEventsMatchingMask(masks, handler: handler)
    }

    class func registerKeyEvent(handler: (NSEvent) -> ()) {
        self.register(EventHandler.KEY_EVENT, handler: handler)
    }

    class func registerMouseEvent(handler: (NSEvent) -> ()) {
        self.register(EventHandler.MOUSE_EVENT, handler: handler)
    }

    class func getPermission() -> Bool {
        return AXIsProcessTrustedWithOptions(
            [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        )
    }
}
