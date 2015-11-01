//
//  InterfaceController.swift
//  CasperWatch Extension
//
//  Created by Ben Navetta on 11/1/15.
//  Copyright © 2015 Casper. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        image.setImageNamed("casper")
        image.setWidth(300)
        image.setHeight(300)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
