//
//  AppDelegate.swift
//  keylixer
//
//  Created by Doug Black on 2/8/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Cocoa

@NSApplicationMain
class Keylixer: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var counter : Counter?;

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.counter = Counter(updateDisplayCount: self.updateDisplayCount)
        self.statusItem.menu = self.buildMenu()
        self.statusItem.title = "--- keys"
        self.acquirePrivileges()
        self.attachKeyListener()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func acquirePrivileges() -> Bool {
        let accessEnabled = AXIsProcessTrustedWithOptions([kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true])
        if accessEnabled == false {
            print("Accessibility access refused.")
            exit(1)
        }
        return accessEnabled
    }
    
    func attachKeyListener() {
        NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.KeyDownMask, handler: {
            (event: NSEvent) in self.counter?.count(event.keyCode)
        })
    }
    
    func buildMenu() -> NSMenu {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Status", action: Selector("openStatus:"), keyEquivalent: "S"))
        return menu
    }
    
    func updateDisplayCount(count : NSString) {
        self.statusItem.title = "\(count) keys"
    }

}

