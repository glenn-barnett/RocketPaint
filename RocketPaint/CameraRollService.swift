//
//  CameraRollService.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/2/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import UIKit

class CameraRollService {
    static let SharedInstance = CameraRollService()
    
    //CameraRollService.SharedInstance.WriteImage(image)
    
    func WriteImage(image : UIImage) {
        
        // GB TODO what are these 3 nils?
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

}

