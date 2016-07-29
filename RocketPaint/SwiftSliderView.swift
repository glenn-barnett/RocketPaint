//
//  SliderView.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/28/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class SwiftSliderView: UIControl {

    var value : CGFloat = 0.5 {
        didSet { self.setNeedsDisplay(); }
    }

    var minimumValue : CGFloat = 0.0 {
        didSet { self.setNeedsDisplay(); }
    }
    
    var maximumValue : CGFloat = 1.0 {
        didSet { self.setNeedsDisplay(); }
    }
    
    var brushColor : UIColor = UIColor.orangeColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
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
        let percentage : CGFloat = (point.x - 10) / (CGRectGetWidth(self.bounds) - 20);
        
        self.value = valueFromPercentage(percentage)
        
        setNeedsDisplay()
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSizeMake(UIViewNoIntrinsicMetric, 20)
    }
    
    override func drawRect(rect: CGRect) {
        
        let sliderFrame: CGRect = rect //GB ADDED   //CGRect(x: 31, y: 41, width: 132, height: 20)
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let thumbColor = UIColor(red: 0.833, green: 0.833, blue: 0.833, alpha: 1.000)
        let minimumTrackColor = UIColor(red: 0.000, green: 0.000, blue: 1.000, alpha: 1.000)
        let maximumTrackColor = UIColor(red: 0.522, green: 0.522, blue: 0.522, alpha: 1.000)
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.darkGrayColor()
        shadow.shadowOffset = CGSize(width: 0.1, height: -0.1)
        shadow.shadowBlurRadius = 3
        
        
        //// Subframes
        let track: CGRect = CGRect(x: sliderFrame.minX, y: sliderFrame.minY + floor((sliderFrame.height - 4) * 0.50000 + 0.5), width: sliderFrame.width, height: 4)
        let trackFrame = CGRect(x: track.minX + floor(track.width * 0.00000 + 0.5), y: track.minY, width: floor(track.width * 1.00000 + 0.5) - floor(track.width * 0.00000 + 0.5), height: 4)
        
        let percentage : CGFloat = self.percentageValue() // GB ADDED
        
        let thumbRect : CGRect = CGRectMake(CGRectGetMinX(sliderFrame) + floor((CGRectGetWidth(sliderFrame) - 20) * percentage), CGRectGetMinY(sliderFrame) + floor((CGRectGetHeight(sliderFrame) - 20) * 0.50000 + 0.5), 20, 20)
        let minimumTrackRect : CGRect = CGRectMake(CGRectGetMinX(trackFrame), CGRectGetMinY(trackFrame), floor((CGRectGetWidth(trackFrame)) * percentage), 4)
        let maximumTrackRect : CGRect = CGRectMake(CGRectGetMinX(trackFrame) + floor((CGRectGetWidth(trackFrame)) * percentage), CGRectGetMinY(trackFrame), CGRectGetWidth(trackFrame) - floor((CGRectGetWidth(trackFrame)) * percentage), 4)
        
        
        //// Track
        //// Minimum Track Drawing
        let minimumTrackPath = UIBezierPath(roundedRect: minimumTrackRect, byRoundingCorners: [UIRectCorner.TopLeft, UIRectCorner.BottomLeft], cornerRadii: CGSize(width: 2, height: 2))
        minimumTrackPath.closePath()
        minimumTrackColor.setFill()
        minimumTrackPath.fill()
        
        
        //// Maximum Track Drawing
        let maximumTrackPath = UIBezierPath(roundedRect: maximumTrackRect, byRoundingCorners: [UIRectCorner.TopRight, UIRectCorner.BottomRight], cornerRadii: CGSize(width: 2, height: 2))
        maximumTrackPath.closePath()
        maximumTrackColor.setFill()
        maximumTrackPath.fill()
        
        
        
        
        //// Thumb Drawing
        let thumbPath = UIBezierPath(ovalInRect: thumbRect)
        thumbColor.setFill()
        thumbPath.fill()
        
        ////// Thumb Inner Shadow
        CGContextSaveGState(context)
        CGContextClipToRect(context, thumbPath.bounds)
        CGContextSetShadow(context, CGSize.zero, 0)
        CGContextSetAlpha(context, CGColorGetAlpha((shadow.shadowColor as! UIColor).CGColor))
        CGContextBeginTransparencyLayer(context, nil)
        let thumbOpaqueShadow = (shadow.shadowColor as! UIColor).colorWithAlphaComponent(1)
        CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, thumbOpaqueShadow.CGColor)
        CGContextSetBlendMode(context, .SourceOut)
        CGContextBeginTransparencyLayer(context, nil)
        
        thumbOpaqueShadow.setFill()
        thumbPath.fill()
        
        CGContextEndTransparencyLayer(context)
        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)
        
        
    }
}
