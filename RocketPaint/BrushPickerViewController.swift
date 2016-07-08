
import UIKit

class BrushPickerViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("BrushPicker: touchesBegan()")
    }
    
    @IBAction func pickedPen1(sender : AnyObject) {
        print("BrushPicker: pickedPen1()");

        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "Pen1")
    }
    @IBAction func pickedPen2(sender : AnyObject) {
        print("BrushPicker: pickedPen2()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "Pen2")
    }
    @IBAction func pickedPen3(sender : AnyObject) {
        print("BrushPicker: pickedPen3()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "Pen3")
    }
    @IBAction func pickedPen4(sender : AnyObject) {
        print("BrushPicker: pickedPen4()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "Pen4")
    }
    
    @IBAction func pickedLine1(sender : AnyObject) {
        print("BrushPicker: pickedLine1()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "Line1")
    }
    @IBAction func pickedLine2(sender : AnyObject) {
        print("BrushPicker: pickedLine2()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "Line2")
    }
    @IBAction func pickedLine3(sender : AnyObject) {
        print("BrushPicker: pickedLine3()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "Line3")
    }
    @IBAction func pickedLine4(sender : AnyObject) {
        print("BrushPicker: pickedLine4()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "Line4")
    }

    @IBAction func pickedBox(sender : AnyObject) {
        print("BrushPicker: pickedBox()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "Box")
    }
    @IBAction func pickedHighlightGreen(sender : AnyObject) {
        print("BrushPicker: pickedHighlightGreen()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "HighlightGreen")
    }
    @IBAction func pickedHighlightYellow(sender : AnyObject) {
        print("BrushPicker: pickedHighlightYellow()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "HighlightYellow")
    }
    @IBAction func pickedHighlightRed(sender : AnyObject) {
        print("BrushPicker: pickedHighlightRed()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "HighlightRed")
    }

    @IBAction func pickedTextSerifBig(sender : AnyObject) {
        print("BrushPicker: pickedTextSerifBig()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "TextSerifBig")
    }
    @IBAction func pickedTextSerifSmall(sender : AnyObject) {
        print("BrushPicker: pickedTextSerifSmall()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "TextSerifSmall")
    }
    @IBAction func pickedTextSansBig(sender : AnyObject) {
        print("BrushPicker: pickedTextSansBig()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "TextSansBig")
    }
    @IBAction func pickedTextSansSmall(sender : AnyObject) {
        print("BrushPicker: pickedTextSansSmall()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: "TextSansSmall")
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