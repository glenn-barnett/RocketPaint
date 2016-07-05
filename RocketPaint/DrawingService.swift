//
//  DraingService
//  RocketPaint
//
//  Created by Glenn Barnett on 7/2/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class DrawingService {
    static let SharedInstance = DrawingService()
    
    var drawingViews : [RocketDrawingView] = [];
    
    func addDrawingView(drawingView : RocketDrawingView) {
        drawingViews.append(drawingView)
    }
    
    func loadImage0(image : UIImage) {
        drawingViews[0].drawMode = .Scale;
        drawingViews[0].loadImage(image);
    }
    
    func getImage() -> UIImage {
        return drawingViews[0].image;
    }

}

