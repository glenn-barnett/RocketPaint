//
//  ViewController.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 4/16/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import UIKit
import ACEDrawingView

class ViewController: UIViewController {

    @IBOutlet var DrawingView : ACEDrawingView?
    @IBOutlet /*weak?*/ var RightToolsView : UIView?
    @IBOutlet /*weak?*/ var LeftToolsView : UIView?
    @IBOutlet var ColorPaletteView : UIView?
    @IBOutlet var cv : UICollectionView?
    
    @IBOutlet var UndoButton : UIButton?
    @IBOutlet var RedoButton : UIButton?
    
    @IBOutlet var DismissButton : UIButton?
    @IBOutlet var ColorButton : UIButton?
    @IBOutlet var LoadPictureButton : UIButton?
    @IBOutlet var SavePictureButton : UIButton?
    
    var rightToolsShown : Bool! = false;
    var leftToolsShown : Bool! = false;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(ViewController.colorSelected(_:)),
            name: Notifications.kColorSelected,
            object: nil)
        
        
        
        // INIT HAPPENS HERE
        self.view.backgroundColor = UIColor.whiteColor()
 
        self.showRightTools()
        self.hideLeftTools()
        
        
    }

    func showRightTools() {
        rightToolsShown = true;
        RightToolsView!.hidden = false;
    }
    
    func hideLeftTools() {
        leftToolsShown = false;
        LeftToolsView!.hidden = true;
    }

    @IBAction func undoTapped(sender : AnyObject) {
        print("undoTapped()");
    }

    @IBAction func redoTapped(sender : AnyObject) {
        print("redoTapped()");
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

    @IBAction func loadPictureTapped(sender : AnyObject) {
        print("loadPictureTapped()");
    }
    @IBAction func savePictureTapped(sender : AnyObject) {
        print("savePictureTapped()");
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

        ColorButton!.backgroundColor = selectedColor
        
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
        
        let drawingView : ACEDrawingView = self.view as! ACEDrawingView
        drawingView.lineColor = selectedColor
        
        self.hideColorPalette()

    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

