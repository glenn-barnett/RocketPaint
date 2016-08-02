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
        RocketPaintStyleKit.drawWPen(iconColor:iconColor, lineWidth: lineWidth);
    }
}
class BrushWireLineBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWLine(iconColor:iconColor, lineWidth: lineWidth);
    }
}


class BrushWireRectSolidBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWRectSolid(iconColor:iconColor);
    }
}
class BrushWireRectOutlineBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWRectOutline(iconColor:iconColor, lineWidth: lineWidth);
    }
}


class BrushWireEllipseSolidBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWEllipseSolid(iconColor:iconColor);
    }
}
class BrushWireEllipseOutlineBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWEllipseOutline(iconColor:iconColor, lineWidth: lineWidth);
    }
}


class BrushWireTextSerifBView: IconColoredBView {
    override func getLineWidthMax() -> Float {
        return 29.0
    }

    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWTextSerif(iconColor:iconColor, lineWidth: lineWidth);
    }
}
class BrushWireTextSansBView: IconColoredBView {
    override func getLineWidthMax() -> Float {
        return 28.0
    }

    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawWTextSans(iconColor:iconColor, lineWidth: lineWidth);
    }
}
