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
    var counter : Counter!


    init?(counter: Counter) {
        self.counter = counter
        super.init(nibName: "StatsViewController", bundle: nil)
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        let stats = Statistician(counter: counter).stats()
        let hours = counter.hours
        let last = hours.last!
        let count = last.count
        hourLabel.stringValue = String(count)
        dayLabel.stringValue = String(stats["day"]!)
        weekLabel.stringValue = String(stats["week"]!)
        monthLabel.stringValue = String(stats["month"]!)
        yearLabel.stringValue = String(stats["year"]!)
        totalLabel.stringValue = String(stats["total"]!)
    }
}
