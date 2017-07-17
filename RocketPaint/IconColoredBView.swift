//
//  UndoButton.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class IconColoredBView: BView {

    var iconColor:UIColor = UIColor.red
    var lineWidth:CGFloat = 6.0
    
    func getLineWidthMin() -> Float {
        return 1.0
    }

    func getLineWidthMax() -> Float {
        return 40.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(IconColoredBView.colorChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kColorChanged),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(IconColoredBView.lineAlphaChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kLineAlphaChanged),
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(IconColoredBView.lineWidthChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kLineWidthChanged),
            object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(IconColoredBView.colorChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kColorChanged),
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(IconColoredBView.lineAlphaChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kLineAlphaChanged),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(IconColoredBView.lineWidthChanged(_:)),
            name: NSNotification.Name(rawValue: Notifications.kLineWidthChanged),
            object: nil)
        

    }
    
    func colorChanged(_ notification:Notification){
        iconColor = notification.userInfo!["color"] as! UIColor
        self.setNeedsDisplay()
    }

    
    func lineAlphaChanged(_ notification:Notification){
        let lineAlpha = notification.userInfo!["lineAlpha"] as! Float
        
        iconColor = iconColor.withAlphaComponent(CGFloat(lineAlpha))
        self.setNeedsDisplay();
    }

    func lineWidthChanged(_ notification:Notification){
        let inputLineWidth = notification.userInfo!["lineWidth"] as! Float
        let adjustedLineWidth = getLineWidthMin() + (inputLineWidth / 40.0) * (getLineWidthMax() - getLineWidthMin());
        
        lineWidth = CGFloat(adjustedLineWidth)
        self.setNeedsDisplay()
    }

}
