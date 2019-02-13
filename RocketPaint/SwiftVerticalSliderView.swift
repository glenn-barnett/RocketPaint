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
class SwiftVerticalSliderView: SwiftSliderView {
    
    override func moveThumbToPoint(_ point: CGPoint) {
        let percentage : CGFloat = (point.y - 10) / (self.bounds.height - 25);
        
        self.value = valueFromPercentage(percentage)
        
        setNeedsDisplay()
    }
    
    override var intrinsicContentSize : CGSize {
        return CGSize(width: 20, height: UIView.noIntrinsicMetric) // fixed width
    }
    
    override func draw(_ rect: CGRect) {
        
        let sliderFrame: CGRect = rect //GB ADDED   //CGRect(x: 31, y: 41, width: 132, height: 20)

        let percentage : CGFloat = self.percentageValue() // GB ADDED

        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Color Declarations
        let thumbColor = UIColor(red: 0.833, green: 0.833, blue: 0.833, alpha: 1.000)
        let minimumTrackColor = UIColor(red: 0.000, green: 0.000, blue: 1.000, alpha: 1.000)
        let maximumTrackColor = UIColor(red: 0.522, green: 0.522, blue: 0.522, alpha: 1.000)
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.darkGray
        shadow.shadowOffset = CGSize(width: 0.1, height: -0.1)
        shadow.shadowBlurRadius = 3
        
        
        //// Subframes
        let track: CGRect = CGRect(x: sliderFrame.minX, y: sliderFrame.minY + floor((sliderFrame.height - 4) * 0.50000 + 0.5), width: sliderFrame.width, height: 4)
        let trackFrame = CGRect(x: track.minX + floor(track.width * 0.00000 + 0.5), y: track.minY, width: floor(track.width * 1.00000 + 0.5) - floor(track.width * 0.00000 + 0.5), height: 4)
        
        
        let thumbRect : CGRect = CGRect(x: sliderFrame.minX + floor((sliderFrame.width - 20) * percentage), y: sliderFrame.minY + floor((sliderFrame.height - 20) * 0.50000 + 0.5), width: 20, height: 20)
        let minimumTrackRect : CGRect = CGRect(x: trackFrame.minX, y: trackFrame.minY, width: floor((trackFrame.width) * percentage), height: 4)
        let maximumTrackRect : CGRect = CGRect(x: trackFrame.minX + floor((trackFrame.width) * percentage), y: trackFrame.minY, width: trackFrame.width - floor((trackFrame.width) * percentage), height: 4)
        
        
        //// Track
        //// Minimum Track Drawing
        let minimumTrackPath = UIBezierPath(roundedRect: minimumTrackRect, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft], cornerRadii: CGSize(width: 2, height: 2))
        minimumTrackPath.close()
        minimumTrackColor.setFill()
        minimumTrackPath.fill()
        
        
        //// Maximum Track Drawing
        let maximumTrackPath = UIBezierPath(roundedRect: maximumTrackRect, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: 2, height: 2))
        maximumTrackPath.close()
        maximumTrackColor.setFill()
        maximumTrackPath.fill()
        
        
        
        
        //// Thumb Drawing
        let thumbPath = UIBezierPath(ovalIn: thumbRect)
        thumbColor.setFill()
        thumbPath.fill()
        
        ////// Thumb Inner Shadow
        context.saveGState()
        context.clip(to: thumbPath.bounds)
        context.setShadow(offset: CGSize.zero, blur: 0)
        context.setAlpha((shadow.shadowColor as! UIColor).cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let thumbOpaqueShadow = (shadow.shadowColor as! UIColor).withAlphaComponent(1)
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: thumbOpaqueShadow.cgColor)
        context.setBlendMode(.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        thumbOpaqueShadow.setFill()
        thumbPath.fill()
        
        context.endTransparencyLayer()
        context.endTransparencyLayer()
        context.restoreGState()
        
        
    }
}
