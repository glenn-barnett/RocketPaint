//
//  BrushBViews.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 6/29/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class BrushPen1BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawPen1(iconColor:iconColor);
    }
}
class BrushPen2BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawPen2(iconColor:iconColor);
    }
}
class BrushPen3BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawPen3(iconColor:iconColor);
    }
}
class BrushPen4BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawPen4(iconColor:iconColor);
    }
}

class BrushLine1BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawLine1(iconColor:iconColor);
    }
}
class BrushLine2BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawLine2(iconColor:iconColor);
    }
}
class BrushLine3BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawLine3(iconColor:iconColor);
    }
}
class BrushLine4BView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawLine4(iconColor:iconColor);
    }
}

class BrushBoxBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawBox(iconColor:iconColor);
    }
}
class BrushHighlightGreenBView: BView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawHighlightGreen();
    }
}
class BrushHighlightYellowBView: BView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawHighlightYellow();
    }
}
class BrushHighlightRedBView: BView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawHighlightRed();
    }
}

class BrushTextSerifBigBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawTextSerifBig(iconColor:iconColor);
    }
}
class BrushTextSerifSmallBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawTextSerifSmall(iconColor:iconColor);
    }
}
class BrushTextSansBigBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawTextSansBig(iconColor:iconColor);
    }
}
class BrushTextSansSmallBView: IconColoredBView {
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawTextSansSmall(iconColor:iconColor);
    }
}
