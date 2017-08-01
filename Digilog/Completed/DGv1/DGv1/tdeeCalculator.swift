//
//  tdeeCalculator.swift
//  DGv1
//
//  Created by Giovanni Antipala on 07/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class  tdeeCalculator: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    @IBOutlet var age: UITextField!
    
    @IBOutlet var bodyweight: UITextField!
    
    @IBOutlet var activityLevel: UITextField!
    
    @IBOutlet var height: UITextField!
    
    @IBOutlet var gender: UITextField!
    
    @IBOutlet var tdeeDisplay: UILabel!
    
    var male_Global: Int = 0
    
    var female_Global: Int = 0
    
    var activityLevel_Global: Float = 0
    
    var calories: Float = 0
    
    var pickerData = ["1.2", "1.4", "1.6", "1.8", "2.2"]
    
    var pickerData2 = ["Male", "Female"]
    
    var activityPicker = UIPickerView()
    
    var genderPicker = UIPickerView()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        activityPicker.delegate = self
        
        activityPicker.dataSource = self
        
        activityLevel.inputView = activityPicker
        
        activityPicker.tag = 1
        
        genderPicker.delegate = self
        
        genderPicker.dataSource = self
        
        gender.inputView = genderPicker
        
        genderPicker.tag = 2
    }
    
    @IBAction func calculate(sender: AnyObject) {
        
        if(age.text == "" || bodyweight.text == "" || activityLevel.text == "" || height.text == "" || gender.text == ""){
            
            let alertView:UIAlertView = UIAlertView()
            
            //alert if empty
            
            alertView.title = "Error!"
            
            alertView.message = "All fields are required!"
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
        }else{
            
            let a:Float = 9.99 // 9.99
            
            let b:Float = 6.25 // 6.25
            
            let c:Float = 4.92 // 4.92
            
            let m:Float = 5.0
            
            let f:Float = 161.0
            
            //activity level picker here
            let _age = (age.text! as NSString).floatValue
            
            let _bodyweight = (bodyweight.text! as NSString).floatValue
            
            let _height = (height.text! as NSString).floatValue
            
            
            // results using activity multiplier
            
            if(male_Global == 1){
                
                // calculation to get TDEE for male
                
                let m_method1 = a * _bodyweight // Good
                
                let m_method2 = b * _height // Good
                
                let m_method3 = c * _age // Good
                
                let m_method4 = m_method1 + m_method2 - m_method3 + m
                
                let m_result = m_method4 * activityLevel_Global
                
                //print(m_result)
                
                tdeeDisplay.text = String(m_result)
                
                calories = m_result
                
                print("calories: ", calories)
            }
            
            if(female_Global == 2){
                
                // calculation to get TDEE for female
                
                let f_method1 = a * _bodyweight
                
                let f_method2 = b * _height
                
                let f_method3 = c * _age
                
                let f_method4 = f_method1 + f_method2 - f_method3 - f
                
                let f_result = f_method4 * activityLevel_Global
                
                print(f_result)
                
                tdeeDisplay.text = String(f_result)
            }
        }
    }

    @IBAction func save(sender: AnyObject) {
        
        //check if empty
        if(age.text == "" || bodyweight.text == "" || activityLevel.text == "" || height.text == "" || gender.text == ""){
            
            let alertView:UIAlertView = UIAlertView()
            
            //alert if empty
            
            alertView.title = "Save Failed!"
            
            alertView.message = "All fields are required!"
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
        }else{
            
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Success!"
            
            alertView.message = "Saved!"
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://www.digilog.io/saveTdee.php")!)
            
            request.HTTPMethod = "POST"
            
            let postString = "a=\(age.text!)&b=\(bodyweight.text!)&c=\(activityLevel.text!)&d=\(height.text!)&e=\(gender.text!)&f=\(tdeeDisplay.text!)"
            
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
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
            return pickerData.count
        }else{
            return pickerData2.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1){
            activityLevel.text = pickerData[row]
            if(row == 0){
                print("1.2")
                activityLevel_Global = 1.2
            }else if(row == 1)
            {
                print("1.4")
                activityLevel_Global = 1.4
            }else if(row == 2)
            {
                print("1.6")
                activityLevel_Global = 1.6
            }else if(row == 3)
            {
                print("1.8")
                activityLevel_Global = 1.8
            }else{
                print("2.2")
                activityLevel_Global = 2.2
            }
        }else if(pickerView.tag == 2){
            gender.text = pickerData2[row]
            if(row == 0){
                print("Male")
                male_Global = 1
                female_Global = 0
            }
            else{
                print("Female")
                male_Global = 0
                female_Global = 2
            }
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(pickerView.tag == 1){
            return pickerData[row]
        }else{
            return pickerData2[row]
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
}