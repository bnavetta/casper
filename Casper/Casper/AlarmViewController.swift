//
//  AlarmViewController.swift
//  Casper
//
//  Created by Ben Navetta on 11/1/15.
//  Copyright © 2015 Casper. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    
    var alarm: Alarm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Alarm: \(alarm)")
    }
    
    override func viewWillAppear(animated: Bool) {
        AppDelegate.currentViewController = self
    }
    
    override func viewDidAppear(animated: Bool) {
        if !AlarmManager.sharedInstance.alarmScheduled() {
            print("No alarm set, returning to home screen")
            self.performSegueWithIdentifier("goHome", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "wakeUp" {
                if let alarm = sender as? Alarm, vc = segue.destinationViewController as? WakeupViewController {
                    vc.alarm = alarm
                }
            }
        }
    }
}

