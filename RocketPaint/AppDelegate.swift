//
//  AppDelegate.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 4/16/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import UIKit
import Photos

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let timerService = TimerService.SharedInstance

    
    static func promptPhotoLibraryPermission(vc: UIViewController) {
        
        
        let mustEnableController = UIAlertController(title: "Rocket Paint needs to access Photos", message: "To save and load, you must enable photos access.", preferredStyle: .Alert)
        
        let dontAskAction = UIAlertAction(title: "Don't Ask Again", style: .Destructive) { (action) in
            // ...
        }
        mustEnableController.addAction(dontAskAction)
        
        let cancelAction = UIAlertAction(title: "No Thanks", style: .Cancel) { (action) in
            // ...
        }
        mustEnableController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Enable", style: .Default) { (action) in
            print("Appdel: enable")
            UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
        }
        mustEnableController.addAction(OKAction)
        
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .Authorized:
            break;
        //handle authorized status
        case .Denied, .Restricted :
            //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            vc.presentViewController(mustEnableController, animated: true) { }
            break;
        case .NotDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization() { (status) -> Void in
                switch status {
                case .Authorized:
                    break;
                // as above
                case .Denied, .Restricted:
                    vc.presentViewController(mustEnableController, animated: true) { }
                    break;
                // as above
                case .NotDetermined:
                    // won't happen but still
                    break;
                }
            }
        }
    }
    

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        application.statusBarHidden = true
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        print("AppDel: appWillResignActive(): persisting state")
        DrawingService.SharedInstance.persistState()
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

