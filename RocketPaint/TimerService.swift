//
//  TimerService.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 8/8/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation

public class TimerService {
    static let SharedInstance = TimerService()
    
    var backupTimer : NSTimer?

    init() {
        backupTimer = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: #selector(TimerService.backupState), userInfo: nil, repeats: true)
        
    }
    
    // must be internal or public.
    @objc func backupState() {
//        print("TimerService.backupState(): persisting state")
        DrawingService.SharedInstance.persistState()
    }

}
