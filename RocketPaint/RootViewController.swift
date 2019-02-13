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

class RootViewController: RESideMenu, RESideMenuDelegate {

    var rightSideViewController : RightSideViewController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RootViewController.hideSideMenus(_:)),
            name: NSNotification.Name(rawValue: Notifications.kBrushChanged),
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RootViewController.photoLoaded(_:)),
            name: NSNotification.Name(rawValue: Notifications.kPhotoLoaded),
            object: nil)

//        NSNotificationCenter.defaultCenter().addObserver(
//            self,
//            selector: #selector(RootViewController.hideSideMenus(_:)),
//            name: Notifications.kCanvasCleared,
//            object: nil)

        self.parallaxEnabled = false
        self.contentViewShadowColor = UIColor.black
        self.contentViewShadowRadius = 30.0
        
        // Do any additional setup after loading the view.
    }
    
    @objc func hideSideMenus(_ notification:Notification){
        self.hideViewController()
    }
    @objc func photoLoaded(_ notification:Notification){
//        self.hideMenuViewController()
        let asset = notification.userInfo!["phAsset"] as! PHAsset

        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        options.isSynchronous = true

        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 768, height: 1024), contentMode:.aspectFit, options:options, resultHandler:{(image, info)in

            DrawingService.SharedInstance.loadImage0(image!);
            
            self.dismiss(animated: true, completion:nil)

        })
        
        
    }

    override func awakeFromNib() {
        
        self.menuPreferredStatusBarStyle = UIStatusBarStyle.lightContent
        self.contentViewShadowColor = UIColor.black;
        self.contentViewShadowOffset = CGSize(width: 0, height: 0);
        self.contentViewShadowOpacity = 0.6;
        self.contentViewShadowRadius = 12;
        self.contentViewShadowEnabled = true;
        
        self.panGestureEnabled = false;
        
        self.contentViewController = (self.storyboard?.instantiateViewController(withIdentifier: "PaintingViewController"))! as UIViewController
        
        rightSideViewController = (self.storyboard?.instantiateViewController(withIdentifier: "RightSideViewController"))! as? RightSideViewController;
        self.rightMenuViewController = rightSideViewController;

        AppDelegate.promptPhotoLibraryPermission(self)
        
        self.scaleContentView = false
//        self.contentViewScaleValue = 1.0
        self.contentViewInPortraitOffsetCenterX = 200.0
    }

    func showRightBrushes() {
//        self.contentViewInPortraitOffsetCenterX = 40.0

        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kRightMenuOpened),
            object: nil)

        self.presentRightMenuViewController();
    }


}
