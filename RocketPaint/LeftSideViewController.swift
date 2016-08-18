//
//  LeftSideViewController.swift
//  RocketPaint
//
//  Created by Glenn Barnett on 7/1/16.
//  Copyright © 2016 Glenn Barnett. All rights reserved.
//

import UIKit
import RESideMenu
import TOCropViewController

class LeftSideViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TOCropViewControllerDelegate {
    
    @IBOutlet var CheckerOverlayView: UIView!

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self // GB REMOVE
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePictureTapped(sender : AnyObject) {
        // compose the image against the canvas color
        let composedImage = DrawingService.SharedInstance.getImageOnCanvasColor()
        
        CameraRollService.SharedInstance.WriteImage(composedImage)
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kPhotoSaved,
            object: nil)
        
    }
    
    @IBAction func loadPictureTapped(sender : AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func clearTapped(sender : AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kCanvasCleared,
            object: nil,
            userInfo: ["color": UIColor.whiteColor()])
        
        DrawingService.SharedInstance.resetBrush()
    }

    @IBAction func clearColorTapped(sender : AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kCanvasCleared,
            object: nil,
            userInfo: ["color": ColorService.SharedInstance.selectedColor])
        
        DrawingService.SharedInstance.resetBrush()
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //            NSNotificationCenter.defaultCenter().postNotificationName(
            //                Notifications.kColorChanged,
            //                object: pickedImage)
            
            //DrawingService.SharedInstance.loadImage0(pickedImage);
            
            let cvc = TOCropViewController(image:pickedImage)
            cvc.delegate = self
            
            cvc.aspectRatioPreset = .PresetCustom
            cvc.customAspectRatio = CGSize(width: 768, height: 1024)
            cvc.aspectRatioLockEnabled = true
            cvc.rotateClockwiseButtonHidden = false
            cvc.aspectRatioPickerButtonHidden = true
            
            dismissViewControllerAnimated(true, completion: {
                self.presentViewController(cvc, animated: true, completion: nil)
            })
            
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        
    }

    func cropViewController(cropViewController: TOCropViewController!, didCropToImage image: UIImage!, withRect cropRect: CGRect, angle: Int) {

        DrawingService.SharedInstance.loadImage0(image);
        let rootViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? RESideMenu;

        dismissViewControllerAnimated(true, completion: {
            rootViewController!.hideMenuViewController();
        })
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

