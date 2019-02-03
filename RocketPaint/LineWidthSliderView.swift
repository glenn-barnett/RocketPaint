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
    
    var iconColor : UIColor = UIColor.red
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(LineWidthSliderView.colorChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kColorChanged),
            object: nil)
    }
    
    @objc func colorChanged(_ notification:Notification){
        iconColor = notification.userInfo!["color"] as! UIColor
        self.setNeedsDisplay()
    }
    
    func percentageValue() -> CGFloat {
        if (self.maximumValue == self.minimumValue) {
            return 0.5
        }
        
        return (self.value - self.minimumValue) / (self.maximumValue - self.minimumValue)
    }
    
    func valueFromPercentage(_ percentage: CGFloat) -> CGFloat {
        return percentage * (self.maximumValue - self.minimumValue) + self.minimumValue
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        
        let lastPoint : CGPoint = touch.location(in: self)
        moveThumbToPoint(lastPoint)
        sendActions(for: .valueChanged)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
    }
    
    func moveThumbToPoint(_ point: CGPoint) {
        let percentage : CGFloat = min(1, max(0, (point.x - 10) / (self.bounds.width - 20)));
        
        self.value = valueFromPercentage(percentage)
        setNeedsDisplay()
    }
    
    override var intrinsicContentSize : CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 20)
    }
    
    override func draw(_ rect: CGRect) {
        
        let lineWidth = CGFloat(2.0)
        
        let buffer = CGFloat(20.0);
        let sliderFrame: CGRect = CGRect(
            x: rect.origin.x + buffer,
            y: rect.origin.y,
            width:rect.size.width - buffer * 2,
            height:rect.size.height)
        
        let minRadius = CGFloat(2)
        let maxRadius = CGFloat(30)
        
        let context = UIGraphicsGetCurrentContext()!
        
        //// Color Declarations
        let maximumTrackColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.000)
        
        
        //// Subframes
        let track: CGRect = CGRect(x: sliderFrame.minX, y: sliderFrame.minY + floor((sliderFrame.height - 4) * 0.50000 + 0.5), width: sliderFrame.width, height: 4)
        let trackFrame = CGRect(x: track.minX + floor(track.width * 0.00000 + 0.5), y: track.minY, width: floor(track.width * 1.00000 + 0.5) - floor(track.width * 0.00000 + 0.5), height: 4)
        
        // GB ADDED BEGIN
        let percentage : CGFloat = self.percentageValue()
        
        let minimumTrackRect : CGRect = CGRect(x: trackFrame.minX, y: trackFrame.minY, width: floor((trackFrame.width) * percentage), height: 4)
        let maximumTrackRect : CGRect = CGRect(x: trackFrame.minX + floor((trackFrame.width) * percentage), y: trackFrame.minY, width: trackFrame.width - floor((trackFrame.width) * percentage), height: 4)
        // GB ADDED endTrackingWithTouch
        

//        let crescendoPath = UIBezierPath()
//        crescendoPath.moveToPoint(CGPoint(x: CGRectGetMinX(trackFrame), y: CGRectGetMinY(trackFrame) - (minRadius - 2)))
//        crescendoPath.addLineToPoint(CGPoint(x: CGRectGetMaxX(trackFrame), y: CGRectGetMinY(trackFrame) - maxRadius))
//        crescendoPath.addLineToPoint(CGPoint(x: CGRectGetMaxX(trackFrame), y: CGRectGetMaxY(trackFrame) + maxRadius))
//        crescendoPath.addLineToPoint(CGPoint(x: CGRectGetMinX(trackFrame), y: CGRectGetMaxY(trackFrame) + (minRadius - 2)))
//        crescendoPath.closePath()
//        iconColor.colorWithAlphaComponent(0.3).setStroke()
//        crescendoPath.lineWidth = 1
//        crescendoPath.stroke()
        
        //// Track
        //// Minimum Track Drawing
        let minimumTrackPath = UIBezierPath(roundedRect: minimumTrackRect, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 2, height: 2))
        minimumTrackPath.close()
        iconColor.withAlphaComponent(1.0).setFill()
        minimumTrackPath.fill()
        
        
        //// Maximum Track Drawing
        let maximumTrackPath = UIBezierPath(roundedRect: maximumTrackRect, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 2, height: 2))
        maximumTrackPath.close()
        maximumTrackColor.setFill()
        maximumTrackPath.fill()
        
        
        
        
        //// Thumb Drawing
        context.saveGState()
//        CGContextTranslateCTM(context, sliderFrame.maxX - 104.7, sliderFrame.maxY - 10)
//        CGContextScaleCTM(context, lineWidthSliderScale, lineWidthSliderScale)
        
        // scaled thumb half
        let thumbPath1 = UIBezierPath(
            arcCenter: CGPoint(
                x: sliderFrame.minX + floor((sliderFrame.width - 20) * percentage),
//                y: CGRectGetMinY(sliderFrame) + floor((CGRectGetHeight(sliderFrame) - 20) * 0.50000 + 0.5)
                y: sliderFrame.height / 2
                ),
            radius: minRadius + percentageValue() * (maxRadius - minRadius),
            startAngle: 0,
            endAngle: CGFloat(M_PI * 2),
            clockwise: true)
        
        iconColor.withAlphaComponent(1.0).setFill()
        thumbPath1.fill()

        let thumbRect = UIBezierPath(rect: CGRect(
            x: sliderFrame.minX + floor((sliderFrame.width - 20) * percentage) - 1,
            y: sliderFrame.height / 2 - 15,
            width: 2,
            height: 30
            ))
        
        thumbRect.fill()

//        UIColor.grayColor().setStroke() //TODO gray stroke ok?
//        thumbPath1.stroke()
        
        context.restoreGState()
        
    }
}
