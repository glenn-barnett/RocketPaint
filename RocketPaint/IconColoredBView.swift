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

    var iconColor:UIColor = UIColor.redColor();
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(IconColoredBView.colorSelected(_:)),
            name: Notifications.kColorSelected,
            object: nil)
        
    }
    
    func colorSelected(notification:NSNotification){
        iconColor = notification.object as! UIColor;
        self.setNeedsDisplay();
    }
    
}