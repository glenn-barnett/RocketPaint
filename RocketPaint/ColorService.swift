//
//  ColorService
//  RocketPaint
//
//  Created by Glenn Barnett on 7/2/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

open class ColorService {
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
    internal var selectedColor: UIColor = UIColor.black
    internal var canvasColor: UIColor = UIColor.white
    internal var sessionColorArray: [UIColor] = []
    internal var variantColorArray: [UIColor] = []
    internal var staticColorArray: [UIColor] = []
    internal var randomColorArray: [UIColor] = []

    init() {
        staticColorArray.append(UIColor.white)
        staticColorArray.append(UIColor.gray)
        staticColorArray.append(UIColor.black)

        staticColorArray.append(UIColor(red: 141.0/255.0, green:94.0/255.0, blue:48.0/255.0, alpha:1))
        staticColorArray.append(UIColor(red: 70.0/255.0, green:141.0/255.0, blue:38.0/255.0, alpha:1))
        staticColorArray.append(UIColor(red: 38.0/255.0, green:62.0/255.0, blue:141.0/255.0, alpha:1))

        staticColorArray.append(UIColor(red: 255.0/255.0, green:99.0/255.0, blue:54.0/255.0, alpha:1))
        staticColorArray.append(UIColor(red: 105.0/255.0, green:175.0/255.0, blue:32.0/255.0, alpha:1))
        staticColorArray.append(UIColor(red: 59.0/255.0, green:100.0/255.0, blue:255.0/255.0, alpha:1))

        staticColorArray.append(UIColor(red: 255.0/255.0, green:196.0/255.0, blue:77.0/255.0, alpha:1))
        staticColorArray.append(UIColor(red: 44.0/255.0, green:204.0/255.0, blue:128.0/255.0, alpha:1))
        staticColorArray.append(UIColor(red: 200.0/255.0, green:81.0/255.0, blue:255.0/255.0, alpha:1))

        staticColorArray.append(UIColor(red: 255.0/255.0, green:234.0/255.0, blue:77.0/255.0, alpha:1))
        staticColorArray.append(UIColor(red: 44.0/255.0, green:186.0/255.0, blue:204.0/255.0, alpha:1))
        staticColorArray.append(UIColor(red: 255.0/255.0, green:81.0/255.0, blue:172.0/255.0, alpha:1))
        
        for i in 0 ..< 1000 {
            randomColorArray.append(generateRandomColor())
        }
   
    }
    
    internal func defaultPaintColor() -> UIColor {
        return UIColor(red: 59.0/255.0, green:100.0/255.0, blue:255.0/255.0, alpha:1.0)
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
    
    internal func updateVariants() {
        // first, clear the old variants
        variantColorArray.removeAll()
        
        // second, extract the selected color into components
        var srcHue: CGFloat = 0
        var srcSaturation: CGFloat = 0
        var srcBrightness: CGFloat = 0
        var srcAlpha: CGFloat = 0
        selectedColor.getHue(&srcHue, saturation: &srcSaturation, brightness: &srcBrightness, alpha: &srcAlpha)
        
        if(srcSaturation == 0) {
            for b in (1..<7) {
                for s in (-1..<2) {
                    let newBrightness: CGFloat = 0.17 * CGFloat(b) + 0.05 * CGFloat(s)
                    variantColorArray.append(UIColor(hue:CGFloat(Float(arc4random()) / Float(UINT32_MAX)), saturation:0, brightness:newBrightness, alpha:1))
                }
            }
        } else {
            
            // third, create saturation variants from 0% to 100% in 8 steps
            //        for(var i=0.0f; i<7.5f; i+=1.0f) {
            for b in (1..<7) {
                for s in (-1..<2) {
                    // saturation will be 0-1.0, scaled by source saturation x1.5
                    let newSaturation: CGFloat = max(0.0, min(1.0, srcSaturation + 0.25 * CGFloat(s)))
                    // brightness WANT 0.2 0.3 0.5 0.7 0.9
                    let newBrightness: CGFloat = max(0.17, 0.17 * CGFloat(b) - 0.10)
                    variantColorArray.append(UIColor(hue:srcHue, saturation:newSaturation, brightness:newBrightness, alpha:1))
                }
            }
        }
        
    }

}

