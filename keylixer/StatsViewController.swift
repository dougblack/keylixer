//
//  StatsViewController.swift
//  keylixer
//
//  Created by Doug Black on 2/10/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Cocoa

class StatsViewController: NSViewController {

    @IBOutlet weak var dayLabel: NSTextField!
    @IBOutlet weak var yesterdayLabel: NSTextField!
    @IBOutlet weak var weekLabel: NSTextField!
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
        dayLabel.stringValue = String(stats["today"]!)
        yesterdayLabel.stringValue = String(stats["yesterday"]!)
        weekLabel.stringValue = String(stats["week"]!)
        totalLabel.stringValue = String(stats["total"]!)
    }
}
