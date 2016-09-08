//
//  RightSideViewController.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/7/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit
import RESideMenu

class RightSideViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var ColorPaletteView : UIView!

    @IBOutlet weak var sliderLineWidth: LineWidthSliderView!
    
    @IBOutlet weak var sliderLineAlpha: LineAlphaSliderView!

    @IBOutlet weak var clearCanvasBView: ClearCanvasBView!

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(RightSideViewController.lineWidthChanged(_:)),
            name: Notifications.kLineWidthChanged,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(RightSideViewController.lineAlphaChanged(_:)),
            name: Notifications.kLineAlphaChanged,
            object: nil)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(RightSideViewController.colorChanged(_:)),
            name: Notifications.kColorChanged,
            object: nil)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(RightSideViewController.menuOpened(_:)),
            name: Notifications.kRightMenuOpened,
            object: nil)

    }

    
    @IBAction func lineWidthAdjusted(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kLineWidthChanged,
            object: nil,
            userInfo: ["lineWidth": (sender as! LineWidthSliderView).value])
    }
    
    @IBAction func lineAlphaAdjusted(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kLineAlphaChanged,
            object: nil,
            userInfo: ["lineAlpha": (sender as! LineAlphaSliderView).value])
    }

    func lineWidthChanged(notification:NSNotification){
        let lineWidth = notification.userInfo!["lineWidth"] as! Float
        sliderLineWidth.value = CGFloat(lineWidth)
    }
    
    func lineAlphaChanged(notification:NSNotification){
        let lineAlpha = notification.userInfo!["lineAlpha"] as! Float
        sliderLineAlpha.value = CGFloat(lineAlpha)
    }

    func colorChanged(notification:NSNotification){
        let selectedColor : UIColor = notification.userInfo!["color"] as! UIColor

        clearCanvasBView.iconColor = selectedColor
        clearCanvasBView.setNeedsDisplay()

//        var hue: CGFloat = 0
//        var saturation: CGFloat = 0
//        var brightness: CGFloat = 0
//        var alpha: CGFloat = 0
//        selectedColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    }

    func menuOpened(notification:NSNotification){
        clearCanvasBView.iconColor = UIColor.whiteColor()
        clearCanvasBView.setNeedsDisplay()
    }
    
    @IBAction func pickedPen(sender : AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Pen"])
    }
    @IBAction func pickedLine(sender : AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Line"])
    }
    @IBAction func pickedRectSolid(sender : AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "RectSolid"])
    }
    @IBAction func pickedRectOutline(sender : AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "RectOutline"])
    }
    @IBAction func pickedEllipseSolid(sender : AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "EllipseSolid"])
    }
    @IBAction func pickedEllipseOutline(sender : AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "EllipseOutline"])
    }
    @IBAction func pickedTextSerif(sender : AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "TextSerif"])
    }
    @IBAction func pickedTextSans(sender : AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "TextSans"])
    }

    @IBAction func clearTapped(sender : AnyObject) {
        
        
        let alertTitle = "Clear your canvas?"
        
        let alertMessage = "To erase your work, choose \"Erase\".\nTo keep your work, choose \"Cancel\""
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let destructiveAction = UIAlertAction(title: "Erase", style: .Destructive) { (action) in
            
            let clearColor = self.clearCanvasBView.iconColor.colorWithAlphaComponent(1.0)
            
            NSNotificationCenter.defaultCenter().postNotificationName(
                Notifications.kCanvasCleared,
                object: nil,
                userInfo: ["color": clearColor])
            
            // second, extract the selected color into components
            var srcHue: CGFloat = 0
            var srcSaturation: CGFloat = 0
            var srcBrightness: CGFloat = 0
            var srcAlpha: CGFloat = 0
            clearColor.getHue(&srcHue, saturation: &srcSaturation, brightness: &srcBrightness, alpha: &srcAlpha)

            if(!(srcBrightness > 0.98 && srcSaturation < 0.02)) {
                NSNotificationCenter.defaultCenter().postNotificationName(
                    Notifications.kColorChanged,
                    object: nil,
                    userInfo: ["color": UIColor.whiteColor()])
            }
        }
        alertController.addAction(destructiveAction)
        
        self.presentViewController(alertController, animated: true) { }
        // post notif - CONFIRM_OVERWRITE

    }
    
    @IBAction func loadTapped(sender : AnyObject) {

        let alertTitle = "Load a Photo?"
        
        let alertMessage = "Selecting a photo to load will overwrite your work"
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let destructiveAction = UIAlertAction(title: "Load a Photo", style: .Destructive) { (action) in
            // ...
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .PhotoLibrary
            
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(destructiveAction)
        
        self.presentViewController(alertController, animated: true) { }
        
    }
    
    @IBAction func saveTapped(sender : AnyObject) {
        // compose the image against the canvas color
        let composedImage = DrawingService.SharedInstance.getImageOnCanvasColor()
        
        CameraRollService.SharedInstance.WriteImage(composedImage)
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kPhotoSaved,
            object: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //            NSNotificationCenter.defaultCenter().postNotificationName(
            //                Notifications.kColorChanged,
            //                object: pickedImage)
            
            if(pickedImage.size.width < pickedImage.size.height) {
                DrawingService.SharedInstance.loadImage0(pickedImage);
            } else {
                DrawingService.SharedInstance.loadImage0(pickedImage.imageRotatedByDegrees(90, flip: false));
            }
            
            dismissViewControllerAnimated(true, completion: {
//                let rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? RESideMenu;
//                rootViewController!.hideMenuViewController();
            })
           
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }

}
