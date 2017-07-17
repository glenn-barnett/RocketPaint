//
//  RocketDrawingView.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 5/12/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation

import UIKit
import ACEDrawingView

class RocketDrawingView: ACEDrawingView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        DrawingService.SharedInstance.isModified = true
        
//        NSNotificationCenter.defaultCenter().postNotificationName(
//            Notifications.kColorUsed,
//            object: nil)

    }
    
}
