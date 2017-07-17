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
import BCGenieEffect

class RightSideViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var ColorPaletteView : UIView!

    @IBOutlet weak var sliderLineWidth: LineWidthSliderView!
    
    @IBOutlet weak var sliderLineAlpha: LineAlphaSliderView!

    @IBOutlet weak var clearCanvasBView: ClearCanvasBView!

    @IBOutlet weak var saveBView: SaveBView!
    
    @IBOutlet weak var versionLabel: UILabel!

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.versionLabel.text = version
        }
        
        imagePicker.delegate = self

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RightSideViewController.lineWidthChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kLineWidthChanged),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RightSideViewController.lineAlphaChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kLineAlphaChanged),
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RightSideViewController.colorChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kColorChanged),
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RightSideViewController.menuOpened(_:)),
            name: NSNotification.Name(rawValue: Notifications.kRightMenuOpened),
            object: nil)

    }

    
    @IBAction func lineWidthAdjusted(_ sender: AnyObject) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kLineWidthChanged),
            object: nil,
            userInfo: ["lineWidth": Float((sender as! LineWidthSliderView).value)])
    }
    
    @IBAction func lineAlphaAdjusted(_ sender: AnyObject) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kLineAlphaChanged),
            object: nil,
            userInfo: ["lineAlpha": Float((sender as! LineAlphaSliderView).value)])
    }

    func lineWidthChanged(_ notification:Notification){
        let lineWidth = notification.userInfo!["lineWidth"] as! Float
        sliderLineWidth.value = CGFloat(lineWidth)
    }
    
    func lineAlphaChanged(_ notification:Notification){
        let lineAlpha = notification.userInfo!["lineAlpha"] as! Float
        sliderLineAlpha.value = CGFloat(lineAlpha)
    }

    func colorChanged(_ notification:Notification){
        let selectedColor : UIColor = notification.userInfo!["color"] as! UIColor

        clearCanvasBView.iconColor = selectedColor
        clearCanvasBView.setNeedsDisplay()

//        var hue: CGFloat = 0
//        var saturation: CGFloat = 0
//        var brightness: CGFloat = 0
//        var alpha: CGFloat = 0
//        selectedColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    }

    func menuOpened(_ notification:Notification){
        clearCanvasBView.iconColor = UIColor.white
        clearCanvasBView.setNeedsDisplay()
    }
    
    @IBAction func pickedPen(_ sender : AnyObject) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kBrushChanged),
            object: nil,
            userInfo: ["brush": "Pen"])
    }
    @IBAction func pickedLine(_ sender : AnyObject) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kBrushChanged),
            object: nil,
            userInfo: ["brush": "Line"])
    }
    @IBAction func pickedRectSolid(_ sender : AnyObject) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kBrushChanged),
            object: nil,
            userInfo: ["brush": "RectSolid"])
    }
    @IBAction func pickedRectOutline(_ sender : AnyObject) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kBrushChanged),
            object: nil,
            userInfo: ["brush": "RectOutline"])
    }
    @IBAction func pickedEllipseSolid(_ sender : AnyObject) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kBrushChanged),
            object: nil,
            userInfo: ["brush": "EllipseSolid"])
    }
    @IBAction func pickedEllipseOutline(_ sender : AnyObject) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kBrushChanged),
            object: nil,
            userInfo: ["brush": "EllipseOutline"])
    }
    @IBAction func pickedTextSerif(_ sender : AnyObject) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kBrushChanged),
            object: nil,
            userInfo: ["brush": "TextSerif"])
    }
    @IBAction func pickedTextSans(_ sender : AnyObject) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kBrushChanged),
            object: nil,
            userInfo: ["brush": "TextSans"])
    }

    @IBAction func clearTapped(_ sender : AnyObject) {
        
        if(DrawingService.SharedInstance.isModified) {
        
            let alertTitle = "Clear your canvas?"
            
            let alertMessage = "To erase your work, choose \"Erase\".\nTo keep your work, choose \"Cancel\""
            
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                // ...
            }
            alertController.addAction(cancelAction)
            
            let destructiveAction = UIAlertAction(title: "Erase", style: .destructive) { (action) in
                self.executeClear()
            }
            alertController.addAction(destructiveAction)
            
            self.present(alertController, animated: true) { }
            // post notif - CONFIRM_OVERWRITE
        }
        else {
            // not modified; just do it
            self.executeClear()
        }
    }
    
    func executeClear() {
        let clearColor = self.clearCanvasBView.iconColor.withAlphaComponent(1.0)
        
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kCanvasCleared),
            object: nil,
            userInfo: ["color": clearColor])
        
        // second, extract the selected color into components
        var srcHue: CGFloat = 0
        var srcSaturation: CGFloat = 0
        var srcBrightness: CGFloat = 0
        var srcAlpha: CGFloat = 0
        clearColor.getHue(&srcHue, saturation: &srcSaturation, brightness: &srcBrightness, alpha: &srcAlpha)
        
        if(!(srcBrightness > 0.98 && srcSaturation < 0.02)) {
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: Notifications.kColorChanged),
                object: nil,
                userInfo: ["color": UIColor.white])
        }
 
    }
    
    @IBAction func loadTapped(_ sender : AnyObject) {

        if(DrawingService.SharedInstance.isModified) {
            let alertTitle = "Load a Photo?"
            
            let alertMessage = "Selecting a photo to load will overwrite your work"
            
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                // ...
            }
            alertController.addAction(cancelAction)
            
            let destructiveAction = UIAlertAction(title: "Load a Photo", style: .destructive) { (action) in
                // ...
                self.executeLoad()
            }
            alertController.addAction(destructiveAction)
            
            self.present(alertController, animated: true) { }
        } else {
            // not modified, just do it
            executeLoad()
        }
    }
    
    func executeLoad() {
        self.imagePicker.allowsEditing = false
        self.imagePicker.sourceType = .photoLibrary
        
        self.present(self.imagePicker, animated: true, completion: nil)
    
    }
    
    @IBAction func saveTapped(_ sender : AnyObject) {
        // compose the image against the canvas color
        let composedImage = DrawingService.SharedInstance.getImageOnCanvasColor()
        
        let imageView = UIImageView(image: composedImage)
        imageView.frame = CGRect(x: -200, y: 154, width: 465, height: 670)
        view.insertSubview(imageView, belowSubview: saveBView)
        
        // animate it
        imageView.genieInTransition(withDuration: 0.7, destinationRect: CGRect(x:saveBView.frame.minX + 11, y:saveBView.frame.maxY - 11, width: 55, height:2), destinationEdge: BCRectEdge.top, completion: {
            
            imageView.removeFromSuperview()
        })
        
        // if we've already written the same image and it isn't modified, skip
        CameraRollService.SharedInstance.WriteImage(composedImage)
        
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kPhotoSaved),
            object: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //            NSNotificationCenter.defaultCenter().postNotificationName(
            //                Notifications.kColorChanged,
            //                object: pickedImage)
            
            if(pickedImage.size.width < pickedImage.size.height) {
                DrawingService.SharedInstance.loadImage0(pickedImage);
            } else {
                DrawingService.SharedInstance.loadImage0(pickedImage.imageRotatedByDegrees(90, flip: false));
            }
            
            dismiss(animated: true, completion: {
//                let rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? RESideMenu;
//                rootViewController!.hideMenuViewController();
            })
           
        } else {
            dismiss(animated: true, completion: nil)
        }
        
    }

}
