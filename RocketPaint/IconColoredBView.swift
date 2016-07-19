//
//  UndoButton.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class IconColoredBView: BView {

    var iconColor:UIColor = UIColor.redColor();
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(IconColoredBView.colorChanged(_:)),
            name: Notifications.kColorChanged,
            object: nil)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(IconColoredBView.lineAlphaChanged(_:)),
            name: Notifications.kLineAlphaChanged,
            object: nil)

    }
    
    func colorChanged(notification:NSNotification){
        iconColor = notification.userInfo!["color"] as! UIColor
        self.setNeedsDisplay()
        print("IconColoredBView.colorChanged() END")
    }

    func lineAlphaChanged(notification:NSNotification){
        let lineAlpha = notification.userInfo!["lineAlpha"] as! Float
        
        iconColor = iconColor.colorWithAlphaComponent(CGFloat(lineAlpha))
        self.setNeedsDisplay();
        print("IconColoredBView.lineAlphaChanged() END")
    }

}