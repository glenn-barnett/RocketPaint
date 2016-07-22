//
//  BrushBViews.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit


class BrushWirePenBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWPen(iconColor:iconColor);
    }
}
class BrushWireLineBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWLine(iconColor:iconColor);
    }
}


class BrushWireRectSolidBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWRectSolid(iconColor:iconColor);
    }
}
class BrushWireRectOutlineBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWRectOutline(iconColor:iconColor);
    }
}


class BrushWireEllipseSolidBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWEllipseSolid(iconColor:iconColor);
    }
}
class BrushWireEllipseOutlineBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWEllipseOutline(iconColor:iconColor);
    }
}


class BrushWireTextSerifBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWTextSerif(iconColor:iconColor);
    }
}
class BrushWireTextSansBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWTextSans(iconColor:iconColor);
    }
}
