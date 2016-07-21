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
    @IBOutlet var BrushBView : BView?
    
    var rotatingButtonArray : [UIView] = [];

    var lastColor = ColorService.SharedInstance.defaultPaintColor()
    let imagePicker = UIImagePickerController()
    var undoClearImage : UIImage? // saved just before we clear as special undo step
    var undoClearBackgroundColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        

        rotatingButtonArray.append(HamburgerBView!);
        rotatingButtonArray.append(UndoBView!);
        rotatingButtonArray.append(RedoBView!);

        rotatingButtonArray.append(BrushBView!);
        
        // INIT HAPPENS HERE
        DrawingView.backgroundColor = UIColor.whiteColor()
        
 
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Pen3"])

        DrawingView.lineColor = lastColor
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kColorChanged,
            object: nil,
            userInfo: ["color": DrawingView.lineColor])

        DrawingView.lineWidth = 10.0
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kLineWidthChanged,
            object: nil,
            userInfo: ["lineWidth": DrawingView.lineWidth])

        DrawingView.lineAlpha = 1.0
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kLineAlphaChanged,
            object: nil,
            userInfo: ["lineAlpha": DrawingView.lineAlpha])

        DrawingView.edgeSnapThreshold = 15

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

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(PaintingViewController.colorChanged(_:)),
            name: Notifications.kColorChanged,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(PaintingViewController.brushChanged(_:)),
            name: Notifications.kBrushChanged,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(PaintingViewController.lineWidthChanged(_:)),
            name: Notifications.kLineWidthChanged,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(PaintingViewController.lineAlphaChanged(_:)),
            name: Notifications.kLineAlphaChanged,
            object: nil)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(PaintingViewController.canvasCleared(_:)),
            name: Notifications.kCanvasCleared,
            object: nil)

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
        } else {
            print("PVC.undoTapped(): nothing to undo!");
            if(undoClearBackgroundColor != nil) {
                DrawingView.backgroundColor = undoClearBackgroundColor
                undoClearBackgroundColor = nil
            }
            if(undoClearImage != nil) {
                DrawingView.loadImage(undoClearImage)
                undoClearImage = nil
            }
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

    func colorChanged(notification:NSNotification){
        let selectedColor : UIColor = notification.userInfo!["color"] as! UIColor
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        selectedColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        print("PVC got color: \(hue)h,\(saturation)s,\(brightness)v,\(alpha)a")
        
        
        DrawingView.lineColor = selectedColor.colorWithAlphaComponent(1.0)
        
        lastColor = DrawingView.lineColor.colorWithAlphaComponent(1.0) // copy
        
    }

    let lineWidth1 : CGFloat = 1.0
    let lineWidth2 : CGFloat = 3.0
    let lineWidth3 : CGFloat = 8.0
    let lineWidth4 : CGFloat = 16.0
    let lineWidthTextSmall : CGFloat = 6.0
    let lineWidthTextBig : CGFloat = 12.0
    let highlightAlpha : CGFloat = 0.4
    
    func brushChanged(notification:NSNotification){
        let brush = notification.userInfo!["brush"] as! String

        DrawingView.lineColor = lastColor
        
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
            DrawingView.fontName = "Georgia"
            DrawingView.drawTool = ACEDrawingToolTypeMultilineText
            DrawingView.lineWidth = lineWidthTextBig
        } else if(brush == "TextSerifSmall") {
            DrawingView.fontName = "Georgia"
            DrawingView.drawTool = ACEDrawingToolTypeMultilineText
            DrawingView.lineWidth = lineWidthTextSmall
        } else if(brush == "TextSansBig") {
            DrawingView.fontName = nil
            DrawingView.drawTool = ACEDrawingToolTypeMultilineText
            DrawingView.lineWidth = lineWidthTextBig
        } else if(brush == "TextSansSmall") {
            DrawingView.fontName = nil
            DrawingView.drawTool = ACEDrawingToolTypeMultilineText
            DrawingView.lineWidth = lineWidthTextSmall
        }
    
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kLineWidthChanged,
            object: nil,
            userInfo: ["lineWidth": Float(DrawingView.lineWidth)])

        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kLineAlphaChanged,
            object: nil,
            userInfo: ["lineAlpha": Float(DrawingView.lineAlpha)])

    }
    
    func lineWidthChanged(notification:NSNotification){
        let lineWidth = notification.userInfo!["lineWidth"] as! Float
        DrawingView.lineWidth = CGFloat(lineWidth)
        print("PaintingVC.lineWidthChanged(\(lineWidth))")
    }
    func lineAlphaChanged(notification:NSNotification){
        let lineAlpha = notification.userInfo!["lineAlpha"] as! Float
        DrawingView.lineAlpha = CGFloat(lineAlpha)
        print("PaintingVC.lineAlphaChanged(\(lineAlpha))")
    }
    func canvasCleared(notification:NSNotification){
        let canvasColor : UIColor = notification.userInfo!["color"] as! UIColor
        
        // save these just in case
        undoClearImage = DrawingView.image
        undoClearBackgroundColor = DrawingView.backgroundColor
        
        DrawingView.backgroundColor = canvasColor
        DrawingView.clear()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

