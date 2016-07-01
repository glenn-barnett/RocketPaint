//
//  UndoButton.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class IconColoredButton: UIButton {

    var iconColor:UIColor = UIColor.redColor();
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(UndoButton.colorSelected(_:)),
            name: Notifications.kColorSelected,
            object: nil)
        
    }
    
    func colorSelected(notification:NSNotification){
        iconColor = notification.object as! UIColor;
        self.setNeedsDisplay();
    }
    
}