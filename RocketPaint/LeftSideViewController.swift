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
        print("LMVC.savePictureTapped()");
        
        
        // compose the image against the canvas color
        let drawingImage = DrawingService.SharedInstance.getImage()
        let canvasColor = ColorService.SharedInstance.canvasColor
        
        let rect = CGRect(x:0, y:0, width:768, height:1024)
        let size = CGSize(width: 768, height: 1024)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        canvasColor.setFill()
        UIRectFill(rect)
        drawingImage.drawInRect(rect)

        let composedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        CameraRollService.SharedInstance.WriteImage(composedImage)
        
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
            print("LeftSide.imagePicker(): GOT NO IMAGE")
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

