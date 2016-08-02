//
//  CheckerOverlayView.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 8/1/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation

import UIKit

class TiledImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let imageToTile = self.image
        
        let tiledColor = UIColor(patternImage:imageToTile!)
        
        self.backgroundColor = tiledColor
        
    }
}