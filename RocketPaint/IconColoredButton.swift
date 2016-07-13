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

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event);
        self.alpha = 0.4;
    }
    override func touchesCancelled(touches: Set<UITouch>!, withEvent event: UIEvent!) {
        super.touchesCancelled(touches, withEvent: event);
        self.alpha = 1.0;
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event);
        self.alpha = 1.0;
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(IconColoredButton.colorChanged(_:)),
            name: Notifications.kColorChanged,
            object: nil)
        
    }
    
    func colorChanged(notification:NSNotification){
        iconColor = notification.userInfo!["color"] as! UIColor
        self.setNeedsDisplay()
    }
    
}