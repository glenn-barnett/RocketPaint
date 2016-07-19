//
//  BrushBViews.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class BrushWirePen1BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawPen1W(iconColor:iconColor);
    }
}
class BrushWirePen2BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawPen2W(iconColor:iconColor);
    }
}
class BrushWirePen3BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawPen3W(iconColor:iconColor);
    }
}
class BrushWirePen4BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawPen4W(iconColor:iconColor);
    }
}

class BrushWireLine1BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawLine1W(iconColor:iconColor);
    }
}
class BrushWireLine2BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawLine2W(iconColor:iconColor);
    }
}
class BrushWireLine3BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawLine3W(iconColor:iconColor);
    }
}
class BrushWireLine4BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawLine4W(iconColor:iconColor);
    }
}

class BrushWireBoxBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawBoxW(iconColor:iconColor);
    }
}
class BrushWireHighlightGreenBView: BView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawHighlightGreenW();
    }
}
class BrushWireHighlightYellowBView: BView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawHighlightYellowW();
    }
}
class BrushWireHighlightRedBView: BView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawHighlightRedW();
    }
}

class BrushWireTextSerifBigBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawTextSerifBigW(iconColor:iconColor);
    }
}
class BrushWireTextSerifSmallBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawTextSerifSmallW(iconColor:iconColor);
    }
}
class BrushWireTextSansBigBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawTextSansBigW(iconColor:iconColor);
    }
}
class BrushWireTextSansSmallBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawTextSansSmallW(iconColor:iconColor);
    }
}
