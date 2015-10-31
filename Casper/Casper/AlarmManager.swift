//
//  AlarmManager.swift
//  Casper
//
//  Created by Ben Navetta on 10/31/15.
//  Copyright © 2015 Casper. All rights reserved.
//

import UIKit

struct Alarm {
    let time: NSDate
}

class AlarmManager {
    static let sharedInstance = AlarmManager()
    
    func schedule(alarm: Alarm) {
        let notification = UILocalNotification()
        notification.fireDate = alarm.time
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.alertTitle = "Wake Up!"
        notification.alertBody = "NOW."
//        notification.alertAction = "shut off"
        notification.category = "ALARM"
        notification.repeatInterval = .Minute
        
        notification.soundName = UILocalNotificationDefaultSoundName // or a file name in the main bundle (< 30sec)
//        notification.userInfo = ["alarm": alarm] // need an ObjC object
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}