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

        let lineWidth = CGFloat(2.0)

        let buffer = CGFloat(20.0);
        let sliderFrame: CGRect = CGRect(
            x: rect.origin.x,
            y: rect.origin.y + buffer,
            width:rect.size.width,
            height:rect.size.height - buffer * 2)

        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        // This non-generic function dramatically improves compilation times of complex expressions.
        func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }

        //// Color Declarations
        let maximumTrackColor = UIColor(red: 0.522, green: 0.522, blue: 0.522, alpha: 1.000)
        
        //// Variable Declarations
        let lineWidthSliderScale: CGFloat = (6 + lineWidth * 3) / 20.0
        
        //// Subframes
        let track: CGRect = CGRect(x: sliderFrame.minX, y: sliderFrame.minY + fastFloor((sliderFrame.height - 351) * 0.00000 + 0.5), width: sliderFrame.width + 9, height: 351)
        let trackFrame = CGRect(x: track.minX + fastFloor(track.width * 0.00000 + 0.5), y: track.minY, width: fastFloor(track.width * 1.00000 + 0.5) - fastFloor(track.width * 0.00000 + 0.5), height: 350)

//GB UNTOUCHED DEBRIS BEGIN
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
        
//GB UNTOUCHED DEBRIS END

        
        //// Track
        //// Minimum Track Drawing
        let minimumTrackPath = UIBezierPath(roundedRect: CGRect(x: trackFrame.minX + 9, y: trackFrame.minY + trackFrame.height - 249, width: fastFloor((trackFrame.width - 9) * 0.25000 + 0.5), height: 250), byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: 2, height: 2))
        minimumTrackPath.close()
        iconColor.setFill()
        minimumTrackPath.fill()

        
        //// Maximum Track Drawing
        let maximumTrackPath = UIBezierPath(roundedRect: CGRect(x: trackFrame.minX + fastFloor((trackFrame.width - 12) * 0.69231 + 0.5), y: trackFrame.minY + trackFrame.height - 341, width: trackFrame.width - 12 - fastFloor((trackFrame.width - 12) * 0.69231 + 0.5), height: 88), byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 2, height: 2))
        maximumTrackPath.close()
        maximumTrackColor.setFill()
        maximumTrackPath.fill()
        
        
        
        //// Thumb Drawing
        //// Thumb Drawing
        context.saveGState()
//GB NEW BUT COMMENTED BEGIN
//        context.translateBy(x: 31.3, y: 113)
//        context.scaleBy(x: lineWidthSliderScale, y: lineWidthSliderScale)
//GB NEW BUT COMMENTED END

//        CGContextTranslateCTM(context, sliderFrame.maxX - 104.7, sliderFrame.maxY - 10)
//        CGContextScaleCTM(context, lineWidthSliderScale, lineWidthSliderScale)
        
        //let thumbPath = UIBezierPath(ovalInRect: thumbRect)
        let thumbPath = UIBezierPath(
            arcCenter: CGPoint(
                x: sliderFrame.width / 2,
//                y: CGRectGetMinY(sliderFrame) + floor((CGRectGetHeight(sliderFrame) - 20) * 0.50000 + 0.5)
                y: sliderFrame.minY + floor((sliderFrame.height - 20) * percentage)
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
                x: sliderFrame.width / 2,
                //                y: CGRectGetMinY(sliderFrame) + floor((CGRectGetHeight(sliderFrame) - 20) * 0.50000 + 0.5)
                y: sliderFrame.minY + floor((sliderFrame.height - 20) * percentage)
            ),
            radius: 20,
            startAngle: CGFloat(Double.pi),
            endAngle: CGFloat(Double.pi*2),
            clockwise: true)
        iconColor.withAlphaComponent(percentage).setFill()
        thumbPath2.fill()
        

        context.restoreGState()
    }
}
