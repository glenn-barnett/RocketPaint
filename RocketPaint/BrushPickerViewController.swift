
import UIKit

class BrushPickerViewController: UIViewController {
    
    @IBOutlet weak var sliderLineWidth: UISlider!
    
    @IBOutlet weak var sliderLineAlpha: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(BrushPickerViewController.lineWidthChanged(_:)),
            name: Notifications.kLineWidthChanged,
            object: nil)

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(BrushPickerViewController.lineAlphaChanged(_:)),
            name: Notifications.kLineAlphaChanged,
            object: nil)
    }
    
    @IBAction func lineWidthAdjusted(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kLineWidthChanged,
            object: nil,
            userInfo: ["lineWidth": sliderLineWidth.value])
    }
    
    @IBAction func lineAlphaAdjusted(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kLineAlphaChanged,
            object: nil,
            userInfo: ["lineAlpha": sliderLineAlpha.value])
    }
    
    func lineWidthChanged(notification:NSNotification){
        let lineWidth = notification.userInfo!["lineWidth"] as! Float
        sliderLineWidth.value = lineWidth
    }

    func lineAlphaChanged(notification:NSNotification){
        let lineAlpha = notification.userInfo!["lineAlpha"] as! Float
        sliderLineAlpha.value = lineAlpha
    }

    @IBAction func pickedPen1(sender : AnyObject) {
        print("BrushPicker: pickedPen1()");

        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Pen1"])
    }
    @IBAction func pickedPen2(sender : AnyObject) {
        print("BrushPicker: pickedPen2()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Pen2"])
    }
    @IBAction func pickedPen3(sender : AnyObject) {
        print("BrushPicker: pickedPen3()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Pen3"])
    }
    @IBAction func pickedPen4(sender : AnyObject) {
        print("BrushPicker: pickedPen4()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Pen4"])
    }
    
    @IBAction func pickedLine1(sender : AnyObject) {
        print("BrushPicker: pickedLine1()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Line1"])
    }
    @IBAction func pickedLine2(sender : AnyObject) {
        print("BrushPicker: pickedLine2()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Line2"])
    }
    @IBAction func pickedLine3(sender : AnyObject) {
        print("BrushPicker: pickedLine3()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Line3"])
    }
    @IBAction func pickedLine4(sender : AnyObject) {
        print("BrushPicker: pickedLine4()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Line4"])
    }

    @IBAction func pickedBox(sender : AnyObject) {
        print("BrushPicker: pickedBox()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "Box"])
    }
    @IBAction func pickedHighlightGreen(sender : AnyObject) {
        print("BrushPicker: pickedHighlightGreen()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "HighlightGreen"])
    }
    @IBAction func pickedHighlightYellow(sender : AnyObject) {
        print("BrushPicker: pickedHighlightYellow()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "HighlightYellow"])
    }
    @IBAction func pickedHighlightRed(sender : AnyObject) {
        print("BrushPicker: pickedHighlightRed()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "HighlightRed"])
    }

    @IBAction func pickedTextSerifBig(sender : AnyObject) {
        print("BrushPicker: pickedTextSerifBig()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "TextSerifBig"])
    }
    @IBAction func pickedTextSerifSmall(sender : AnyObject) {
        print("BrushPicker: pickedTextSerifSmall()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "TextSerifSmall"])
    }
    @IBAction func pickedTextSansBig(sender : AnyObject) {
        print("BrushPicker: pickedTextSansBig()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "TextSansBig"])
    }
    @IBAction func pickedTextSansSmall(sender : AnyObject) {
        print("BrushPicker: pickedTextSansSmall()");
        
        NSNotificationCenter.defaultCenter().postNotificationName(
            Notifications.kBrushChanged,
            object: nil,
            userInfo: ["brush": "TextSansSmall"])
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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