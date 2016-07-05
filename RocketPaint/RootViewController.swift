//
//  RootViewController.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/1/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import RESideMenu

class RootViewController: RESideMenu, RESideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib() {
        
        self.menuPreferredStatusBarStyle = UIStatusBarStyle.LightContent
        self.contentViewShadowColor = UIColor.blackColor();
        self.contentViewShadowOffset = CGSizeMake(0, 0);
        self.contentViewShadowOpacity = 0.6;
        self.contentViewShadowRadius = 12;
        self.contentViewShadowEnabled = true;
        
        self.contentViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("PaintingViewController"))! as UIViewController
        self.leftMenuViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("LeftMenuViewController"))! as UIViewController
        
    }
    
    // MARK: RESide Delegate Methods
    
    func sideMenu(sideMenu: RESideMenu!, willShowMenuViewController menuViewController: UIViewController!) {
        print("This will show the menu")
    }

}
