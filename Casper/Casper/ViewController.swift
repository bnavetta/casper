//
//  ViewController.swift
//  Casper
//
//  Created by Ben Navetta on 10/31/15.
//  Copyright © 2015 Casper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        
        if let vc = segue.destinationViewController as? AlarmViewController {
            vc.answer = 42
        }
    }
}

