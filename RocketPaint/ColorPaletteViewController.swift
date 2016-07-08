//
//  ColorPaletteViewController.swift
//  UICollectionView+Swift
//
//  Created by Mobmaxime on 14/08/14.
//  Copyright (c) 2014 Jigar M. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

// o convert to sections with supplemental headers:   "Favorites", "Variants", "Basics", "Explore"
// load/save pic

class ColorPaletteViewController: UICollectionViewController
{
    
    var selectedColor: UIColor = UIColor.blackColor()
    var sessionColorArray: [UIColor] = []
    var variantColorArray: [UIColor] = []
    var staticColorArray: [UIColor] = []
    var randomColorArray: [UIColor] = []
   
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("ColorPalette: touchesBegan()")
    }

    //UNUSED
    @IBAction func EditAlbumPressed(sender : AnyObject) {
        
        if(self.navigationItem.rightBarButtonItem?.title == "Edit"){
            
            self.navigationItem.rightBarButtonItem?.title = "Done"
            
            //Looping through CollectionView Cells in Swift
            //http://stackoverflow.com/questions/25490380/looping-through-collectionview-cells-in-swift
            
            for item in self.collectionView!.visibleCells() as! [ColorCell] {
                
                let indexpath : NSIndexPath = self.collectionView!.indexPathForCell(item as ColorCell)!
                let cell : ColorCell = self.collectionView!.cellForItemAtIndexPath(indexpath) as! ColorCell
                
                //Profile Picture
                //var img : UIImageView = cell.viewWithTag(100) as UIImageView
                //img.image = UIImage(named: "q.png") as UIImage
                
                //Close Button
                let close : UIButton = cell.viewWithTag(102) as! UIButton
                close.hidden = false
            }
        } else {
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            self.collectionView?.reloadData()
        }
    }
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
//        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
//        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black

        // GB: wider range
        let saturation : CGFloat = CGFloat(arc4random() % 192) / 256 + 0.25 //
        let brightness : CGFloat = CGFloat(arc4random() % 192) / 256 + 0.25 //
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(ColorPaletteViewController.colorSelected(_:)),
            name: Notifications.kColorSelected,
            object: nil)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(ColorPaletteViewController.colorUsed(_:)),
            name: Notifications.kColorUsed,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(ColorPaletteViewController.colorPaletteClosed(_:)),
            name: Notifications.kColorPaletteClosed,
            object: nil)
        
        
        staticColorArray.append(UIColor.whiteColor())
        staticColorArray.append(UIColor.grayColor())
        staticColorArray.append(UIColor.blackColor())
        staticColorArray.append(UIColor.blueColor())
        staticColorArray.append(UIColor.cyanColor())
        staticColorArray.append(UIColor.greenColor())
        staticColorArray.append(UIColor.yellowColor())
        staticColorArray.append(UIColor.orangeColor())
        staticColorArray.append(UIColor.redColor())
        staticColorArray.append(UIColor.purpleColor())
        
        for(var i=0; i<1000; i++) {
            randomColorArray.append(generateRandomColor())
        }
        

    
        // GB collection init could go here
        // GB collection init could go here
        // GB collection init could go here
        // GB collection init could go here
        // GB collection init could go here
        // GB collection init could go here
        // GB collection init could go here
        // GB collection init could go here
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func colorSelected(notification:NSNotification){
        print("Palette.colorSelected()")
        selectedColor = notification.object as! UIColor
        
        // derive variants!
        
        // first, clear the old variants
        variantColorArray.removeAll()
        
        // second, extract the selected color into components
        var srcHue: CGFloat = 0
        var srcSaturation: CGFloat = 0
        var srcBrightness: CGFloat = 0
        var srcAlpha: CGFloat = 0
        selectedColor.getHue(&srcHue, saturation: &srcSaturation, brightness: &srcBrightness, alpha: &srcAlpha)
        
        // third, create saturation variants from 0% to 100% in 8 steps
//        for(var i=0.0f; i<7.5f; i+=1.0f) {
        for(var x=1; x<=5; x++) {
            for(var y=1; y<=5; y++) {
                // saturation will be 0-1.0, scaled by source saturation x1.5
                let newSaturation: CGFloat = (0.25 * CGFloat(x) - 0.25) * min(1.0, srcSaturation * 1.5)
                // brightness will be 0.2-1.0
                let newBrightness: CGFloat = 0.20 * CGFloat(y)
                variantColorArray.append(UIColor(hue:srcHue, saturation:newSaturation, brightness:newBrightness, alpha:1))
            }
        }
        
        collectionView?.reloadData()

    }

    func colorUsed(notification:NSNotification){
        print("Palette.colorUsed()")
        
        // don't add dupes of favorites (sessions) 
        if(!sessionColorArray.contains(self.selectedColor)) {
            sessionColorArray.append(self.selectedColor)
        }
        
        // refresh table
        self.collectionView!.reloadData()        
    }

    func colorPaletteClosed(notification:NSNotification){
        print("Palette.colorPaletteClosed()")
        collectionView!.setContentOffset(CGPointZero, animated: true)
    }
    
    // #pragma mark - UICollectionViewDelegate protocol
    
    // handle tap events
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell : ColorCell = self.collectionView!.cellForItemAtIndexPath(indexPath) as! ColorCell

        let cellColor = cell.Color
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kColorSelected,
            object: cellColor)
        
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
        return sessionColorArray.count + variantColorArray.count + staticColorArray.count + randomColorArray.count
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
        
        let cell : ColorCell = collectionView.dequeueReusableCellWithReuseIdentifier("PaletteCell", forIndexPath: indexPath) as! ColorCell
        
        var color : UIColor = UIColor.whiteColor() // default
        
        if(indexPath.item < sessionColorArray.count) {
            color = sessionColorArray[indexPath.item]
            cell.CloseButton!.hidden = false
        }
        else if(indexPath.item < sessionColorArray.count + variantColorArray.count) {
            color = variantColorArray[indexPath.item - sessionColorArray.count]
            cell.CloseButton!.hidden = true
        }
        else if(indexPath.item < sessionColorArray.count + variantColorArray.count + staticColorArray.count) {
            color = staticColorArray[indexPath.item - sessionColorArray.count - variantColorArray.count]
            cell.CloseButton!.hidden = true
        }
        else if(indexPath.item < sessionColorArray.count + variantColorArray.count + staticColorArray.count + randomColorArray.count) {
            color = randomColorArray[indexPath.item - sessionColorArray.count - variantColorArray.count - staticColorArray.count]
            cell.CloseButton!.hidden = true
        }
    
        cell.Color = color
//        cell.backgroundColor = color //randomColorArray[indexPath.item]


        //GB useful example of cell layer manipulation
        //Layer property in Objective C => "http://iostutorialstack.blogspot.in/2014/04/how-to-assign-custom-tag-or-value-to.html"
        // GB we set this so we can remove from the datasource later
        cell.CloseButton?.layer.setValue(indexPath.row, forKey: "index")
        
        //GB useful example of cell interaction
        cell.CloseButton?.addTarget(self, action: "removeSessionColor:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }

    func removeSessionColor(sender:UIButton) {
        let i : Int = (sender.layer.valueForKey("index")) as! Int
        sessionColorArray.removeAtIndex(i)
        self.collectionView!.reloadData()
    }
}