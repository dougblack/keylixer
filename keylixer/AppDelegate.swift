//
//  AppDelegate.swift
//  keylixer
//
//  Created by Doug Black on 2/8/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var counter = [UInt16: Int]()
    var total = 0;

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.statusItem.menu = self.buildMenu()
        self.statusItem.title = "--- keys"
        self.acquirePrivileges()
        self.attachKeyListener()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func acquirePrivileges() -> Bool {
        let accessEnabled = AXIsProcessTrustedWithOptions([kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true
        ])
        if accessEnabled == false {
            print("You need to enable keylixer in System Preferences")
        }
        return accessEnabled
    }
    
    func attachKeyListener() {
        NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.KeyDownMask, handler: {(event: NSEvent) in self.count(event)
        })
    }
    
    func count(event: NSEvent) {
        if let keyCount = self.counter[event.keyCode] {
            self.counter[event.keyCode] = keyCount + 1
        } else {
            self.counter[event.keyCode] = 1
        }
        self.total += 1
        self.statusItem.title = "\(total) keys"
        print("\(total) keys")
    }
    
    func buildMenu() -> NSMenu {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Status", action: Selector("openStatus:"), keyEquivalent: "S"))
        return menu
    }

}

