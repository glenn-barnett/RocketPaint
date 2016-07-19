//
//  ColorService
//  RocketPaint
//
//  Created by Glenn Barnett on 7/2/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

public class ColorService {
    static let SharedInstance = ColorService()

//    public var itemSize: CGSize {
//        get {
//            return _itemSize
//        }
//        didSet {
//            // do stuff
//        }
//    }

    var lastAlpha: Float = 1.0
    var selectedColor: UIColor = UIColor.blackColor()
    var sessionColorArray: [UIColor] = []
    var variantColorArray: [UIColor] = []
    var staticColorArray: [UIColor] = []
    var randomColorArray: [UIColor] = []

    internal func defaultPaintColor() -> UIColor {
        
        return UIColor(red: 250.0/255.0, green: 187.0/255.0, blue: 35.0/255.0, alpha: 1.0)
    }

}

