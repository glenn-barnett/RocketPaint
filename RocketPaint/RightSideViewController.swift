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
    
    @IBOutlet var CheckerOverlayView: UIView!
    
    @IBOutlet var ColorPaletteView : UIView!

    @IBOutlet weak var sliderLineWidth: LineWidthSliderView!
    
    @IBOutlet weak var sliderLineAlpha: LineAlphaSliderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = ColorService.SharedInstance.canvasColor
        self.CheckerOverlayView.backgroundColor = UIColor(patternImage: UIImage(named: "checker-20px-darkalpha.png")!)
        self.CheckerOverlayView.alpha = 1.0

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
            selector: #selector(RightSideViewController.canvasCleared(_:)),
            name: Notifications.kCanvasCleared,
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

    }

    
    func canvasCleared(notification:NSNotification){
        let canvasColor : UIColor = notification.userInfo!["color"] as! UIColor

        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        canvasColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        if(brightness > 0.1) {
            self.view.backgroundColor = canvasColor
        }
        else {
            self.view.backgroundColor = UIColor(hue:hue, saturation:saturation, brightness:0.1, alpha:1)
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
