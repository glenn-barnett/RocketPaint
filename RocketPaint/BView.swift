//
//  BView.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/2/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable 
class BView : UIView {

    var disabled = false;
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.alpha = 0.4;
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {}
    override func touchesCancelled(touches: Set<UITouch>!, withEvent event: UIEvent!) {
        self.alpha = self.disabled ? 0.2 : 1.0;
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.alpha = self.disabled ? 0.2 : 1.0;
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}