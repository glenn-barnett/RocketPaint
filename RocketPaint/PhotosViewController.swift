

//
//  CameraRollImageViewController.swift
//  UICollectionView+Swift
//
//  Created by Mobmaxime on 14/08/14.
//  Copyright (c) 2014 Jigar M. All rights reserved.
//

import UIKit
import Photos

let imageReuseIdentifier = "PhotoCell"

class PhotosViewController: UICollectionViewController
{
    var imageManager : PHCachingImageManager!
    var images : PHFetchResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageManager = PHCachingImageManager()
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        images = PHAsset.fetchAssetsWithMediaType(.Image, options: fetchOptions)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(PhotosViewController.photoSaved(_:)),
            name: Notifications.kPhotoSaved,
            object: nil)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(PhotosViewController.photosMenuOpened(_:)),
            name: Notifications.kPhotosMenuOpened,
            object: nil)

    }
    
    func photosMenuOpened(notification:NSNotification) {
        self.collectionView?.reloadData()
        
    }
    
    func photoSaved(notification:NSNotification) {
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 500 * Int64(NSEC_PER_MSEC))
        let time2 = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1000 * Int64(NSEC_PER_MSEC))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            self.images = PHAsset.fetchAssetsWithMediaType(.Image, options: fetchOptions)
            self.collectionView?.reloadData()
        }

        dispatch_after(time2, dispatch_get_main_queue()) {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            self.images = PHAsset.fetchAssetsWithMediaType(.Image, options: fetchOptions)
            self.collectionView?.reloadData()
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        hasAppeared = true
    }
    
    // handle tap events
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // signal to parents:
        //   leftside: close self
        //   root: bring up cropper (unless its a perfect fit already?)
                
//        if(indexPath.item == 0) {
//            if(DrawingService.SharedInstance.isModified) { // don't write if there's no image
//                print("PhotosVC.didSelect(\(indexPath.item)): Saving current canvas to camera roll")
//                // compose the image against the canvas color
//                let composedImage = DrawingService.SharedInstance.getImageOnCanvasColor()
//                
//                CameraRollService.SharedInstance.WriteImage(composedImage)
//                
//                NSNotificationCenter.defaultCenter().postNotificationName(
//                    Notifications.kPhotoSaved,
//                    object: nil)
//            }
//            return
//            
//        } else {
//        
            NSNotificationCenter.defaultCenter().postNotificationName(
                Notifications.kPhotoLoaded,
                object: nil,
//                userInfo: ["phAsset": images.objectAtIndex(indexPath.item-1) as! PHAsset])
                userInfo: ["phAsset": images.objectAtIndex(indexPath.item) as! PHAsset])

            collectionView.setContentOffset(CGPointZero, animated: true)
//        }
    }
    
    /*
     // #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // #pragma mark UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView?) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView?, numberOfItemsInSection section: Int) -> Int {
        return images.count // + 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
//        if(indexPath.item == 0) {
//            // special case for [+] row
//            // overlay current canvas image with a +
//
//            let cell : PhotoCell = collectionView.dequeueReusableCellWithReuseIdentifier("SaveNewCell", forIndexPath: indexPath) as! PhotoCell
//            
//            cell.ImageView?.contentMode = UIViewContentMode.ScaleAspectFit
//            if(DrawingService.SharedInstance.isModified) {
//                cell.ImageView?.image = DrawingService.SharedInstance.getImageOnCanvasColor()
//            }
//            
//            return cell
//        } else {
        
        
            let cell : PhotoCell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
            
            //let asset = images.objectAtIndex(indexPath.item-1) as! PHAsset
            let asset = images.objectAtIndex(indexPath.item) as! PHAsset

        
            let options = PHImageRequestOptions()
            options.networkAccessAllowed = true
            options.synchronous = false

            PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSize(width: 480, height: 640), contentMode:.AspectFit, options:options, resultHandler:{(image, info) in
                cell.ImageView?.contentMode = UIViewContentMode.ScaleAspectFit
                cell.ImageView?.image = image
            })
            
            return cell
//        }
        
    }
    
}