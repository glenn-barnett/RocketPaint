//
//  HamburgerBView.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class HamburgerBView: BView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawHamburger();
    }
}