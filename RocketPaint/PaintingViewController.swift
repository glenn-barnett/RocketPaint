//
//  ViewController.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 4/16/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import UIKit
import ACEDrawingView
import RESideMenu


// TODO need "cue" that photo was saved to camera roll

// TODO crop when saving to camera roll

// TODO clear > to what?  background?



class PaintingViewController: UIViewController,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var DrawingView : RocketDrawingView!
    
    @IBOutlet var HamburgerBView : BView?
    @IBOutlet var UndoBView : BView?
    @IBOutlet var RedoBView : BView?
    @IBOutlet var PaletteBView : BView?
    @IBOutlet var BrushBView : BView?
    
    var rotatingButtonArray : [UIView] = [];

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(PaintingViewController.colorSelected(_:)),
            name: Notifications.kColorSelected,
            object: nil)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(PaintingViewController.brushChanged(_:)),
            name: Notifications.kBrushChanged,
            object: nil)

        rotatingButtonArray.append(HamburgerBView!);
        rotatingButtonArray.append(UndoBView!);
        rotatingButtonArray.append(RedoBView!);

        rotatingButtonArray.append(PaletteBView!);
        rotatingButtonArray.append(BrushBView!);
        
        
        // INIT HAPPENS HERE
        DrawingView.backgroundColor = UIColor.whiteColor()
 
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "Pen3")

        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kColorSelected,
            object: UIColor.blackColor())

        DrawingService.SharedInstance.addDrawingView(DrawingView); // GB layer 0?
        
    }

    // GB: from https://happyteamlabs.com/blog/ios-using-uideviceorientation-to-determine-orientation/
    var currentDeviceOrientation: UIDeviceOrientation = .Unknown
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIDevice.currentDevice().beginGeneratingDeviceOrientationNotifications()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PaintingViewController.deviceDidRotate(_:)), name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        // Initial device orientation
        self.currentDeviceOrientation = UIDevice.currentDevice().orientation
        // Do what you want here
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        if UIDevice.currentDevice().generatesDeviceOrientationNotifications {
            UIDevice.currentDevice().endGeneratingDeviceOrientationNotifications()
        }
    }
    
    func deviceDidRotate(notification: NSNotification) {
        self.currentDeviceOrientation = UIDevice.currentDevice().orientation

//        // 1. put all painting icons in an array
//        // 2. add func to iterate over array rotating all to corresponding direction
//        //      .Portrait 0
//        //      .LandscapeLeft 90
//        //      .LandscapeRight -90
//        //      .PortraitUpsideDown 180
//        
//        let xRotate0 = CGAffineTransformMakeRotation(0);
//        let xRotate90 = CGAffineTransformMakeRotation(CGFloat(M_PI_2));
//        let xRotate180 = CGAffineTransformMakeRotation(CGFloat(M_PI));
//        let xRotate270 = CGAffineTransformMakeRotation(CGFloat(M_PI_2 + M_PI));
//        var x:CGAffineTransform;
//        
//        if(self.currentDeviceOrientation ==        .Portrait) {
//            x = xRotate0;
//        } else if(self.currentDeviceOrientation == .PortraitUpsideDown) {
//            x = xRotate180;
//        } else if(self.currentDeviceOrientation == .LandscapeLeft) {
//            x = xRotate90;
//        } else if(self.currentDeviceOrientation == .LandscapeRight) {
//            x = xRotate270;
//        } else if(self.currentDeviceOrientation == .FaceUp) {
//            x = xRotate0;
//        } else if(self.currentDeviceOrientation == .FaceDown) {
//            x = xRotate0;
//        } else {
//            x = xRotate0;
//        }
//        
//        for button in rotatingButtonArray {
//            button.transform = x;
//        }
    }
    
    @IBAction func undoTapped(sender : AnyObject) {
        print("PVC.undoTapped()");
        
        if(DrawingView.canUndo()) {
            DrawingView.undoLatestStep()
        }
    }

    @IBAction func redoTapped(sender : AnyObject) {
        print("PVC.redoTapped()");
        
        if(DrawingView.canRedo()) {
            DrawingView.redoLatestStep()
        }
    }

    @IBAction func hamburgerTapped(sender : AnyObject) {
        print("PVC.hamburgerTapped()");
        
        // rootvc.showside?
        
        
        let rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? RESideMenu;
        
        rootViewController!.presentLeftMenuViewController();
        
        
        
    }

    @IBAction func paletteTapped(sender : AnyObject) {
        print("PVC.paletteTapped()")

        let rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? RootViewController;
        rootViewController?.showRightPalette();
    }

    @IBAction func brushButtonTapped(sender : AnyObject) {
        print("PVC.brushButtonTapped()")
        
        let rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? RootViewController;
        rootViewController?.showRightBrushes();
        
    }

    func colorSelected(notification:NSNotification){
        let selectedColor : UIColor = notification.object as! UIColor

        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        selectedColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        print("PVC got color: \(hue)h,\(saturation)s,\(brightness)v")
        
        DrawingView.lineColor = selectedColor
        
        if(DrawingView.drawTool == ACEDrawingToolTypeRectagleFill) {
            // override the highlighter color?  or let the alpha happen?  TODO
        }

        
    }

    let lineWidth1 : CGFloat = 1.0
    let lineWidth2 : CGFloat = 3.0
    let lineWidth3 : CGFloat = 8.0
    let lineWidth4 : CGFloat = 16.0
    let lineWidthTextSmall : CGFloat = 6.0
    let lineWidthTextBig : CGFloat = 12.0
    let highlightAlpha : CGFloat = 0.4
    
    func brushChanged(notification:NSNotification){
        let brush = notification.object as! String;

        DrawingView.alpha = 1.0
        if(brush == "Pen1") {
            DrawingView.drawTool = ACEDrawingToolTypePen
            DrawingView.lineWidth = lineWidth1

        } else if(brush == "Pen2") {
            DrawingView.drawTool = ACEDrawingToolTypePen
            DrawingView.lineWidth = lineWidth2

        } else if(brush == "Pen3") {
            DrawingView.drawTool = ACEDrawingToolTypePen
            DrawingView.lineWidth = lineWidth3
        
        } else if(brush == "Pen4") {
            DrawingView.drawTool = ACEDrawingToolTypePen
            DrawingView.lineWidth = lineWidth4
        
        } else if(brush == "Line1") {
            DrawingView.drawTool = ACEDrawingToolTypeLine
            DrawingView.lineWidth = lineWidth1

        } else if(brush == "Line2") {
            DrawingView.drawTool = ACEDrawingToolTypeLine
            DrawingView.lineWidth = lineWidth2

        } else if(brush == "Line3") {
            DrawingView.drawTool = ACEDrawingToolTypeLine
            DrawingView.lineWidth = lineWidth3
        
        } else if(brush == "Line4") {
            DrawingView.drawTool = ACEDrawingToolTypeLine
            DrawingView.lineWidth = lineWidth4
        
        } else if(brush == "Box") {
            DrawingView.drawTool = ACEDrawingToolTypeRectagleFill
        
        } else if(brush == "HighlightGreen") {
            DrawingView.drawTool = ACEDrawingToolTypeRectagleFill
            DrawingView.lineColor = UIColor.greenColor()
            DrawingView.lineAlpha = highlightAlpha
        
        } else if(brush == "HighlightYellow") {
            DrawingView.drawTool = ACEDrawingToolTypeRectagleFill
            DrawingView.lineColor = UIColor.yellowColor()
            DrawingView.lineAlpha = highlightAlpha
        
        } else if(brush == "HighlightRed") {
            DrawingView.drawTool = ACEDrawingToolTypeRectagleFill
            DrawingView.lineColor = UIColor.redColor()
            DrawingView.lineAlpha = highlightAlpha
        
        } else if(brush == "TextSerifBig") {
            DrawingView.drawTool = ACEDrawingToolTypeMultilineText
            DrawingView.lineWidth = lineWidthTextBig
        } else if(brush == "TextSerifSmall") {
            DrawingView.drawTool = ACEDrawingToolTypeMultilineText
            DrawingView.lineWidth = lineWidthTextSmall
        } else if(brush == "TextSansBig") {
            DrawingView.drawTool = ACEDrawingToolTypeMultilineText
            DrawingView.lineWidth = lineWidthTextBig
        } else if(brush == "TextSansSmall") {
            DrawingView.drawTool = ACEDrawingToolTypeMultilineText
            DrawingView.lineWidth = lineWidthTextSmall
        }
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

