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
        brush = notification.object as! String;
        self.setNeedsDisplay();
    }

    
    override func drawRect(rect: CGRect) {
        
        if(brush == "Pen1") {
            RocketPaintStyleKit.drawPen1(iconColor:iconColor);
        } else if(brush == "Pen2") {
            RocketPaintStyleKit.drawPen2(iconColor:iconColor);
        } else if(brush == "Pen3") {
            RocketPaintStyleKit.drawPen3(iconColor:iconColor);
        } else if(brush == "Pen4") {
            RocketPaintStyleKit.drawPen4(iconColor:iconColor);
        } else if(brush == "Line1") {
            RocketPaintStyleKit.drawLine1(iconColor:iconColor);
        } else if(brush == "Line2") {
            RocketPaintStyleKit.drawLine2(iconColor:iconColor);
        } else if(brush == "Line3") {
            RocketPaintStyleKit.drawLine3(iconColor:iconColor);
        } else if(brush == "Line4") {
            RocketPaintStyleKit.drawLine4(iconColor:iconColor);
        } else if(brush == "Box") {
            RocketPaintStyleKit.drawBox(iconColor:iconColor);
        } else if(brush == "HighlightGreen") {
            RocketPaintStyleKit.drawHighlightGreen();
        } else if(brush == "HighlightYellow") {
            RocketPaintStyleKit.drawHighlightYellow();
        } else if(brush == "HighlightRed") {
            RocketPaintStyleKit.drawHighlightRed();
        } else if(brush == "TextSerifBig") {
            RocketPaintStyleKit.drawTextSerifBig(iconColor:iconColor);
        } else if(brush == "TextSerifSmall") {
            RocketPaintStyleKit.drawTextSerifSmall(iconColor:iconColor);
        } else if(brush == "TextSansBig") {
            RocketPaintStyleKit.drawTextSansBig(iconColor:iconColor);
        } else if(brush == "TextSansSmall") {
            RocketPaintStyleKit.drawTextSansSmall(iconColor:iconColor);
        }
        
    }
}