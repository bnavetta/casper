//
//  AlarmDB.swift
//  Casper
//
//  Created by Ben Navetta on 11/1/15.
//  Copyright © 2015 Casper. All rights reserved.
//

import Foundation

@objc class AlarmState : NSObject {
    var timeLeft: NSTimeInterval
    var alertsLeft: Int
    
    init(timeLeft: NSTimeInterval, alertsLeft: Int) {
        self.timeLeft = timeLeft
        self.alertsLeft = alertsLeft
    }
}

class AlarmDB {
    static let sharedInstance = AlarmDB()
    
    let defaults: NSUserDefaults
    
    init(defaults: NSUserDefaults) {
        self.defaults = defaults
    }
    
    convenience init() {
        self.init(defaults: NSUserDefaults.standardUserDefaults())
    }
    
//    func currentState() -> AlarmState {
    
//    }
}