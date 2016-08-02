//
//  LineWidthSliderView.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/28/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class LineWidthSliderView: UIControl {

    var value : CGFloat = 10.0 {
        didSet { self.setNeedsDisplay() }
    }

    var minimumValue : CGFloat = 1.0 {
        didSet { self.setNeedsDisplay(); }
    }
    
    var maximumValue : CGFloat = 40.0 {
        didSet { self.setNeedsDisplay(); }
    }
    
    var iconColor : UIColor = UIColor.redColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(LineWidthSliderView.colorChanged(_:)),
            name: Notifications.kColorChanged,
            object: nil)
    }
    
    func colorChanged(notification:NSNotification){
        iconColor = notification.userInfo!["color"] as! UIColor
        self.setNeedsDisplay()
    }
    
    func percentageValue() -> CGFloat {
        if (self.maximumValue == self.minimumValue) {
            return 0.5
        }
        
        return (self.value - self.minimumValue) / (self.maximumValue - self.minimumValue)
    }
    
    func valueFromPercentage(percentage: CGFloat) -> CGFloat {
        return percentage * (self.maximumValue - self.minimumValue) + self.minimumValue
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        super.beginTrackingWithTouch(touch, withEvent: event)
        return true
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        super.continueTrackingWithTouch(touch, withEvent: event)
        
        let lastPoint : CGPoint = touch.locationInView(self)
        moveThumbToPoint(lastPoint)
        sendActionsForControlEvents(.ValueChanged)
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        super.endTrackingWithTouch(touch, withEvent: event)
    }
    
    func moveThumbToPoint(point: CGPoint) {
        let percentage : CGFloat = min(1, max(0, (point.x - 10) / (CGRectGetWidth(self.bounds) - 20)));
        
        self.value = valueFromPercentage(percentage)
        setNeedsDisplay()
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSizeMake(UIViewNoIntrinsicMetric, 20)
    }
    
    override func drawRect(rect: CGRect) {
        
        let lineWidth = CGFloat(2.0)
        
        let buffer = CGFloat(20.0);
        let sliderFrame: CGRect = CGRect(
            x: rect.origin.x + buffer,
            y: rect.origin.y,
            width:rect.size.width - buffer * 2,
            height:rect.size.height)
        
        let minRadius = CGFloat(2)
        let maxRadius = CGFloat(30)
        
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let maximumTrackColor = UIColor(red: 0.522, green: 0.522, blue: 0.522, alpha: 1.000)
        
        
        //// Subframes
        let track: CGRect = CGRect(x: sliderFrame.minX, y: sliderFrame.minY + floor((sliderFrame.height - 4) * 0.50000 + 0.5), width: sliderFrame.width, height: 4)
        let trackFrame = CGRect(x: track.minX + floor(track.width * 0.00000 + 0.5), y: track.minY, width: floor(track.width * 1.00000 + 0.5) - floor(track.width * 0.00000 + 0.5), height: 4)
        
        // GB ADDED BEGIN
        let percentage : CGFloat = self.percentageValue()
        
        let minimumTrackRect : CGRect = CGRectMake(CGRectGetMinX(trackFrame), CGRectGetMinY(trackFrame), floor((CGRectGetWidth(trackFrame)) * percentage), 4)
        let maximumTrackRect : CGRect = CGRectMake(CGRectGetMinX(trackFrame) + floor((CGRectGetWidth(trackFrame)) * percentage), CGRectGetMinY(trackFrame), CGRectGetWidth(trackFrame) - floor((CGRectGetWidth(trackFrame)) * percentage), 4)
        // GB ADDED endTrackingWithTouch
        

        let crescendoPath = UIBezierPath()
        crescendoPath.moveToPoint(CGPoint(x: CGRectGetMinX(trackFrame), y: CGRectGetMinY(trackFrame) - (minRadius - 2)))
        crescendoPath.addLineToPoint(CGPoint(x: CGRectGetMaxX(trackFrame), y: CGRectGetMinY(trackFrame) - maxRadius))
        crescendoPath.addLineToPoint(CGPoint(x: CGRectGetMaxX(trackFrame), y: CGRectGetMaxY(trackFrame) + maxRadius))
        crescendoPath.addLineToPoint(CGPoint(x: CGRectGetMinX(trackFrame), y: CGRectGetMaxY(trackFrame) + (minRadius - 2)))
        crescendoPath.closePath()
        iconColor.colorWithAlphaComponent(0.2).setFill()
        crescendoPath.fill()
        
        //// Track
        //// Minimum Track Drawing
        let minimumTrackPath = UIBezierPath(roundedRect: minimumTrackRect, byRoundingCorners: [UIRectCorner.TopLeft, UIRectCorner.BottomLeft], cornerRadii: CGSize(width: 2, height: 2))
        minimumTrackPath.closePath()
        iconColor.colorWithAlphaComponent(1.0).setFill()
        minimumTrackPath.fill()
        
        
        //// Maximum Track Drawing
        let maximumTrackPath = UIBezierPath(roundedRect: maximumTrackRect, byRoundingCorners: [UIRectCorner.TopRight, UIRectCorner.BottomRight], cornerRadii: CGSize(width: 2, height: 2))
        maximumTrackPath.closePath()
        maximumTrackColor.setFill()
        maximumTrackPath.fill()
        
        
        
        
        //// Thumb Drawing
        CGContextSaveGState(context)
//        CGContextTranslateCTM(context, sliderFrame.maxX - 104.7, sliderFrame.maxY - 10)
//        CGContextScaleCTM(context, lineWidthSliderScale, lineWidthSliderScale)
        
        // scaled thumb half
        let thumbPath1 = UIBezierPath(
            arcCenter: CGPoint(
                x: CGRectGetMinX(sliderFrame) + floor((CGRectGetWidth(sliderFrame) - 20) * percentage),
//                y: CGRectGetMinY(sliderFrame) + floor((CGRectGetHeight(sliderFrame) - 20) * 0.50000 + 0.5)
                y: CGRectGetHeight(sliderFrame) / 2
                ),
            radius: minRadius + percentageValue() * (maxRadius - minRadius),
            startAngle: 0,
            endAngle: CGFloat(M_PI * 2),
            clockwise: true)
        
        iconColor.colorWithAlphaComponent(1.0).setFill()
        thumbPath1.fill()

        let thumbRect = UIBezierPath(rect: CGRectMake(
            CGRectGetMinX(sliderFrame) + floor((CGRectGetWidth(sliderFrame) - 20) * percentage) - 1,
            CGRectGetHeight(sliderFrame) / 2 - 15,
            2,
            30
            ))
        
        thumbRect.fill()

//        UIColor.grayColor().setStroke() //TODO gray stroke ok?
//        thumbPath1.stroke()
        
        CGContextRestoreGState(context)
        
    }
}
