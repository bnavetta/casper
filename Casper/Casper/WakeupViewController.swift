//
//  WakeupViewController.swift
//  Casper
//
//  Created by Ben Navetta on 11/1/15.
//  Copyright © 2015 Casper. All rights reserved.
//

import UIKit
import AudioToolbox

let words = [
    "fish",
    "apple",
    "ghost",
    "scary",
    "haunt",
    "sleep",
    "doze",
    "snooze"
]

class WakeupViewController: UIViewController {
    
    @IBOutlet var instructions: UILabel!
    @IBOutlet var enteredText: UITextField!
    
    var word: String!
    
    var alarm: Alarm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var randomIndex: UInt = 0
        arc4random_buf(&randomIndex, sizeof(UInt))
        randomIndex %= UInt(words.count)
        word = words[Int(randomIndex)]
        
        instructions.text = "Type \"\(word)\" to prove you're awake"
    }
    
    override func viewWillAppear(animated: Bool) {
        AppDelegate.currentViewController = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func triggerValidation(sender: AnyObject) {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            if validateAnswer() {
                delegate.proofCompleted(true)
            }
            else {
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
        }
    }
    
    func validateAnswer() -> Bool {
        if let text = enteredText.text {
            return text == word
        }
        else {
            return false
        }
    }
}


