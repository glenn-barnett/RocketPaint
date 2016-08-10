//
//  DrawingService
//  RocketPaint
//
//  Created by Glenn Barnett on 7/2/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

public class DrawingService {
    static let SharedInstance = DrawingService()
    private let _userDefaults = NSUserDefaults.standardUserDefaults()
    
    static let kDefaultLineWidth = 6.0;
    
    var isModified = false
    
    var drawingViews : [RocketDrawingView] = [];
    
    var lastBrushName : String? = nil;
    
    func initNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(DrawingService.brushChanged(_:)),
            name: Notifications.kBrushChanged,
            object: nil)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(DrawingService.photoSaved(_:)),
            name: Notifications.kPhotoSaved,
            object: nil)

    }
    @objc func photoSaved(notification:NSNotification){
        isModified = false
    }
    @objc func brushChanged(notification:NSNotification){
        lastBrushName = notification.userInfo!["brush"] as? String
    }
   
    func addDrawingView(drawingView : RocketDrawingView) {
        drawingViews.append(drawingView)
    }
    
    func loadImage0(image : UIImage) {
        drawingViews[0].drawMode = .Scale;
        drawingViews[0].loadImage(image);
    }
    
    func getImage() -> UIImage {
        return drawingViews[0].image;
    }
    
    func getImageOnCanvasColor() -> UIImage {
        return composeImageOnCanvasColor(getImage())
    }

    func composeImageOnCanvasColor(image : UIImage) -> UIImage {
        
        let canvasColor = ColorService.SharedInstance.canvasColor
        
        let rect = CGRect(x:0, y:0, width:768, height:1024)
        let size = CGSize(width: 768, height: 1024)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        canvasColor.setFill()
        UIRectFill(rect)
        image.drawInRect(rect)
        
        let composedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return composedImage
    }

    
    func persistState() {
                
        _userDefaults.removeObjectForKey("brushName")
        _userDefaults.setObject(lastBrushName, forKey: "brushName")
        
        _userDefaults.removeObjectForKey("brushColor")
        _userDefaults.setColor(ColorService.SharedInstance.selectedColor, forKey: "brushColor")

        _userDefaults.removeObjectForKey("lineWidth")
        _userDefaults.setObject(drawingViews[0].lineWidth, forKey: "lineWidth")

        _userDefaults.removeObjectForKey("lineAlpha")
        _userDefaults.setObject(drawingViews[0].lineAlpha, forKey: "lineAlpha")

        if(isModified) {
            _userDefaults.removeObjectForKey("image")
            _userDefaults.setImage(getImageOnCanvasColor(), forKey: "image")
        }
        _userDefaults.synchronize()
        
    }
    
    func restoreState() {
        if let brushName = NSUserDefaults.standardUserDefaults().objectForKey("brushName") as? String {
            lastBrushName = brushName // TODO redundant?
            NSNotificationCenter.defaultCenter().postNotificationName(
                Notifications.kBrushChanged,
                object: nil,
                userInfo: ["brush": brushName])
        }

        if let brushColor = NSUserDefaults.standardUserDefaults().colorForKey("brushColor") {
            NSNotificationCenter.defaultCenter().postNotificationName(
                Notifications.kColorChanged,
                object: nil,
                userInfo: ["color": brushColor])
        }

        if let lineWidth = NSUserDefaults.standardUserDefaults().objectForKey("lineWidth") as? CGFloat {
            NSNotificationCenter.defaultCenter().postNotificationName(
                Notifications.kLineWidthChanged,
                object: nil,
                userInfo: ["lineWidth": lineWidth])
        }

        if let lineAlpha = NSUserDefaults.standardUserDefaults().objectForKey("lineAlpha") as? CGFloat {
            NSNotificationCenter.defaultCenter().postNotificationName(
                Notifications.kLineAlphaChanged,
                object: nil,
                userInfo: ["lineAlpha": max(0.05, lineAlpha)]) // GB bump up to min of 5% in case they get confused
        }

        if let image = NSUserDefaults.standardUserDefaults().imageForKey("image") {
            // load image
            loadImage0(image)
        }
        
//        _userDefaults.removePersistentDomainForName(NSBundle.mainBundle().bundleIdentifier!)

    }
    
    func resetBrush() {

        lastBrushName = "pen" // TODO redundant?
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Pen"])
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kColorChanged,
            object: nil,
            userInfo: ["color": ColorService.SharedInstance.defaultPaintColor()])
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kLineWidthChanged,
            object: nil,
            userInfo: ["lineWidth": DrawingService.kDefaultLineWidth])
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kLineAlphaChanged,
            object: nil,
            userInfo: ["lineAlpha":1.0])
    }
    
}

