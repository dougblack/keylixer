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
    let statsPopover = NSPopover()

    /**
        Keylixer is just loading. Ensure we have permission to listen to key
        down events, build the status menu, and start listening.
    */
    func applicationDidFinishLaunching(aNotification: NSNotification) {

        self.counter = Counter(updateDisplayCount: self.updateDisplayCount)

        self.statusItem.menu = self.buildMenu()
        self.statusItem.button!.title = "Keys"

        self.acquirePrivileges()
        self.attachKeyListener()

        let statsViewController = StatsViewController(nibName: "StatsViewController", bundle: nil)
        statsViewController!.counter = self.counter
        statsPopover.contentViewController = statsViewController
    }

    /**
        Keylixer is trying to quit. Save the data!
    */
    func applicationWillTerminate(aNotification: NSNotification) {
        self.counter!.archive()
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
        menu.addItem(NSMenuItem(title: "Stats", action: Selector("stats:"), keyEquivalent: "S"))
        menu.addItem(NSMenuItem(title: "Quit", action: Selector("quit:"), keyEquivalent: "Q"))
        return menu
    }
    /**
        This is the function that actually updates the active key count on the status item.
    */
    func updateDisplayCount(count : Int) {
        self.statusItem.button!.title = "\(count) keys"
        print(count)
    }

    func quit(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }

    func stats(sender: NSMenuItem) {
        if let button = statusItem.button {
            statsPopover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
            NSEvent.addGlobalMonitorForEventsMatchingMask([NSEventMask.LeftMouseDownMask, NSEventMask.RightMouseDownMask], handler: {
                (event: NSEvent) in
                if self.statsPopover.shown {
                    self.statsPopover.performClose(event)
                }
            })
        }
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
}

