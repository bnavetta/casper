//
//  AlarmManager.swift
//  Casper
//
//  Created by Ben Navetta on 10/31/15.
//  Copyright © 2015 Casper. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    let timeBefore: NSTimeInterval // how long before the start date to start sending this alert
    let interval: Int // time between notifications, in minutes
    let soundName: String
}

struct Alarm {
    let time: NSDate
    let warmupTime: Int // minutes before alarm time to start waking up
}

class AlarmManager {
    static let sharedInstance = AlarmManager()
    
    private func createNotifications(alert: Alert, alarm: Alarm) {
        for schedule in notificationSchedules(alarm.time.dateByAddingTimeInterval(-alert.timeBefore), interval: alert.interval) {
            let notification = UILocalNotification()
            notification.fireDate = schedule.fireDate
            notification.timeZone = NSTimeZone.defaultTimeZone()
            notification.alertTitle = "Wake Up"
            notification.alertBody = "Casper wants you to get up!"
            notification.category = "ALARM"
//            notification.repeatInterval = schedule.repeatInterval
            notification.soundName = alert.soundName
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    func schedule(alarm: Alarm) {
        for timeBefore in distances(Double(alarm.warmupTime)) {
            let alert = Alert(timeBefore: timeBefore, interval: 0, soundName: UILocalNotificationDefaultSoundName)
            createNotifications(alert, alarm: alarm)
        }
    }
}