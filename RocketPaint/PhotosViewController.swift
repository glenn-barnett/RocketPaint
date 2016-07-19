

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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // handle tap events
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // signal to parents:
        //   leftside: close self
        //   root: bring up cropper (unless its a perfect fit already?)
        
        print("PhotosVC.didSelect(\(indexPath.item))")
        // do stuff on selection
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kImageLoaded,
            object: nil,
            userInfo: ["phAsset": images.objectAtIndex(indexPath.item) as! PHAsset])

        collectionView.setContentOffset(CGPointZero, animated: true)

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
        return images.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        /*
         We can use multiple way to create a UICollectionViewCell.
         */
        
        //1.
        //We can use Reusablecell identifier with custom UICollectionViewCell
        
        /*
         let cell = collectionView!.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
         
         */
        
        
        
        //2.
        //You can create a Class file for UICollectionViewCell and Set the appropriate component and assign the value to that class
        
        let cell : PhotoCell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        
        let asset = images.objectAtIndex(indexPath.item) as! PHAsset

        
        let options = PHImageRequestOptions()
        options.networkAccessAllowed = true
        options.synchronous = false

        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSize(width: 480, height: 640), contentMode:.AspectFit, options:options, resultHandler:{(image, info)in

//            print("PhotosVC RECEIVED image size \(image!.size.width) x \(image!.size.height)")

            cell.ImageView?.contentMode = UIViewContentMode.ScaleAspectFit
            cell.ImageView?.image = image
        })
        
        return cell
    }
    
}