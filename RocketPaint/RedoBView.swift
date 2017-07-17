//
//  RedoBView.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class RedoBView: BView {
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawRedo();
    }
}
