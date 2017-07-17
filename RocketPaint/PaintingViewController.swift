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
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    ACEDrawingViewDelegate {

    @IBOutlet var DrawingView : RocketDrawingView!
    @IBOutlet var EasterEggView : EasterEggDrawingView!
    
    @IBOutlet var HamburgerBView : BView?
    @IBOutlet var UndoBView : BView?
    @IBOutlet var RedoBView : BView?
    @IBOutlet var BrushBView : BView?
    
//    let xray = DynamicXray()
    
    var rotatingButtonArray : [UIView] = [];

    let colorService = ColorService.SharedInstance
    var lastColor = UIColor.black
    
    let imagePicker = UIImagePickerController()
    var requestedLineWidth : CGFloat = 4.0
    
    func updateUndoRedo(_ forceHide: Bool = false) {
//        let disableUndo = (!DrawingView.canUndo() || forceHide)
//        
        UndoBView?.disabled = (!DrawingView.canUndo() || forceHide)
        UndoBView?.alpha = (!DrawingView.canUndo() || forceHide) ? 0.2 : 1.0
        
        RedoBView?.disabled = (!DrawingView.canRedo() || forceHide)
        RedoBView?.alpha = (!DrawingView.canRedo() || forceHide) ? 0.2 : 1.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        DrawingView.delegate = self

        updateUndoRedo()
        
        rotatingButtonArray.append(HamburgerBView!);
        rotatingButtonArray.append(UndoBView!);
        rotatingButtonArray.append(RedoBView!);

        rotatingButtonArray.append(BrushBView!);
        
        // INIT HAPPENS HERE
        
        DrawingView.backgroundColor = colorService.canvasColor
        DrawingView.lineColor = colorService.defaultPaintColor()
        lastColor = colorService.defaultPaintColor()
 
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kBrushChanged),
            object: nil,
            userInfo: ["brush": "Pen"])

        
        NotificationCenter.default.post(
            name: Notification.Name(rawValue:Notifications.kColorChanged),
            object: nil,
            userInfo: ["color": DrawingView.lineColor])

        DrawingView.lineWidth = 10.0
        NotificationCenter.default.post(
            name: Notification.Name(rawValue:Notifications.kLineWidthChanged),
            object: nil,
            userInfo: ["lineWidth": Float(DrawingView.lineWidth)])

