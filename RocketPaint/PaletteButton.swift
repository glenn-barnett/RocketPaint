//
//  PaletteButton.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/30/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class PaletteButton: IconColoredButton {
    
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawPalette(iconColor:iconColor);
    }
}