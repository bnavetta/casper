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
    let timeBefore: Int // how many minutes before to start sending notifications
    let interval: Int // time between notifications, in minutes
    let soundName: String
}

@objc class Alarm: NSObject, NSCoding {
    let time: NSDate
    let warmupTime: Int // minutes before alarm time to start waking up
    
    init(time: NSDate, warmupTime: Int) {
        self.time = time
        self.warmupTime = warmupTime
    }
    
    // MARK: NSCoding
    required convenience init?(coder decoder: NSCoder) {
        guard let time = decoder.decodeObjectOfClass(NSDate.self, forKey: "time") else { return nil }
        let warmupTime = decoder.decodeIntegerForKey("warmupTime")
        self.init(time: time, warmupTime: warmupTime)
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(warmupTime, forKey: "warmupTime")
        coder.encodeObject(time, forKey: "time")
    }
}

protocol AlarmManagerDelegate {
    // callback for demonstrating user actually awake
    func alarmDidComplete(alarm: Alarm, proofCallback: Bool -> ())
}

class AlarmManager {
    static let sharedInstance = AlarmManager()
    
    var delegate: AlarmManagerDelegate?
    
    private static let dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.timeStyle = .MediumStyle
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        return dateFormatter
    }();
    
    private func createNotifications(alert: Alert, alarm: Alarm) {
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        let startTime = calendar.dateByAddingUnit(.Minute, value: -alert.timeBefore, toDate: alarm.time, options: .MatchStrictly)!
        let schedules = notificationSchedules(startTime, interval: alert.interval)
        
        for (index, schedule) in schedules.enumerate() {
            if schedule.fireDate.compare(NSDate()) == .OrderedAscending {
                // Don't schedule notifications that would be in the past
                continue;
            }
            
            // TODO: filter out notifications that are too close together
            
            print("Notification scheduled at \(AlarmManager.dateFormatter.stringFromDate(schedule.fireDate))")
            
            let notification = UILocalNotification()
            notification.fireDate = schedule.fireDate
            notification.timeZone = NSTimeZone.defaultTimeZone()
            notification.alertTitle = "Wake Up"
            notification.alertBody = "Casper wants you to get up!"
            if index == schedules.count - 1 {
                notification.category = "done"
            }
            else {
                notification.category = "alarm"
            }
            notification.soundName = alert.soundName
            notification.userInfo = ["alarm": NSKeyedArchiver.archivedDataWithRootObject(alarm)]
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    func schedule(alarm: Alarm) {
        for timeBefore in distances(Double(alarm.warmupTime)) {
            let minutesBefore = -Int(round(timeBefore/60))
            // TODO: origin
            let alert = Alert(timeBefore: minutesBefore, interval: 1, soundName: "sound.caf"/*UILocalNotificationDefaultSoundName*/)
            createNotifications(alert, alarm: alarm)
        }
    }
    
    func configureNotifications(application: UIApplication) {
        let cancelAction = UIMutableUserNotificationAction()
        cancelAction.title = "Cancel"
        cancelAction.identifier = "cancel"
        cancelAction.activationMode = .Background
        cancelAction.authenticationRequired = true // prevent canceling while still asleep - need to Touch ID or enter passcode
        cancelAction.destructive = true // oversleeping can be dangerous
        
        let dismissAction = UIMutableUserNotificationAction()
        dismissAction.title = "Dismiss"
        dismissAction.identifier = "dismiss"
        dismissAction.activationMode = .Background
        dismissAction.authenticationRequired = false
        
        let alarmCategory = UIMutableUserNotificationCategory()
        alarmCategory.setActions([cancelAction, dismissAction], forContext: .Default)
        alarmCategory.identifier = "alarm"
        
        let completeAction = UIMutableUserNotificationAction()
        completeAction.title = "I'm Awake!"
        completeAction.identifier = "complete"
        completeAction.activationMode = .Foreground
        
        let doneCategory = UIMutableUserNotificationCategory()
        doneCategory.setActions([completeAction], forContext: .Default)
        doneCategory.identifier = "done"
        
        application.registerUserNotificationSettings(
            UIUserNotificationSettings(forTypes: [ .Alert, .Sound, .Badge], categories: [alarmCategory, doneCategory]))
    }
    
    func handleAction(identifier: String, notification: UILocalNotification) {
        if identifier == "cancel" {
            cancelAlarm()
        }
        else if identifier == "dismiss" {
            // nothing
        }
        else if identifier == "complete" {
            let alarm = AlarmManager.getAlarm(forNotification: notification)!
            delegate?.alarmDidComplete(alarm, proofCallback: {provedAwake in
                if provedAwake {
                    self.cancelAlarm()
                }
            })
        }
    }
    
    func alarmScheduled() -> Bool {
        if let localNotifications = UIApplication.sharedApplication().scheduledLocalNotifications {
            return !localNotifications.isEmpty
        }
        else {
            return false
        }
    }
    
    func cancelAlarm() {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    class func getAlarm(forNotification notification: UILocalNotification) -> Alarm? {
        guard let userInfo = notification.userInfo, data = userInfo["alarm"] as? NSData else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Alarm
    }
}