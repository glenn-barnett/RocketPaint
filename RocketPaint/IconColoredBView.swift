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

    var iconColor:UIColor = UIColor.redColor()
    var lineWidth:CGFloat = 6.0
    
    func getLineWidthMin() -> Float {
        return 1.0
    }

    func getLineWidthMax() -> Float {
        return 40.0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()

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

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(IconColoredBView.lineWidthChanged(_:)),
            name: Notifications.kLineWidthChanged,
            object: nil)
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
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(IconColoredBView.lineWidthChanged(_:)),
            name: Notifications.kLineWidthChanged,
            object: nil)
        

    }
    
    func colorChanged(notification:NSNotification){
        iconColor = notification.userInfo!["color"] as! UIColor
        self.setNeedsDisplay()
    }

    
    func lineAlphaChanged(notification:NSNotification){
        let lineAlpha = notification.userInfo!["lineAlpha"] as! Float
        
        iconColor = iconColor.colorWithAlphaComponent(CGFloat(lineAlpha))
        self.setNeedsDisplay();
    }

    func lineWidthChanged(notification:NSNotification){
        let inputLineWidth = notification.userInfo!["lineWidth"] as! Float
        let adjustedLineWidth = getLineWidthMin() + (inputLineWidth / 40.0) * (getLineWidthMax() - getLineWidthMin());
        
        lineWidth = CGFloat(adjustedLineWidth)
        self.setNeedsDisplay()
    }

}