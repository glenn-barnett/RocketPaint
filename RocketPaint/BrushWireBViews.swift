//
//  BrushBViews.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit


class BrushWirePen3BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawPen3W(iconColor:iconColor);
    }
}
class BrushWireLine3BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawLine3W(iconColor:iconColor);
    }
}


class BrushWireRectSolidBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawRectSolidW(iconColor:iconColor);
    }
}
class BrushWireRectOutlineBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawRectOutlineW(iconColor:iconColor);
    }
}


class BrushWireEllipseSolidBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawEllipseSolidW(iconColor:iconColor);
    }
}
class BrushWireEllipseOutlineBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawEllipseOutlineW(iconColor:iconColor);
    }
}


class BrushWireTextSerifBigBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawTextSerifBigW(iconColor:iconColor);
    }
}
class BrushWireTextSansBigBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawTextSansBigW(iconColor:iconColor);
    }
}
