//
//  macroCalculator.swift
//  DGv1
//
//  Created by Giovanni Antipala on 07/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class macroCalculator : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    var values : NSArray = []
    
    var pBy4 : Float = 0
    
    var cBy4 : Float = 0
    
    var fBy9 : Float = 0
    
    var pcf : Float = 0
    
    var calsFromDB : Float = 0
    
    var pcfMinusCals : Float = 0
    
    // Input
    
    @IBOutlet var tdee: UITextField!
    
    @IBOutlet var protein: UITextField!
    
    @IBOutlet var carbs: UITextField!
    
    @IBOutlet var fats: UITextField!
    
    // autoSet output
    
    @IBOutlet var proteinAS: UILabel!
    
    @IBOutlet var carbsAS: UILabel!
    
    @IBOutlet var fatsAS: UILabel!
    
    var autoSetCal : Float = 0
    
    var Cal : Float = 0
    
    var PCF_ : Float = 0
    
    var pDB : Float = 0
    
    var cDB : Float = 0
    
    var fDB: Float = 0
    
    /*
     
     @IBAction func calculate(sender: AnyObject) {
     
     let t = (tdee.text! as NSString).floatValue
     
     let p = (protein.text! as NSString).floatValue
     
     let c = (carbs.text! as NSString).floatValue
     
     let f = (fats.text! as NSString).floatValue
     
     pBy4 = p * 4
     
     cBy4 = c * 4
     
     fBy9 = f * 9
     
     pcf = pBy4 + cBy4 + fBy9
     
     Cal = t
     
     pDB = pBy4
     
     cDB = cBy4
     
     fDB = fBy9
     
     //have an alert display tdee result from manual macro set
     let alertView:UIAlertView = UIAlertView()
     
     alertView.title = "Macro setter"
     
     alertView.message = "Result from: "
     
     alertView.delegate = self
     
     alertView.addButtonWithTitle("OK")
     
     print(Cal, PCF_)
     
     // pcfMinusCals = calsFromDB - pcf
     
     // caloriesLeft.text = calsFromDB - pcfMinusCals
     
     // retrieve "Calories" from UserStats Table
     }
     */
    @IBAction func autoSet(sender: AnyObject) {
        
        if(tdee.text == ""){
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Failed!"
            
            alertView.message = "TDEE field is required for auto-set."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
        }else{
            let cal = (tdee.text! as NSString).floatValue
            
            autoSetCal = cal
            
            let pro = autoSetCal * 0.4 / 4
            
            let cho = autoSetCal * 0.4 / 4
            
            let fat = autoSetCal * 0.2 / 9
            
            proteinAS.text = String(pro)
            
            carbsAS.text = String(cho)
            
            fatsAS.text = String(fat)
        }

    }
    
    @IBAction func save(sender: AnyObject) { // Auto set save
        
        //if(Cal == PCF_){
        //    print("they're ==")
        //}
        
        if(tdee.text == ""){
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Failed!"
            
            alertView.message = "TDEE field is required for auto-set."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
        }else{
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Success!"
            
            alertView.message = "Saved."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://www.digilog.io/updateUserStats2.php")!)
            
            request.HTTPMethod = "POST"
            
            let postString =  "a=\(tdee.text!)&b=\(proteinAS.text!)&c=\(carbsAS.text!)&d=\(fatsAS.text!)"
            
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                
                data, response, error in
                
                if error != nil {
                    
                    print("error=\(error)")
                    
                    return
                }
                
                print("response = \(response)")
                
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                print("responseString = \(responseString)")
            }
            
            task.resume()
        }
    }
    
    @IBAction func mSave(sender: AnyObject) { // manual set save
        
        if(tdee.text == "" || protein.text == "" || carbs.text == "" || fats.text == ""){
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Failed!"
            
            alertView.message = "All fields are required."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
        }else{
            
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Success!"
            
            alertView.message = "Saved."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://www.digilog.io/updateUserStats.php")!)
            
            request.HTTPMethod = "POST"
            
            let postString = "a=\(tdee.text!)&b=\(protein.text!)&c=\(carbs.text!)&d=\(fats.text!)"
            
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                
                data, response, error in
                
                if error != nil {
                    
                    print("error=\(error)")
                    
                    return
                }
                
                print("response = \(response)")
                
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                print("responseString = \(responseString)")
            }
            task.resume()
            
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
}

