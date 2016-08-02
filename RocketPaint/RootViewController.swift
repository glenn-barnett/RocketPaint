//
//  RootViewController.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/1/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import Foundation
import RESideMenu
import Photos
import TOCropViewController

class RootViewController: RESideMenu, RESideMenuDelegate, TOCropViewControllerDelegate {

    var rightSideViewController : RightSideViewController?;
    

    override func viewDidLoad() {
        print("RVC.viewDidLoad()")
        super.viewDidLoad()
        
//        NSNotificationCenter.defaultCenter().addObserver(
//            self,
//            selector: #selector(RootViewController.hideSideMenus(_:)),
//            name: Notifications.kBrushChanged,
//            object: nil)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(RootViewController.photoLoaded(_:)),
            name: Notifications.kPhotoLoaded,
            object: nil)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(RootViewController.hideSideMenus(_:)),
            name: Notifications.kCanvasCleared,
            object: nil)

        self.parallaxEnabled = false
        self.contentViewShadowColor = UIColor.blackColor()
        self.contentViewShadowRadius = 30.0
        
        // Do any additional setup after loading the view.
    }
    
    func hideSideMenus(notification:NSNotification){
        self.hideMenuViewController()
    }
    func photoLoaded(notification:NSNotification){
        self.hideMenuViewController()
        let asset = notification.userInfo!["phAsset"] as! PHAsset

        let options = PHImageRequestOptions()
        options.networkAccessAllowed = true
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.HighQualityFormat
        options.synchronous = true

        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSize(width: 768, height: 1024), contentMode:.AspectFit, options:options, resultHandler:{(image, info)in

            let cvc = TOCropViewController(image:image)
            cvc.delegate = self
            
            cvc.aspectRatioPreset = .PresetCustom
            cvc.customAspectRatio = CGSize(width: 768, height: 1024)
            cvc.aspectRatioLockEnabled = true
            cvc.rotateClockwiseButtonHidden = false
            cvc.aspectRatioPickerButtonHidden = true
            
            self.presentViewController(cvc, animated: true, completion: nil)

        })
        
        
    }

    func cropViewController(cropViewController: TOCropViewController!, didCropToImage image: UIImage!, withRect cropRect: CGRect, angle: Int) {
        
        DrawingService.SharedInstance.loadImage0(image);
        
        dismissViewControllerAnimated(true, completion:nil)
    }

    override func awakeFromNib() {
        print("RVC.awakeFromNib()")
        
        self.menuPreferredStatusBarStyle = UIStatusBarStyle.LightContent
        self.contentViewShadowColor = UIColor.blackColor();
        self.contentViewShadowOffset = CGSizeMake(0, 0);
        self.contentViewShadowOpacity = 0.6;
        self.contentViewShadowRadius = 12;
        self.contentViewShadowEnabled = true;
        
        self.panGestureEnabled = false;
        
        self.contentViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("PaintingViewController"))! as UIViewController
        self.leftMenuViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("LeftSideViewController"))! as UIViewController
        
        rightSideViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("RightSideViewController"))! as? RightSideViewController;
        self.rightMenuViewController = rightSideViewController;

        
    }

    func showRightBrushes() {
        self.presentRightMenuViewController();
    }

    func showLeftMenu() {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kPhotosMenuOpened,
            object: nil)
        self.presentLeftMenuViewController();
    }

    // MARK: RESide Delegate Methods
    
//    func sideMenu(sideMenu: RESideMenu!, willShowMenuViewController menuViewController: UIViewController!) {
//        print("This will show the menu")
//    }
    

}
