//
//  ViewController.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 4/16/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import UIKit
import ACEDrawingView


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

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var DrawingView : RocketDrawingView!
    @IBOutlet var ColorPaletteView : UIView?
    
    @IBOutlet var UndoButton : UIButton?
    @IBOutlet var RedoButton : UIButton?
    
    @IBOutlet var DismissButton : UIButton?
    @IBOutlet var ColorButton : UIButton?
    @IBOutlet var BrushButton : UIButton?
    @IBOutlet var LoadPictureButton : UIButton?
    @IBOutlet var SavePictureButton : UIButton?

    @IBOutlet var PenButton : UIButton?
    @IBOutlet var LineButton : UIButton?
    @IBOutlet var BoxButton : UIButton?
    @IBOutlet var TextButton : UIButton?

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
            selector: #selector(ViewController.colorSelected(_:)),
            name: Notifications.kColorSelected,
            object: nil)
        
        
//        rightButtonArray.append(ColorButton!)
//        rightButtonArray.append(LoadPictureButton!)
//        rightButtonArray.append(SavePictureButton!)
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
 
        
        
        self.showRightTools()
        //self.hideLeftTools()
        
    }

    func showRightTools() {
        rightToolsShown = true;
    }
    
    func hideLeftTools() {
        leftToolsShown = false;
    }

    @IBAction func undoTapped(sender : AnyObject) {
        print("undoTapped()");
        
        if(DrawingView.canUndo()) {
            DrawingView.undoLatestStep()
        }
    }

    @IBAction func redoTapped(sender : AnyObject) {
        print("redoTapped()");
        
        if(DrawingView.canRedo()) {
            DrawingView.redoLatestStep()
        }
    }

    @IBAction func dismissToolsTapped(sender : AnyObject) {
        print("dismissToolsTapped()");
    }

    @IBAction func colorToolTapped(sender : AnyObject) {
        print("colorToolTapped()")

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
        print("brushButtonTapped()")

        var hiddenState = brushButtonArray[0].hidden;
        
        for button in brushButtonArray {
            button.hidden = !hiddenState;
        }
    }

    @IBAction func penButtonTapped(sender : AnyObject) {
        print("penButtonTapped()")
        
        // pen mode
        DrawingView.drawTool = ACEDrawingToolTypePen;
        hideBrushes()
    }
    @IBAction func lineButtonTapped(sender : AnyObject) {
        print("lineButtonTapped()")
        
        // line mode
        DrawingView.drawTool = ACEDrawingToolTypeLine;
        hideBrushes()
    }
    @IBAction func boxButtonTapped(sender : AnyObject) {
        print("boxButtonTapped()")
        
        // box mode
        DrawingView.drawTool = ACEDrawingToolTypeRectagleFill;
        hideBrushes()
    }
    @IBAction func textButtonTapped(sender : AnyObject) {
        print("textButtonTapped()")
        
        // MULTILINE text mode
        DrawingView.drawTool = ACEDrawingToolTypeMultilineText;
        hideBrushes()
    }

    @IBAction func loadPictureTapped(sender : AnyObject) {
        print("loadPictureTapped()");
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //DrawingView.backgroundImage.contentMode = .ScaleAspectFit
//            DrawingView.backgroundImage = pickedImage
            DrawingView.drawMode = .Scale
            DrawingView.loadImage(pickedImage)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func savePictureTapped(sender : AnyObject) {
        print("savePictureTapped()");
        
        UIImageWriteToSavedPhotosAlbum(DrawingView.image, nil, nil, nil)
        
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
        
        print("parent VC got color: \(hue)h,\(saturation)s,\(brightness)v")
        
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

