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
    internal var canvasColor: UIColor = UIColor.whiteColor()
    internal var sessionColorArray: [UIColor] = []
    internal var variantColorArray: [UIColor] = []
    internal var staticColorArray: [UIColor] = []
    internal var randomColorArray: [UIColor] = []

    init() {
        staticColorArray.append(UIColor.whiteColor())
        staticColorArray.append(UIColor.grayColor())
        staticColorArray.append(UIColor.blackColor())
        staticColorArray.append(UIColor.blueColor())
        staticColorArray.append(UIColor.cyanColor())
        staticColorArray.append(UIColor.greenColor())
        staticColorArray.append(UIColor.yellowColor())
        staticColorArray.append(UIColor.orangeColor())
        staticColorArray.append(UIColor.redColor())
        staticColorArray.append(UIColor.purpleColor())
        
        for(var i=0; i<1000; i++) {
            randomColorArray.append(generateRandomColor())
        }
   
    }
    
    internal func defaultPaintColor() -> UIColor {
        return UIColor(red: 6.0/255.0, green: 6.0/255.0, blue: 138.0/255.0, alpha: 1.0)
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
            for(var b=1; b<=5; b++) {
                for(var s=0-1; s<=1; s++) {
                    // brightness will be 0.2-1.0
                    let newBrightness: CGFloat = 0.20 * CGFloat(b) + 0.05 * CGFloat(s)
                    variantColorArray.append(UIColor(hue:CGFloat(Float(arc4random()) / Float(UINT32_MAX)), saturation:0, brightness:newBrightness, alpha:1))
                }
            }
        } else {
            
            // third, create saturation variants from 0% to 100% in 8 steps
            //        for(var i=0.0f; i<7.5f; i+=1.0f) {
            for(var b=1; b<=5; b++) {
                for(var s=2; s<=4; s++) {
                    // saturation will be 0-1.0, scaled by source saturation x1.5
                    let newSaturation: CGFloat = (0.25 * CGFloat(s) - 0.25) * min(1.0, srcSaturation * 1.5)
                    // brightness will be 0.2-1.0
                    let newBrightness: CGFloat = 0.20 * CGFloat(b) - 0.10
                    variantColorArray.append(UIColor(hue:srcHue, saturation:newSaturation, brightness:newBrightness, alpha:1))
                }
            }
        }
        
    }

}

