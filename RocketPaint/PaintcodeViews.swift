//
//  SaveBView.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class SavePlusOverlay: UIView {
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawSavePlus();
    }
}

@IBDesignable
class CanvasClearOverlay:UIView {
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawClearX();
    }
}

@IBDesignable
class GradientFadeView:UIView {
    override func draw(_ rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Color Declarations
        let gradient2Color = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.401)
        let gradient2Color2 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.257)
        
        //// Gradient Declarations
        let gradient2 = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [gradient2Color2.cgColor, gradient2Color.cgColor] as CFArray, locations: [0, 1])!
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        context.saveGState()
        rectanglePath.addClip()
        context.drawLinearGradient(gradient2, start: CGPoint(x: 0, y: self.frame.size.height), end: CGPoint(x: 0, y: 0), options: CGGradientDrawingOptions())
        context.restoreGState()
    }
}

