//
//  DrawingService
//  RocketPaint
//
//  Created by Glenn Barnett on 7/2/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

open class DrawingService {
    static let SharedInstance = DrawingService()
    fileprivate let _userDefaults = UserDefaults.standard
    
    static let kDefaultLineWidth = 6.0;
    
    var isModified = false
    var isSaved = false
    
    var drawingViews : [RocketDrawingView] = [];
    
    var lastBrushName : String? = nil;
    
    func initNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(DrawingService.brushChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kBrushChanged),
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(DrawingService.photoSaved(_:)),
            name: NSNotification.Name(rawValue: Notifications.kPhotoSaved),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(DrawingService.canvasCleared(_:)),
            name: NSNotification.Name(rawValue: Notifications.kCanvasCleared),
            object: nil)
        
        
    }

    @objc func brushChanged(_ notification:Notification){
        lastBrushName = notification.userInfo!["brush"] as? String
        drawingViews[0].commitAndDiscardToolStack()
    }
    @objc func photoSaved(_ notification:Notification){
        isModified = false
        isSaved = true
        drawingViews[0].commitAndDiscardToolStack()
    }
    @objc func canvasCleared(_ notification:Notification){
        isModified = false
        isSaved = false
        drawingViews[0].commitAndDiscardToolStack()
    }

    func addDrawingView(_ drawingView : RocketDrawingView) {
        drawingViews.append(drawingView)
    }
    
    func loadImage0(_ image : UIImage) {
        isModified = false
        isSaved = false
        drawingViews[0].commitAndDiscardToolStack()
        drawingViews[0].drawMode = .scale;
        drawingViews[0].loadImage(image);
    }
    
    func getImage() -> UIImage {
        return drawingViews[0].image;
    }

    func getLayerZeroImage() -> UIImage {
        return drawingViews[0].image;
    }

    func getImageOnCanvasColor() -> UIImage {
        // TODO - trap this image and check if null or ...?
        
        if(drawingViews[0].image == nil) {
            return composeCanvasColorOnly()
        }
        
        return composeImageOnCanvasColor(getImage())
    }

    func composeCanvasColorOnly() -> UIImage {
        let canvasColor = ColorService.SharedInstance.canvasColor
        
        let rect = CGRect(x:0, y:0, width:768, height:1024)
        let size = CGSize(width: 768, height: 1024)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        canvasColor.setFill()
        UIRectFill(rect)
        
        let composedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return composedImage
        
    }
    
    func composeImageOnCanvasColor(_ image : UIImage) -> UIImage {
        
        let canvasColor = ColorService.SharedInstance.canvasColor
        
        let rect = CGRect(x:0, y:0, width:768, height:1024)
        let size = CGSize(width: 768, height: 1024)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        canvasColor.setFill()
        UIRectFill(rect)
        image.draw(in: rect)
        
        let composedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return composedImage
    }

    
    func persistState() {
                
        _userDefaults.removeObject(forKey: "brushName")
        _userDefaults.set(lastBrushName, forKey: "brushName")
        
        _userDefaults.removeObject(forKey: "brushColor")
        _userDefaults.setColor(ColorService.SharedInstance.selectedColor, forKey: "brushColor")

        _userDefaults.removeObject(forKey: "lineWidth")
        _userDefaults.set(Float(drawingViews[0].lineWidth), forKey: "lineWidth")

        _userDefaults.removeObject(forKey: "lineAlpha")
        _userDefaults.set(Float(drawingViews[0].lineAlpha), forKey: "lineAlpha")

//        if(isModified) {
            _userDefaults.removeObject(forKey: "image")
            _userDefaults.setImage(getImageOnCanvasColor(), forKey: "image")
//        }
        _userDefaults.synchronize()
        
    }
    
    func restoreState() {
        if let brushName = UserDefaults.standard.object(forKey: "brushName") as? String {
            lastBrushName = brushName // TODO redundant?
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: Notifications.kBrushChanged),
                object: nil,
                userInfo: ["brush": brushName])
        }

        if let brushColor = UserDefaults.standard.colorForKey("brushColor") {
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: Notifications.kColorChanged),
                object: nil,
                userInfo: ["color": brushColor])
        }

        if let lineWidth = UserDefaults.standard.object(forKey: "lineWidth") as? Float {
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: Notifications.kLineWidthChanged),
                object: nil,
                userInfo: ["lineWidth": lineWidth])
        }

        if let lineAlpha = UserDefaults.standard.object(forKey: "lineAlpha") as? Float {
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: Notifications.kLineAlphaChanged),
                object: nil,
                userInfo: ["lineAlpha": max(0.05, lineAlpha)]) // GB bump up to min of 5% in case they get confused
        }

        if let image = UserDefaults.standard.imageForKey("image") {
            // load image
            loadImage0(image)
        }
        
//        _userDefaults.removePersistentDomainForName(NSBundle.mainBundle().bundleIdentifier!)

    }
    
    func resetBrush() {

        lastBrushName = "pen" // TODO redundant?
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kBrushChanged),
            object: nil,
            userInfo: ["brush": "Pen"])
        
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kColorChanged),
            object: nil,
            userInfo: ["color": ColorService.SharedInstance.defaultPaintColor()])
        
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kLineWidthChanged),
            object: nil,
            userInfo: ["lineWidth": DrawingService.kDefaultLineWidth])
/*
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kLineAlphaChanged,
            object: nil,
            userInfo: ["lineAlpha":0.7])
*/
    }
    
}

