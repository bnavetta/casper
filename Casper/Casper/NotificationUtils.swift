//
//  NotificationUtils.swift
//  Casper
//
//  Created by Ben Navetta on 10/31/15.
//  Copyright © 2015 Casper. All rights reserved.
//

import Foundation

struct Schedule {
    let fireDate: NSDate
    let repeatInterval: NSCalendarUnit
}

// Generate a schedule for notifications to replicate the desired time interval.
// For example, a 10 minute interval would result in 6 alert times 10 minutes apart,
// each repeating hourly. A 15 minute interval would result in 4 alert times 15 minutes
// apart, each repeating hourly.
func notificationSchedules(start: NSDate, interval: Int) -> Array<Schedule> {
    if interval == 1 {
        return [Schedule(fireDate: start, repeatInterval: .Minute)]
    }
    else if interval == 60 {
        return [Schedule(fireDate: start, repeatInterval: .Hour)]
    }
    else {
        let numAlerts = 60 / interval;
        let stagger: Double = Double(interval) * 60.0;
        return (0..<numAlerts).map({ alertIndex in
            let offset: Double = stagger * Double(alertIndex);
            return Schedule(fireDate: start.dateByAddingTimeInterval(offset), repeatInterval: .Hour);
        });
    }
}