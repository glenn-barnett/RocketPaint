//
//  LineAlphaSliderView.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/28/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class LineAlphaVerticalSliderView: SwiftVerticalSliderView {

    var iconColor : UIColor = UIColor.red
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func configure() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(LineAlphaSliderView.colorChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kColorChanged),
            object: nil)
    }
    
    @objc func colorChanged(_ notification:Notification){
        iconColor = notification.userInfo!["color"] as! UIColor
        self.setNeedsDisplay()
    }
    
    
    override func draw(_ rect: CGRect) {
        
        let buffer = CGFloat(20.0);
        let sliderFrame: CGRect = CGRect(
            x: rect.origin.x + buffer,
            y: rect.origin.y,
            width:rect.size.width - buffer * 2,
            height:rect.size.height)
        
        let context = UIGraphicsGetCurrentContext()
        
        //// Subframes
        let track: CGRect = CGRect(x: sliderFrame.minX, y: sliderFrame.minY + floor((sliderFrame.height - 4) * 0.50000 + 0.5), width: sliderFrame.width, height: 4)
        let trackFrame = CGRect(x: track.minX + floor(track.width * 0.00000 + 0.5), y: track.minY, width: floor(track.width * 1.00000 + 0.5) - floor(track.width * 0.00000 + 0.5), height: 4)

        
        //// AlphaGradient Drawing
//        let alphaGradientRect = CGRect(x: trackFrame.minX, y: trackFrame.minY - 18, width: trackFrame.width, height: trackFrame.height + 36)
//        let alphaGradientPath = UIBezierPath(rect: alphaGradientRect)
//        CGContextSaveGState(context)
//        alphaGradientPath.addClip()
//        CGContextDrawLinearGradient(context, gradient,
//                                    CGPoint(x: alphaGradientRect.minX, y: alphaGradientRect.midY),
//                                    CGPoint(x: alphaGradientRect.maxX, y: alphaGradientRect.midY),
//                                    CGGradientDrawingOptions())
//        CGContextRestoreGState(context)
        
        // GB ADDED BEGIN
        let percentage : CGFloat = self.percentageValue()
        
        let minimumTrackRect : CGRect = CGRect(x: trackFrame.minX, y: trackFrame.minY, width: floor((trackFrame.width) * percentage), height: 4)
        let maximumTrackRect : CGRect = CGRect(x: trackFrame.minX + floor((trackFrame.width) * percentage), y: trackFrame.minY, width: trackFrame.width - floor((trackFrame.width) * percentage), height: 4)
        // GB ADDED endTrackingWithTouch
        
        let checkColor = UIColor.black.withAlphaComponent(0.2)
        checkColor.setFill()
        
        let checkSize = CGFloat(8)
        var x = CGFloat(20)
        while(x < trackFrame.maxX - checkSize) {

            UIRectFill(CGRect(x: CGFloat(x), y: trackFrame.minY - checkSize, width: checkSize, height: checkSize))
            x += checkSize
            UIRectFill(CGRect(x: CGFloat(x), y: trackFrame.minY - checkSize*2, width: checkSize, height: checkSize))
            x += checkSize
        }
        

        
        //// Track
        //// Minimum Track Drawing
        let minimumTrackPath = UIBezierPath(roundedRect: minimumTrackRect, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 2, height: 2))
        minimumTrackPath.close()
        UIColor.black.setFill()
        minimumTrackPath.fill()

        
        
        //// Maximum Track Drawing
        let maximumTrackPath = UIBezierPath(roundedRect: maximumTrackRect, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 2, height: 2))
        maximumTrackPath.close()
        UIColor.black.setFill()
        maximumTrackPath.fill()
        
        
        
        
        //// Thumb Drawing
        context!.saveGState()
//        CGContextTranslateCTM(context, sliderFrame.maxX - 104.7, sliderFrame.maxY - 10)
//        CGContextScaleCTM(context, lineWidthSliderScale, lineWidthSliderScale)
        
        //let thumbPath = UIBezierPath(ovalInRect: thumbRect)
        let thumbPath = UIBezierPath(
            arcCenter: CGPoint(
                x: sliderFrame.minX + floor((sliderFrame.width - 20) * percentage),
//                y: CGRectGetMinY(sliderFrame) + floor((CGRectGetHeight(sliderFrame) - 20) * 0.50000 + 0.5)
                y: sliderFrame.height / 2
                ),
            radius: 20,
            startAngle: 0,
            endAngle: CGFloat(Double.pi),
            clockwise: true)
        
        iconColor.withAlphaComponent(1.0).setFill()
        thumbPath.fill()
//        UIColor.grayColor().setStroke() //TODO gray stroke ok?
//        CGContextSetLineWidth(context, 20)
//        thumbPath.stroke()

        let thumbPath2 = UIBezierPath(
            arcCenter: CGPoint(
                x: sliderFrame.minX + floor((sliderFrame.width - 20) * percentage),
                //                y: CGRectGetMinY(sliderFrame) + floor((CGRectGetHeight(sliderFrame) - 20) * 0.50000 + 0.5)
                y: sliderFrame.height / 2
            ),
            radius: 20,
            startAngle: CGFloat(Double.pi),
            endAngle: CGFloat(Double.pi*2),
            clockwise: true)
        iconColor.withAlphaComponent(percentage).setFill()
        thumbPath2.fill()
        

        context!.restoreGState()
        
    }
}
