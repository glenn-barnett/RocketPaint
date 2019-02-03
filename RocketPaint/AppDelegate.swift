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
    
    
    //TODO move these out, and use the natural way of passing functions
    static func promptOverwriteWithPhoto(_ vc: UIViewController) {
        
        let alertTitle = "Load a photo?"
        
        let alertMessage = "Selecting a photo to load will overwrite your work"
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let destructiveAction = UIAlertAction(title: "Overwrite", style: .destructive) { (action) in
            // ...
        }
        alertController.addAction(destructiveAction)
        
        vc.present(alertController, animated: true) { }
        // post notif - CONFIRM_OVERWRITE
    }
    
    static func promptClearCanvas(_ vc: UIViewController) {
        
        let alertTitle = "Clear your canvas?"
        
        let alertMessage = "To erase your work, choose \"Erase\".\nTo keep your work, choose \"Cancel\""
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let destructiveAction = UIAlertAction(title: "Erase", style: .destructive) { (action) in
            // ...
        }
        alertController.addAction(destructiveAction)
        
        vc.present(alertController, animated: true) { }
        // post notif - CONFIRM_OVERWRITE
    }
    
    static func promptPhotoLibraryPermission(_ vc: UIViewController) {

        let userDefaults = UserDefaults.standard
        
        if UserDefaults.standard.bool(forKey: "never_ask_photo_permissions") {
            return;
        }

        let mustEnableController = UIAlertController(title: "Rocket Paint needs to access Photos", message: "To save and load, you must enable photos access.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Not right now", style: .cancel) { (action) in
            // ...
        }
        mustEnableController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK, show me where to enable it", style: .default) { (action) in
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
            }
        }
        mustEnableController.addAction(OKAction)
        
        let dontAskAction = UIAlertAction(title: "Don't ask again", style: .destructive) { (action) in
            // ...
            // write something to settings that aborts us out.  check it at top
            userDefaults.set(true, forKey: "never_ask_photo_permissions")
            userDefaults.synchronize()
        }
        mustEnableController.addAction(dontAskAction)
        
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            break;
        case .denied, .restricted :
            vc.present(mustEnableController, animated: true) { }
            break;
        case .notDetermined:
            // ask for permissions
            PHPhotoLibrary.requestAuthorization() { (status) -> Void in
                switch status {
                case .authorized:
                    break;
                // as above
                case .denied, .restricted:
                    vc.present(mustEnableController, animated: true) { }
                    break;
                // as above
                case .notDetermined:
                    // won't happen but still
                    break;
                }
            }
        }
    }
    

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        application.isStatusBarHidden = true
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        DrawingService.SharedInstance.persistState()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

