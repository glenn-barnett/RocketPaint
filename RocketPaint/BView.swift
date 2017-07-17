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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.4;
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
    override func touchesCancelled(_ touches: Set<UITouch>!, with event: UIEvent!) {
        self.alpha = self.disabled ? 0.2 : 1.0;
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = self.disabled ? 0.2 : 1.0;
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
