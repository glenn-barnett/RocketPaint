//
//  ColorCell.swift
//  UICollectionView+Swift
//
//  Created by Mobmaxime on 14/08/14.
//  Copyright (c) 2014 Jigar M. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {
    @IBOutlet var CloseButton : UIButton?
    var Color : UIColor {
        didSet { self.setNeedsDisplay(); }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.Color = UIColor.redColor()
        super.init(coder:aDecoder)
        initializeStyle()
    }
    
    override required init(frame: CGRect) {
        self.Color = UIColor.redColor()
        super.init(frame:frame)
        initializeStyle()
    }
    
    func initializeStyle() {
//        self.contentView.layer.borderWidth = 2
//        self.contentView.layer.borderColor = UIColor.blackColor().CGColor
        
    }
    
    override func drawRect(rect: CGRect) {
        RocketPaintStyleKit.drawPaletteColor(paletteItemColor: self.Color)
    }
    
}