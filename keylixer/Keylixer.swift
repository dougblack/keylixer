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
    /**
        This is the start point for Keylixer.
    */

    var counter : Counter?
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var displayCount: Int?

    /**
        Keylixer is just loading. Ensure we have permission to listen to key
        down events, build the status menu, and start listening.
    */
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.counter = Counter(updateDisplayCount: self.updateDisplayCount)
        self.statusItem.menu = self.buildMenu()
        self.statusItem.title = "--- keys"
        self.acquirePrivileges()
        self.attachKeyListener()
    }

    /**
        Keylixer is trying to quit. Save the data!
    */
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    /**
        Receiving global key down events requires getting permission through the
        Accessibility preferences.
    */
    func acquirePrivileges() {
        if AXIsProcessTrustedWithOptions([kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]) == false {
            print("Accessibility access refused.")
            exit(1)
        }
    }
    
    /**
        This is the function that actually attaches the keydown event listener.
        It uses the relatively new Notifications API, which allows us to grab a read-only
        stream of events.
    */
    func attachKeyListener() {
        NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask.KeyDownMask, handler: {
            (event: NSEvent) in self.counter?.count(event.keyCode)
        })
    }
    
    /**
        Build the menu. This provides stats and preferences options.
    */
    func buildMenu() -> NSMenu {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Stats", action: Selector("openStats:"), keyEquivalent: "S"))
        menu.addItem(NSMenuItem(title: "Preferences", action: Selector("openPreferences:"), keyEquivalent: "P"))
        return menu
    }
    
    /**
        This is the function that actually updates the active key count on the status item.
    */
    func updateDisplayCount(count : Int) {
        self.displayCount = count
    }

}

