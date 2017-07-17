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
    override func getLineWidthMax() -> Float {
        return 25.0
    }
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawWPen(iconColor:iconColor, lineWidth: lineWidth);
    }
}
class BrushWireLineBView: IconColoredBView {
    override func getLineWidthMax() -> Float {
        return 25.0
    }
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawWLine(iconColor:iconColor, lineWidth: lineWidth);
    }
}


class BrushWireRectSolidBView: IconColoredBView {
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawWRectSolid(iconColor:iconColor);
    }
}
class BrushWireRectOutlineBView: IconColoredBView {
    override func getLineWidthMax() -> Float {
        return 24.0
    }
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawWRectOutline(iconColor:iconColor, lineWidth: lineWidth);
    }
}


class BrushWireEllipseSolidBView: IconColoredBView {
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawWEllipseSolid(iconColor:iconColor);
    }
}
class BrushWireEllipseOutlineBView: IconColoredBView {
    override func getLineWidthMax() -> Float {
        return 24.0
    }
    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawWEllipseOutline(iconColor:iconColor, lineWidth: lineWidth);
    }
}


class BrushWireTextSerifBView: IconColoredBView {
    override func getLineWidthMin() -> Float {
        return 5.0
    }
    override func getLineWidthMax() -> Float {
        return 20.0
    }

    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawWTextSerif(iconColor:iconColor, lineWidth: lineWidth);
    }
}
class BrushWireTextSansBView: IconColoredBView {
    override func getLineWidthMin() -> Float {
        return 5.0
    }
    override func getLineWidthMax() -> Float {
        return 20.0
    }

    override func draw(_ rect: CGRect) {
        RocketPaintStyleKit.drawWTextSans(iconColor:iconColor, lineWidth: lineWidth);
    }
}
