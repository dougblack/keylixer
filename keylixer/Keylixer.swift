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

    var counter : Counter! = Counter()
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var statsViewController : StatsViewController!
    let statsPopover = NSPopover()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        buildStatusItem()
        buildStatsPopover()
        registerKeyListener()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        self.counter.archive()
    }

    func registerKeyListener() {
        EventHandler.getPermission()
        EventHandler.registerKeyEvent({(event: NSEvent) in self.counter.count(event)})
    }

    // MARK: UI Logic

    func buildStatsPopover() {
        self.statsViewController = StatsViewController(counter: self.counter)
        statsPopover.contentViewController = statsViewController

        EventHandler.registerMouseEvent({
            (event: NSEvent) in
            if self.statsPopover.shown {
                self.statsPopover.performClose(event)
            }
        })

    }

    func buildStatusItem() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Stats", action: Selector("stats:"), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit", action: Selector("quit:"), keyEquivalent: ""))
        statusItem.menu = menu
        statusItem.button!.title = "⌨️"
    }

    func quit(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }

    func stats(sender: NSMenuItem) {
        if let button = statusItem.button {
            statsPopover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
    }

}