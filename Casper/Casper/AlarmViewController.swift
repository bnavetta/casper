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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

