//
//  AlarmDates.swift
//  Casper
//
//  Created by Nicholas Tomlin on 10/31/15.
//  Copyright © 2015 Casper. All rights reserved.
//

import Foundation

// I/P : num, a certain number of minutes before the final wake-up time
// O/P : a list where each element is an NSTimeInterval representing the
//       number of seconds after wake-up time an alarm is set to go off
func distances(num: Double) -> Array<NSTimeInterval> {
    var fSeq = [1.0,1.0]
    while fSeq.last < num {
        if fSeq[fSeq.count - 2] + fSeq.last! <= num {
            fSeq.append(fSeq[fSeq.count - 2] + fSeq.last!)
        }
    }
    let scalar = fSeq.last! / num
    for (index, element) in fSeq.enumerate() {
        fSeq[index] = NSTimeInterval(-60 * scalar * element)
    }
    return fSeq
}