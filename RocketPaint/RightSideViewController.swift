//
//  RightSideViewController.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/7/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class RightSideViewController: UIViewController {
    
    @IBOutlet var ColorPaletteView : UIView!

    @IBOutlet weak var sliderLineWidth: UISlider!
    
    @IBOutlet weak var sliderLineAlpha: UISlider!

//    let bLine = BrushWirePen3BView(frame: CGRect(x: 250, y: 110, width: 120, height: 82))
//    let colorService = ColorService.SharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        bLine.userInteractionEnabled = true
//
//        self.view.addSubview(bLine)

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
        
    }

    
    @IBAction func lineWidthAdjusted(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kLineWidthChanged,
            object: nil,
            userInfo: ["lineWidth": sliderLineWidth.value])
    }
    
    @IBAction func lineAlphaAdjusted(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kLineAlphaChanged,
            object: nil,
            userInfo: ["lineAlpha": sliderLineAlpha.value])
    }

    func lineWidthChanged(notification:NSNotification){
        let lineWidth = notification.userInfo!["lineWidth"] as! Float
        sliderLineWidth.value = lineWidth
    }
    
    func lineAlphaChanged(notification:NSNotification){
        let lineAlpha = notification.userInfo!["lineAlpha"] as! Float
        sliderLineAlpha.value = lineAlpha
    }

    
    @IBAction func pickedPen(sender : AnyObject) {
        print("BrushPicker: pickedPen()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Pen"])
    }
    @IBAction func pickedLine(sender : AnyObject) {
        print("BrushPicker: pickedLine()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Line"])
    }
    @IBAction func pickedRectSolid(sender : AnyObject) {
        print("BrushPicker: pickedRectSolid()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "RectSolid"])
    }
    @IBAction func pickedRectOutline(sender : AnyObject) {
        print("BrushPicker: pickedRectOutline()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "RectOutline"])
    }
    @IBAction func pickedEllipseSolid(sender : AnyObject) {
        print("BrushPicker: pickedEllipseSolid()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "EllipseSolid"])
    }
    @IBAction func pickedEllipseOutline(sender : AnyObject) {
        print("BrushPicker: pickedEllipseOutline()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "EllipseOutline"])
    }
    @IBAction func pickedTextSerif(sender : AnyObject) {
        print("BrushPicker: pickedTextSerif()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "TextSerif"])
    }
    @IBAction func pickedTextSans(sender : AnyObject) {
        print("BrushPicker: pickedTextSans()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "TextSans"])
    }
    
}
