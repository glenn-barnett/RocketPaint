

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
    let colorService : ColorService = ColorService.SharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // handle tap events
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // pull the color from the cell
        // blow away the canvas
        // make sure undo works!

        // do stuff on selection
        let cell : UICollectionViewCell = self.collectionView!.cellForItem(at: indexPath)!
        
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: Notifications.kCanvasCleared),
            object: nil,
            userInfo: ["color": cell.backgroundColor!])

        DrawingService.SharedInstance.resetBrush()
        
        // reset to top of list
        collectionView.setContentOffset(CGPoint.zero, animated: true)

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
        return colorService.staticColorArray.count + colorService.randomColorArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /*
         We can use multiple way to create a UICollectionViewCell.
         */
        
        //1.
        //We can use Reusablecell identifier with custom UICollectionViewCell
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlankCanvasCell", for: indexPath) as UICollectionViewCell

        if(indexPath.item < colorService.staticColorArray.count) {
            cell.backgroundColor = colorService.staticColorArray[indexPath.item];
        } else {
            cell.backgroundColor = colorService.randomColorArray[indexPath.item - colorService.staticColorArray.count]
        }
        
        //2.
        //You can create a Class file for UICollectionViewCell and Set the appropriate component and assign the value to that class
        
        
        return cell
    }
    
}
