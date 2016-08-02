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
    
    @IBOutlet var DarkBackgroundView: UIView!
    
    @IBOutlet var ColorPaletteView : UIView!

    @IBOutlet weak var sliderLineWidth: LineWidthSliderView!
    
    @IBOutlet weak var sliderLineAlpha: LineAlphaSliderView!
    
    var darkBackground = UIColor(patternImage: UIImage(named: "checker-20px-darkgray.png")!)
    var lightBackground = UIColor(patternImage: UIImage(named: "checker-20px-lightgray.png")!)

//    let bLine = BrushWirePen3BView(frame: CGRect(x: 250, y: 110, width: 120, height: 82))
//    let colorService = ColorService.SharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        bLine.userInteractionEnabled = true
//
//        self.view.addSubview(bLine)
        
        self.view.backgroundColor = lightBackground
        
        self.DarkBackgroundView.backgroundColor = darkBackground
        self.DarkBackgroundView.alpha = 0

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
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        selectedColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        // should use light:
        // 0.66h 0.375s 0.5v (dark faded blue purp)
        // 0.66h 0.25s  0.5v

        if((saturation < 0.51 && brightness > 0.51) || (saturation < 0.71 && brightness > 0.51)) {
            UIView.animateWithDuration(0.5, delay: 0.0, options:[], animations: {
                self.DarkBackgroundView.alpha = 1.0
            }, completion: nil)
        } else {
            UIView.animateWithDuration(0.5, delay: 0.0, options:[], animations: {
                self.DarkBackgroundView.alpha = 0.0
            }, completion: nil)
        }
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
