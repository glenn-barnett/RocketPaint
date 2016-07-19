//
//  ColorCell.swift
//  UICollectionView+Swift
//
//  Created by Mobmaxime on 14/08/14.
//  Copyright (c) 2014 Jigar M. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet var ImageView : UIImageView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override required init(frame: CGRect) {
        super.init(frame:frame)
    }
    
//    override func drawRect(rect: CGRect) {
//        RocketPaintStyleKit.drawPaletteColor(paletteItemColor: self.Color)
//    }
    
}