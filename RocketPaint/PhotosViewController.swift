

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
    fileprivate let imageManager = PHCachingImageManager()
    var images : PHFetchResult<PHAsset> = PHFetchResult()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        imageManager = PHCachingImageManager()
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        images = PHAsset.fetchAssets(with: .image, options: fetchOptions) as! PHFetchResult<AnyObject> as! PHFetchResult<PHAsset>
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PhotosViewController.photoSaved(_:)),
            name: NSNotification.Name(rawValue: Notifications.kPhotoSaved),
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PhotosViewController.photosMenuOpened(_:)),
            name: NSNotification.Name(rawValue: Notifications.kLeftMenuOpened),
            object: nil)

    }
    
    func photosMenuOpened(_ notification:Notification) {
        self.collectionView?.reloadData()
        
    }
    
    func photoSaved(_ notification:Notification) {
        let time : DispatchTime = .now() + .milliseconds(500)
        let time2 : DispatchTime = .now() + .milliseconds(1000)
        
        DispatchQueue.main.asyncAfter(deadline: time) {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            self.images = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            self.collectionView?.reloadData()
        }

        DispatchQueue.main.asyncAfter(deadline: time2) {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            self.images = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            self.collectionView?.reloadData()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        hasAppeared = true
    }
    
    // handle tap events
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: Notifications.kPhotoLoaded),
                object: nil,
//                userInfo: ["phAsset": images.objectAtIndex(indexPath.item-1) as! PHAsset])
                userInfo: ["phAsset": images.object(at: indexPath.item) as! PHAsset])

            collectionView.setContentOffset(CGPoint.zero, animated: true)
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
    
    override func numberOfSections(in collectionView: UICollectionView?) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView?, numberOfItemsInSection section: Int) -> Int {
        return images.count // + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
        
        
            let cell : PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
            
            //let asset = images.objectAtIndex(indexPath.item-1) as! PHAsset
            let asset = images.object(at: indexPath.item) as! PHAsset

        
            let options = PHImageRequestOptions()
            options.isNetworkAccessAllowed = true
            options.isSynchronous = false

            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: 480, height: 640), contentMode:.aspectFit, options:options, resultHandler:{(image, info) in
                cell.ImageView?.contentMode = UIViewContentMode.scaleAspectFit
                cell.ImageView?.image = image
            })
            
            return cell
//        }
        
    }
    
}