//        DrawingView.lineAlpha = 1.0
//        NSNotificationCenter.defaultCenter().postNotificationName(
//            Notifications.kLineAlphaChanged,
//            object: nil,
//            userInfo: ["lineAlpha": DrawingView.lineAlpha])

        DrawingView.edgeSnapThreshold = 15

        DrawingService.SharedInstance.addDrawingView(DrawingView); // GB layer 0?
        
        
    }

    var initialLoad = true
    override func viewDidLayoutSubviews() {
        // on first load, load last image
        if(initialLoad) {
            DrawingService.SharedInstance.restoreState()
            DrawingService.SharedInstance.initNotifications()
        }
        
        initialLoad = false
        
    }
    

    // GB: from https://happyteamlabs.com/blog/ios-using-uideviceorientation-to-determine-orientation/
    var currentDeviceOrientation: UIDeviceOrientation = .unknown
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(PaintingViewController.deviceDidRotate(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        // Initial device orientation
        self.currentDeviceOrientation = UIDevice.current.orientation
        // Do what you want here

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PaintingViewController.colorChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kColorChanged),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PaintingViewController.brushChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kBrushChanged),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PaintingViewController.lineWidthChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kLineWidthChanged),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PaintingViewController.lineAlphaChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kLineAlphaChanged),
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PaintingViewController.canvasCleared(_:)),
            name: NSNotification.Name(rawValue: Notifications.kCanvasCleared),
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PaintingViewController.photoLoaded(_:)),
            name: NSNotification.Name(rawValue: Notifications.kPhotoLoaded),
            object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
        if UIDevice.current.isGeneratingDeviceOrientationNotifications {
            UIDevice.current.endGeneratingDeviceOrientationNotifications()
        }
    }
    
    func deviceDidRotate(_ notification: Notification) {
        self.currentDeviceOrientation = UIDevice.current.orientation

        if(self.currentDeviceOrientation == .faceDown
            //|| self.currentDeviceOrientation == .LandscapeLeft || self.currentDeviceOrientation == .LandscapeRight
            ) {
            self.EasterEggView.start()
            
            UIView.animate(withDuration: 3.0, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState,
                                       animations: {
                self.EasterEggView.alpha = 1.0
                }, completion: {
                    (value: Bool) in
                    
            })
            
        } else {

            UIView.animate(withDuration: 2.0, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState,
                                       animations: {
                self.EasterEggView.alpha = 0.0
                }, completion: {
                    (value: Bool) in

                    if(self.EasterEggView.alpha == 0.0) {
                        self.EasterEggView.stop()
                    }
            })
        }
        
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
    
    func drawingView(_ view: ACEDrawingView!, didEndDrawUsing tool: ACEDrawingTool!) {
        updateUndoRedo()
    }
    
    @IBAction func undoTapped(_ sender : AnyObject) {
        
        if(DrawingView.canUndo()) {
            DrawingView.undoLatestStep()
        }
        updateUndoRedo()
    }

    @IBAction func redoTapped(_ sender : AnyObject) {
        
        if(DrawingView.canRedo()) {
            DrawingView.redoLatestStep()
        }
        updateUndoRedo()
    }

    @IBAction func hamburgerTapped(_ sender : AnyObject) {
        
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? RootViewController;
        
        rootViewController!.showLeftMenu();
        
    }

    @IBAction func brushButtonTapped(_ sender : AnyObject) {
        
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? RootViewController;
        rootViewController?.showRightBrushes();
        
    }

    func colorChanged(_ notification:Notification){
        let selectedColor : UIColor = notification.userInfo!["color"] as! UIColor
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        selectedColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
//        print("PVC got color: \(hue)h,\(saturation)s,\(brightness)v,\(alpha)a")
        
        DrawingView.lineColor = selectedColor.withAlphaComponent(1.0)
        
        lastColor = DrawingView.lineColor.withAlphaComponent(1.0) // copy
        
    }

    func brushChanged(_ notification:Notification){
        let brush = notification.userInfo!["brush"] as! String

        DrawingView.lineColor = lastColor
        
        if(brush == "Pen") {
            DrawingView.drawTool = ACEDrawingToolTypePen

        } else if(brush == "Line") {
            DrawingView.drawTool = ACEDrawingToolTypeLine
        
        } else if(brush == "EllipseSolid") {
            DrawingView.drawTool = ACEDrawingToolTypeEllipseFill
            
        } else if(brush == "EllipseOutline") {
            DrawingView.drawTool = ACEDrawingToolTypeEllipseStroke
            
        } else if(brush == "RectSolid") {
            DrawingView.drawTool = ACEDrawingToolTypeRectagleFill
        
        } else if(brush == "RectOutline") {
            DrawingView.drawTool = ACEDrawingToolTypeRectagleStroke
        
        } else if(brush == "TextSerif") {
            DrawingView.fontName = "Georgia"
            DrawingView.drawTool = ACEDrawingToolTypeMultilineText
            

        } else if(brush == "TextSans") {
            DrawingView.fontName = nil
            DrawingView.drawTool = ACEDrawingToolTypeMultilineText
        }
        enforceMinimumTextSize()
        
        updateUndoRedo(true)
        
    }
    
    func lineWidthChanged(_ notification:Notification){
        let lineWidth = notification.userInfo!["lineWidth"] as! Float
        requestedLineWidth = CGFloat(lineWidth)
        DrawingView.lineWidth = requestedLineWidth
        enforceMinimumTextSize()
    }
    
    func lineAlphaChanged(_ notification:Notification){
        let lineAlpha = notification.userInfo!["lineAlpha"] as! Float
        DrawingView.lineAlpha = CGFloat(lineAlpha)
    }
    
    func canvasCleared(_ notification:Notification){
        let canvasColor : UIColor = notification.userInfo!["color"] as! UIColor
        
        colorService.canvasColor = canvasColor
        
        DrawingView.backgroundColor = colorService.canvasColor
        DrawingView.clear()

        updateUndoRedo()
    }
    
    func photoLoaded(_ notification:Notification) {
        updateUndoRedo()
    }
    

    let kTextMinLineWidth : CGFloat = 4.0
    
    func enforceMinimumTextSize() {
        if(DrawingView.drawTool == ACEDrawingToolTypeMultilineText) {
            DrawingView.lineWidth = max(kTextMinLineWidth, DrawingView.lineWidth)
        } else if(requestedLineWidth != DrawingView.lineWidth) {
            DrawingView.lineWidth = requestedLineWidth // reset it to what was requested
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

