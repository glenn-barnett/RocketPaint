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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(DynamicBrushBView.brushChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kBrushChanged),
            object: nil)
        
    }
    
    @objc func brushChanged(_ notification:Notification){
        brush = notification.userInfo!["brush"] as! String
        self.setNeedsDisplay();
    }

    
    override func draw(_ rect: CGRect) {
        
        if(brush == "Pen") {
            let minLineWidth : CGFloat = 1.0
            let maxLineWidth : CGFloat = 25.0
            let adjustedLineWidth = minLineWidth + (lineWidth / 40.0) * (maxLineWidth - minLineWidth);

            RocketPaintStyleKit.drawGPen(iconColor:iconColor, lineWidth: adjustedLineWidth);
        } else if(brush == "Line") {
            let minLineWidth : CGFloat = 1.0
            let maxLineWidth : CGFloat = 25.0
            let adjustedLineWidth = minLineWidth + (lineWidth / 40.0) * (maxLineWidth - minLineWidth);
            RocketPaintStyleKit.drawGLine(iconColor:iconColor, lineWidth: adjustedLineWidth);
        } else if(brush == "EllipseSolid") {
            RocketPaintStyleKit.drawGEllipseSolid(iconColor:iconColor);
        } else if(brush == "EllipseOutline") {
            let minLineWidth : CGFloat = 1.0
            let maxLineWidth : CGFloat = 24.0
            let adjustedLineWidth = minLineWidth + (lineWidth / 40.0) * (maxLineWidth - minLineWidth);
            RocketPaintStyleKit.drawGEllipseOutline(iconColor:iconColor, lineWidth: adjustedLineWidth);
        } else if(brush == "RectSolid") {
            RocketPaintStyleKit.drawGRectSolid(iconColor:iconColor);
        } else if(brush == "RectOutline") {
            let minLineWidth : CGFloat = 1.0
            let maxLineWidth : CGFloat = 24.0
            let adjustedLineWidth = minLineWidth + (lineWidth / 40.0) * (maxLineWidth - minLineWidth);
            RocketPaintStyleKit.drawGRectOutline(iconColor:iconColor, lineWidth: adjustedLineWidth);
        } else if(brush == "TextSerif") {
            let minLineWidth : CGFloat = 5.0
            let maxLineWidth : CGFloat = 20.0
            let adjustedLineWidth = minLineWidth + (lineWidth / 40.0) * (maxLineWidth - minLineWidth);
            RocketPaintStyleKit.drawGTextSerif(iconColor:iconColor, lineWidth: adjustedLineWidth);
        } else if(brush == "TextSans") {
            let minLineWidth : CGFloat = 5.0
            let maxLineWidth : CGFloat = 20.0
            let adjustedLineWidth = minLineWidth + (lineWidth / 40.0) * (maxLineWidth - minLineWidth);
            RocketPaintStyleKit.drawGTextSans(iconColor:iconColor, lineWidth: adjustedLineWidth);
        } else {
            RocketPaintStyleKit.drawPalette(iconColor:iconColor);
        }
        
    }
}
