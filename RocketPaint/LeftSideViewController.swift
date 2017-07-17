//
//  LeftSideViewController.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/1/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import UIKit
import RESideMenu

class LeftSideViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    @IBAction func savePictureTapped(_ sender : AnyObject) {
        // compose the image against the canvas color
        let composedImage = DrawingService.SharedInstance.getImageOnCanvasColor()
        
        CameraRollService.SharedInstance.WriteImage(composedImage)
        
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kPhotoSaved),
            object: nil)
        
    }
    
    @IBAction func loadPictureTapped(_ sender : AnyObject) {
        // TODO DEAD CODE
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func clearTapped(_ sender : AnyObject) {
        // TODO DEAD CODE
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kCanvasCleared),
            object: nil,
            userInfo: ["color": UIColor.white])
        
        DrawingService.SharedInstance.resetBrush()
    }

    @IBAction func clearColorTapped(_ sender : AnyObject) {
        // TODO DEAD CODE
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kCanvasCleared),
            object: nil,
            userInfo: ["color": ColorService.SharedInstance.selectedColor])
        
        // TODO DEAD CODE
        DrawingService.SharedInstance.resetBrush()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //            NSNotificationCenter.defaultCenter().postNotificationName(
            //                Notifications.kColorChanged,
            //                object: pickedImage)
            
            DrawingService.SharedInstance.loadImage0(pickedImage);
            let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? RESideMenu;
            
            dismiss(animated: true, completion: {
                rootViewController!.hideViewController();
            })
            

        } else {
            dismiss(animated: true, completion: nil)
        }
        
        
        
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

