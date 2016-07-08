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

    var rightSideViewController : RightSideViewController?;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(RootViewController.brushChanged(_:)),
            name: Notifications.kBrushChanged,
            object: nil)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(RootViewController.colorSelected(_:)),
            name: Notifications.kColorSelected,
            object: nil)

        
        // Do any additional setup after loading the view.
    }
    
    func brushChanged(notification:NSNotification){
        self.hideMenuViewController()
    }
    func colorSelected(notification:NSNotification){
        self.hideMenuViewController()
    }
    
    override func awakeFromNib() {
        
        self.menuPreferredStatusBarStyle = UIStatusBarStyle.LightContent
        self.contentViewShadowColor = UIColor.blackColor();
        self.contentViewShadowOffset = CGSizeMake(0, 0);
        self.contentViewShadowOpacity = 0.6;
        self.contentViewShadowRadius = 12;
        self.contentViewShadowEnabled = true;
        
        self.contentViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("PaintingViewController"))! as UIViewController
        self.leftMenuViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("LeftSideViewController"))! as UIViewController
        
        rightSideViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("RightSideViewController"))! as! RightSideViewController;
        self.rightMenuViewController = rightSideViewController;

        
    }

    func showRightPalette() {
        rightSideViewController?.BrushView.hidden = true;
        rightSideViewController?.ColorPaletteView.hidden = false;
        self.presentRightMenuViewController();
    }

    func showRightBrushes() {
        rightSideViewController?.BrushView.hidden = false;
        rightSideViewController?.ColorPaletteView.hidden = true;
        self.presentRightMenuViewController();
    }

    // MARK: RESide Delegate Methods
    
//    func sideMenu(sideMenu: RESideMenu!, willShowMenuViewController menuViewController: UIViewController!) {
//        print("This will show the menu")
//    }
    

}
