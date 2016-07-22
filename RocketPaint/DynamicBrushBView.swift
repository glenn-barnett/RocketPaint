//
//  BrushBView.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class DynamicBrushBView: IconColoredBView {
    
    var brush : String = "Pen3";
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(DynamicBrushBView.brushChanged(_:)),
            name: Notifications.kBrushChanged,
            object: nil)
        
    }
    
    func brushChanged(notification:NSNotification){
        brush = notification.userInfo!["brush"] as! String
        self.setNeedsDisplay();
    }

    
    override func drawRect(rect: CGRect) {
        
        if(brush == "Pen") {
            RocketPaintStyleKit.drawGPen(iconColor:iconColor);
        } else if(brush == "Line") {
            RocketPaintStyleKit.drawGLine(iconColor:iconColor);
        } else if(brush == "EllipseSolid") {
            RocketPaintStyleKit.drawGEllipseSolid(iconColor:iconColor);
        } else if(brush == "EllipseOutline") {
            RocketPaintStyleKit.drawGEllipseOutline(iconColor:iconColor);
        } else if(brush == "RectSolid") {
            RocketPaintStyleKit.drawGRectSolid(iconColor:iconColor);
        } else if(brush == "RectOutline") {
            RocketPaintStyleKit.drawGRectOutline(iconColor:iconColor);
        } else if(brush == "TextSerif") {
            RocketPaintStyleKit.drawGTextSerif(iconColor:iconColor);
        } else if(brush == "TextSans") {
            RocketPaintStyleKit.drawGTextSans(iconColor:iconColor);
        } else {
            RocketPaintStyleKit.drawPalette(iconColor:iconColor);
        }
        
    }
}