//
//  ViewController.swift
//  Casper
//
//  Created by Ben Navetta on 10/31/15.
//  Copyright © 2015 Casper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onStart(sender: UIButton) {
        self.showAlarm()
    }

    func showAlarm() {
        print("Transitioning!")
        performSegueWithIdentifier("showAlarm", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("From \(segue.sourceViewController) to \(segue.destinationViewController)")
        
        var date = timePicker.date;
        if date.compare(NSDate()) == .OrderedAscending {
            // if the time chosen is such that the date is in the past, go to tomorrow
            date = NSCalendar.autoupdatingCurrentCalendar().dateByAddingUnit(.Day, value: 1, toDate: date, options: [])!
        }
        
        if let vc = segue.destinationViewController as? AlarmViewController {
            let alarm = Alarm(time: date, warmupTime: 20)
            vc.alarm = alarm
            AlarmManager.sharedInstance.schedule(alarm) // Is this where it should happen?
        }
    }
}

