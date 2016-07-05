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

// TODO icons, button styling

// TODO brush width

// TODO clear > to what?  background?


// mode >
//   brush >
//     width
//   fill.
//   pixels >
//     shape
//     size
//   rect >
//     hollow/full
//   ellipse >
//     hollow/full
//   text >
//     font
//     size
//   eraser >
//     width
//   eyedropper.

// TODO eyedropper, fill
//   ACE options: text/font, line/arrow, rect, ellipse,

class PaintingViewController: UIViewController,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var DrawingView : RocketDrawingView!
    @IBOutlet var ColorPaletteView : UIView?
    
    @IBOutlet var UndoButton : UIButton?
    @IBOutlet var RedoButton : UIButton?
    
    @IBOutlet var HamburgerButton : UIButton?
    @IBOutlet var ColorButton : UIButton?
    @IBOutlet var BrushButton : UIButton?

    @IBOutlet var PenButton : UIButton?
    @IBOutlet var LineButton : UIButton?
    @IBOutlet var BoxButton : UIButton?
    @IBOutlet var TextButton : UIButton?

    var rotatingButtonArray : [UIButton] = [];

    var leftButtonArray : [UIButton] = [];
    var rightButtonArray : [UIButton] = [];
    
    var brushButtonArray : [UIButton] = [];
    
    var rightToolsShown : Bool! = false;
    var leftToolsShown : Bool! = false;
    
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


        rotatingButtonArray.append(UndoButton!);
        rotatingButtonArray.append(RedoButton!);
        rotatingButtonArray.append(HamburgerButton!);

        rotatingButtonArray.append(ColorButton!);
        rotatingButtonArray.append(BrushButton!);
        
//        rightButtonArray.append(ColorButton!)
//
//        leftButtonArray.append(UndoButton!)
//        leftButtonArray.append(RedoButton!)
//        
        brushButtonArray.append(PenButton!)
        brushButtonArray.append(LineButton!)
        brushButtonArray.append(BoxButton!)
        brushButtonArray.append(TextButton!)
        
        
        // INIT HAPPENS HERE
        DrawingView.backgroundColor = UIColor.whiteColor()
 
        DrawingService.SharedInstance.addDrawingView(DrawingView); // GB layer 0?
        
        
        self.showRightTools()
        //self.hideLeftTools()
        
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

        // 1. put all painting icons in an array
        // 2. add func to iterate over array rotating all to corresponding direction
        //      .Portrait 0
        //      .LandscapeLeft 90
        //      .LandscapeRight -90
        //      .PortraitUpsideDown 180
        
        let xRotate0 = CGAffineTransformMakeRotation(0);
        let xRotate90 = CGAffineTransformMakeRotation(CGFloat(M_PI_2));
        let xRotate180 = CGAffineTransformMakeRotation(CGFloat(M_PI));
        let xRotate270 = CGAffineTransformMakeRotation(CGFloat(M_PI_2 + M_PI));
        var x:CGAffineTransform;
        
        if(self.currentDeviceOrientation ==        .Portrait) {
            x = xRotate0;
        } else if(self.currentDeviceOrientation == .PortraitUpsideDown) {
            x = xRotate180;
        } else if(self.currentDeviceOrientation == .LandscapeLeft) {
            x = xRotate90;
        } else if(self.currentDeviceOrientation == .LandscapeRight) {
            x = xRotate270;
        } else if(self.currentDeviceOrientation == .FaceUp) {
            x = xRotate0;
        } else if(self.currentDeviceOrientation == .FaceDown) {
            x = xRotate0;
        } else {
            x = xRotate0;
        }
        
        for button in rotatingButtonArray {
            button.transform = x;
        }
    }
    
    func showRightTools() {
        rightToolsShown = true;
    }
    
    func hideLeftTools() {
        leftToolsShown = false;
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

    @IBAction func colorToolTapped(sender : AnyObject) {
        print("PVC.colorToolTapped()")

        if(ColorPaletteView!.hidden) { // it's hidden
            self.showColorPalette()
        } else { // it's visible
            self.hideColorPalette()
            NSNotificationCenter.defaultCenter().postNotificationName(
                Notifications.kColorPaletteClosed,
                object: nil)
            
        }
    }

    func hideBrushes() {
        for button in brushButtonArray {
            button.hidden = true;
        }
        
    }
    
    @IBAction func brushButtonTapped(sender : AnyObject) {
        print("PVC.brushButtonTapped()")

        var hiddenState = brushButtonArray[0].hidden;
        
        for button in brushButtonArray {
            button.hidden = !hiddenState;
        }
    }

    @IBAction func penButtonTapped(sender : AnyObject) {
        print("PVC.penButtonTapped()")
        
        // pen mode
        DrawingView.drawTool = ACEDrawingToolTypePen;
        hideBrushes()
    }
    @IBAction func lineButtonTapped(sender : AnyObject) {
        print("PVC.lineButtonTapped()")
        
        // line mode
        DrawingView.drawTool = ACEDrawingToolTypeLine;
        hideBrushes()
    }
    @IBAction func boxButtonTapped(sender : AnyObject) {
        print("PVC.boxButtonTapped()")
        
        // box mode
        DrawingView.drawTool = ACEDrawingToolTypeRectagleFill;
        hideBrushes()
    }
    @IBAction func textButtonTapped(sender : AnyObject) {
        print("PVC.textButtonTapped()")
        
        // MULTILINE text mode
        DrawingView.drawTool = ACEDrawingToolTypeMultilineText;
        hideBrushes()
    }

    
    func showColorPalette() {
        ColorPaletteView!.hidden = false
    }
    func hideColorPalette() {
        ColorPaletteView!.hidden = true
    }

// TODO example of setting refs on contained child vcs
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if(segue.identifier == "myEmbeddedSegue") {
//            let childViewController = segue.destinationViewController as! ColorPaletteViewController
//        }
//    }
    func colorSelected(notification:NSNotification){
        let selectedColor : UIColor = notification.object as! UIColor

        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        selectedColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        print("PVC got color: \(hue)h,\(saturation)s,\(brightness)v")
        
        if brightness > 0.6 {
            ColorButton!.titleLabel?.textColor = UIColor.blackColor()
        } else {
            ColorButton!.titleLabel?.textColor = UIColor.whiteColor()
        }
        
        DrawingView.lineColor = selectedColor
        
        self.hideColorPalette()

    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

