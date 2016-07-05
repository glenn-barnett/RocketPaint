//
//  LeftMenuViewController.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/1/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import UIKit
import RESideMenu

class LeftMenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func savePictureTapped(sender : AnyObject) {
        print("LMVC.savePictureTapped()");
        
        CameraRollService.SharedInstance.WriteImage(DrawingService.SharedInstance.getImage())
        
    }

    @IBAction func loadPictureTapped(sender : AnyObject) {
        print("LMVC().loadPictureTapped()");
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            NSNotificationCenter.defaultCenter().postNotificationName(
//                Notifications.kColorSelected,
//                object: pickedImage)
            
            DrawingService.SharedInstance.loadImage0(pickedImage);
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
        let rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? RESideMenu;
        
        rootViewController!.hideMenuViewController();

    }

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
