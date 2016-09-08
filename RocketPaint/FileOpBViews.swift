//
//  LoadBView.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class LoadBView: BView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawLoadFromPhotos();
    }
}

class SaveBView: BView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawSaveToPhotos();
    }
}

class ClearCanvasBView: BView {
    var iconColor:UIColor = UIColor.whiteColor()

    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawClearCanvas(iconColor: iconColor);
    }
}

class ClearBView: BView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawClearWhite();
    }
}

class ClearColorBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawClearColor(iconColor: iconColor);
    }
}