//
//  EasterEggViewController.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 9/20/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit
import ACEDrawingView
import CoreGraphics


let kMaxTime = 10000

class EasterEggDrawingView : UIView {

    var timer = Timer()
    var time = kMaxTime
    let image = UIImage()
    
    var minHue:CGFloat = 0.0
    var maxHue:CGFloat = 0.0
    
    func stop() {
        timer.invalidate()
        time = kMaxTime
    }
    
    func running() -> Bool {
        return timer.isValid
    }
    
    func start() {
//        self.backgroundColor = UIColor.greenColor()
        self.clearsContextBeforeDrawing = false
        
        if(timer.isValid) {
            return // already running   
        }
        
        minHue = Math.randomFractional() * 0.7
        maxHue = minHue + 0.2 + 0.6 * Math.randomFractional()
        if(maxHue > 1.0) { maxHue = maxHue - 1.0; }
        
        timer = Timer.scheduledTimer( timeInterval: 1/60,
                                                        target: self,
                                                        selector: #selector(EasterEggDrawingView.tick),
                                                        userInfo: nil,
                                                        repeats: true)

        // 1. initialize buffer image to color

        let rect = CGRect(x:0, y:0, width:768, height:1024)
        let size = CGSize(width: 768, height: 1024)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        UIColor.white.setFill()
        UIRectFill(rect)
        //self.buffer.drawInRect(rect)
        
        self.buffer = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        
        // 2. set as layer
        self.layer.contents = self.buffer!.cgImage
        
    }

    
    fileprivate var buffer: UIImage?
    
//    var context: CGContextRef {
//        return UIGraphicsGetCurrentContext()!
//    }
    
    
    func tick() {
        time = time - 1;
        if time == 0 { timer.invalidate() }
        
//        print("tick(\(time))")

        // 3. write line to buffer image

        let size = self.bounds.size
        
        // Initialize a full size image. Opaque because we don't need to draw over anything. Will be more performant.
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        if let buffer = buffer {
            buffer.draw(in: self.bounds)
        }
        
        // set the line properties
        let hueMod = Math.randomFractional()
        let hue = minHue + (maxHue - minHue * hueMod)
        let lineColor = UIColor(hue:hue, saturation: 1.0, brightness: 1.0, alpha: 0.015)
        context!.setStrokeColor(lineColor.cgColor);
        context!.setLineCap(.round);
        context!.setLineWidth(25.0);
        
        
        let x1:CGFloat = -100.0
        let y1:CGFloat = -100 + CGFloat(hueMod) * 1224.0
        let x2:CGFloat = 868.0
        let y2:CGFloat = y1 + -200.0 + Math.randomFractional() * 400.0

        /* OLD
        let hueMod = 200
        let hue = CGFloat(time % hueMod) / CGFloat(hueMod)
        let lineColor = UIColor(hue:hue, saturation: 1.0, brightness: 1.0, alpha: 0.015)
        CGContextSetStrokeColorWithColor(context!, lineColor.CGColor);
        CGContextSetLineCap(context!, .Round);
        CGContextSetLineWidth(context!, 25.0);
        
        
        let x1:CGFloat = -100.0
        let y1:CGFloat = CGFloat(hue) * CGFloat(hueMod) * 7.0 + -CGFloat(hueMod) + Math.randomFractional() * 400.0
        let x2:CGFloat = 868.0
        let y2:CGFloat = y1 + -200.0 + Math.randomFractional() * 400.0
        */
        
        // draw the line
        context!.move(to: CGPoint(x: x1, y: y1));
        context!.addLine(to: CGPoint(x: x2, y: y2));
        context!.strokePath();
        autoreleasepool {
            self.buffer = UIGraphicsGetImageFromCurrentImageContext() // HUGE LEAK HERE NEEDS AUTORELEASE
        }
        UIGraphicsEndImageContext()

        
        // 4. call setneedsdisplay
        
        self.layer.contents = self.buffer!.cgImage
        self.setNeedsDisplay()
        
    }
    
/*
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        autoreleasepool {
            self.buffer = drawInContext(context)
            
            //self.layer.contents = self.buffer?.CGImage ?? nil

            if(self.buffer == nil) {
                print("OMG BUFFER is nil SHOULDNT happen")
                self.layer.contents = nil
            } else {
                self.layer.contents = self.buffer!.CGImage
            }
            
        }

    }
    
    
    private func drawInContext(context: CGContextRef) -> UIImage {
        let size = self.bounds.size
        
        
        // Initialize a full size image. Opaque because we don't need to draw over anything. Will be more performant.
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextFillRect(context, self.bounds)
        
        // Draw previous buffer first
        if let buffer = buffer {
            
            buffer.drawInRect(self.bounds)
            
        }

        // set the line properties
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor);
        CGContextSetLineCap(context, .Round);
        CGContextSetLineWidth(context, 25.0);
        CGContextSetAlpha(context, 0.2);
        
        let x1:CGFloat = -100.0
        let y1:CGFloat = -size.height/2 + Math.randomFractional() * size.height
        let x2:CGFloat = 868.0
        let y2:CGFloat = y1 + -200.0 + Math.randomFractional() * 400.0
        
        //            print("line: \(x1),\(y1)  -> \(x2),\(y2)")
        
        // draw the line
        CGContextMoveToPoint(context, x1, y1);
        CGContextAddLineToPoint(context, x2, y2);
        CGContextStrokePath(context);
        

        // Grab updated buffer and return it
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
 
 */
    
    /*
        //        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0);
        //        //self.accumulatedImage.drawAtPoint(CGPointZero)
        //        self.accumulatedImage = UIGraphicsGetImageFromCurrentImageContext();
        //        UIGraphicsEndImageContext();
        
        // from MY composeImageOnCanvasColor
        var canvasColor:UIColor
        
        switch(time % 4) {
        case 1:
            canvasColor = UIColor.orangeColor()
            break
        case 2:
            canvasColor = UIColor.greenColor()
            break
        case 3:
            canvasColor = UIColor.yellowColor()
            break
        default:
            canvasColor = UIColor.greenColor()
            break
        }
        
        let rect = CGRect(x:0, y:0, width:768, height:1024)
        let size = CGSize(width: 768, height: 1024)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        canvasColor.setFill()
        UIRectFill(rect)
        self.image.drawInRect(rect)
        
        let kLineWidth:CGFloat = 25.0
        let kLineAlpha:CGFloat = 0.2
        
        let context = UIGraphicsGetCurrentContext();
        
        // set the line properties
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor);
        CGContextSetLineCap(context, .Round);
        CGContextSetLineWidth(context, kLineWidth);
        CGContextSetAlpha(context, kLineAlpha);
        
        let x1:CGFloat = -100.0
        let y1:CGFloat = -500.0 + Math.randomFractional() * 1800.0
        let x2:CGFloat = 868.0
        let y2:CGFloat = y1 + -300.0 + Math.randomFractional() * 600.0
        
        print("line: \(x1),\(y1)  -> \(x2),\(y2)")
        
        // draw the line
        CGContextMoveToPoint(context, x1, y1);
        CGContextAddLineToPoint(context, x2, y2);
        CGContextStrokePath(context);
        
        
        
        let composedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.layer.contents = self.buffer?.CGImage ?? nil
//        self.setNeedsDisplay()
    }
    
    */
    
}

