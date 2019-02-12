//
//  Notifications.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 5/3/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation


struct Notifications {
    static let kBrushChanged = "kBrushChanged"
    static let kLineWidthChanged = "kLineWidthChanged"
    static let kLineAlphaChanged = "kLineAlphaChanged"

    static let kColorChanged = "kColorChanged"
    static let kColorUsed = "kColorUsed"
    static let kColorPaletteClosed = "kColorPaletteClosed" // to reset scroll pos to top
    
    static let kCanvasCleared = "kCanvasCleared"
    static let kPhotoLoaded = "kPhotoLoaded"
    static let kPhotoSaved = "kPhotoSaved" // to reload data and reset scroll pos to top

    static let kRightMenuOpened = "kRightMenuOpened" // to reset clear canvas icon to white
}

