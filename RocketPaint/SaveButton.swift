//
//  SaveButton.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class SaveButton: IconColoredButton {

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
    
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawSaveToPhotos();
    }
}