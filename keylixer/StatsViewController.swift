//
//  StatsViewController.swift
//  keylixer
//
//  Created by Doug Black on 2/10/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Cocoa

class StatsViewController: NSViewController {

    @IBOutlet weak var hourLabel: NSTextField!
    @IBOutlet weak var dayLabel: NSTextField!
    @IBOutlet weak var weekLabel: NSTextField!
    @IBOutlet weak var monthLabel: NSTextField!
    @IBOutlet weak var yearLabel: NSTextField!
    @IBOutlet weak var totalLabel: NSTextField!
    var counter: Counter?

    override func viewDidLoad() {
        super.viewDidLoad()
        let stats = Statistician(counter: self.counter!).stats()
        hourLabel.stringValue = String(self.counter!.hours.last!.count)
        dayLabel.stringValue = String(stats["day"]!)
        weekLabel.stringValue = String(stats["week"]!)
        monthLabel.stringValue = String(stats["month"]!)
        yearLabel.stringValue = String(stats["year"]!)
        totalLabel.stringValue = String(stats["total"]!)
    }
}
