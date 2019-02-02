//
//  Math+randomFractional.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 10/10/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation

// http://stackoverflow.com/a/35919911/120103

struct Math {
    fileprivate static var seeded = false
    
    static func randomFractional() -> CGFloat {
        
        if !Math.seeded {
            let time = Int(NSDate().timeIntervalSinceReferenceDate)
            srand48(time)
            Math.seeded = true
        }
        
        return CGFloat(drand48())
    }
}
