

//
//  BlankCanvasesViewController.swift
//  UICollectionView+Swift
//
//  Created by Mobmaxime on 14/08/14.
//  Copyright (c) 2014 Jigar M. All rights reserved.
//

import UIKit

let canvasReuseIdentifier = "BlankCanvasCell"

class BlankCanvasesViewController: UICollectionViewController
{
    
    var canvasColorArray: [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // seed the list
        canvasColorArray.append(UIColor.whiteColor())
        canvasColorArray.append(UIColor.grayColor())
        canvasColorArray.append(UIColor.blackColor())
        canvasColorArray.append(UIColor.blueColor())
        canvasColorArray.append(UIColor.cyanColor())
        canvasColorArray.append(UIColor.greenColor())
        canvasColorArray.append(UIColor.yellowColor())
        canvasColorArray.append(UIColor.orangeColor())
        canvasColorArray.append(UIColor.redColor())
        canvasColorArray.append(UIColor.purpleColor())
        
    }
    
    // handle tap events
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        // pull the color from the cell
        // blow away the canvas
        // make sure undo works!

        print("BlankCanvasesVC.didSelect(\(indexPath.item))")

        // do stuff on selection
        let cell : UICollectionViewCell = self.collectionView!.cellForItemAtIndexPath(indexPath)!
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kCanvasCleared,
            object: nil,
            userInfo: ["color": cell.backgroundColor!])

        // reset to top of list
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
        return canvasColorArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        /*
         We can use multiple way to create a UICollectionViewCell.
         */
        
        //1.
        //We can use Reusablecell identifier with custom UICollectionViewCell
        
         let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BlankCanvasCell", forIndexPath: indexPath) as UICollectionViewCell

        cell.backgroundColor = canvasColorArray[indexPath.item];
        
        //2.
        //You can create a Class file for UICollectionViewCell and Set the appropriate component and assign the value to that class
        
        
        return cell
    }
    
}