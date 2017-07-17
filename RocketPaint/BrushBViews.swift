//
//  BrushBViews.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class BrushPenBView: IconColoredBView {
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawGPen(iconColor:iconColor);
    }
}

class BrushLineBView: IconColoredBView {
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawGLine(iconColor:iconColor);
    }
}

class BrushEllipseSolidBView: IconColoredBView {
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawGEllipseSolid(iconColor:iconColor);
    }
}
class BrushEllipseOutlineBView: IconColoredBView {
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawGEllipseOutline(iconColor:iconColor);
    }
}

class BrushRectSolidBView: IconColoredBView {
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawGRectSolid(iconColor:iconColor);
    }
}
class BrushRectOutlineBView: IconColoredBView {
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawGRectOutline(iconColor:iconColor);
    }
}


class BrushTextSerifBView: IconColoredBView {
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawGTextSerif(iconColor:iconColor);
    }
}
class BrushTextSansBView: IconColoredBView {
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawGTextSans(iconColor:iconColor);
    }
}

