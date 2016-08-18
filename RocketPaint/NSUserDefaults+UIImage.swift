//
//  NSUserDefaults+extensions.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/25/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

extension NSUserDefaults {
    
    func imageForKey(key: String) -> UIImage? {
        var image: UIImage?
        if let imageData = dataForKey(key) {
            image = NSKeyedUnarchiver.unarchiveObjectWithData(imageData) as? UIImage
        }
        return image
    }
    
    func setImage(image: UIImage?, forKey key: String) {
        var imageData: NSData?
        if let image = image {
            imageData = NSKeyedArchiver.archivedDataWithRootObject(image)
        }
        setObject(imageData, forKey: key)
    }
    
}