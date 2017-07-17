//
//  NSUserDefaults+extensions.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/25/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

extension UserDefaults {
    
    func imageForKey(_ key: String) -> UIImage? {
        var image: UIImage?
        if let imageData = data(forKey: key) {
            image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage
        }
        return image
    }
    
    func setImage(_ image: UIImage?, forKey key: String) {
        var imageData: Data?
        if let image = image {
            imageData = NSKeyedArchiver.archivedData(withRootObject: image)
        }
        set(imageData, forKey: key)
    }
    
}
