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

    internal var lastAlpha: Float = 1.0
    internal var selectedColor: UIColor = UIColor.blackColor()
    internal var sessionColorArray: [UIColor] = []
    internal var variantColorArray: [UIColor] = []
    internal var staticColorArray: [UIColor] = []
    internal var randomColorArray: [UIColor] = []

    internal func defaultPaintColor() -> UIColor {
        return UIColor(red: 250.0/255.0, green: 187.0/255.0, blue: 35.0/255.0, alpha: 1.0)
    }

    internal func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        //        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        //        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        // GB: wider range
        let saturation : CGFloat = CGFloat(arc4random() % 192) / 256 + 0.25 //
        let brightness : CGFloat = CGFloat(arc4random() % 192) / 256 + 0.25 //
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }

}

