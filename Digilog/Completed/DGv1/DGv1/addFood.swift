//
//  addFood.swift
//  DGv1
//
//  Created by Giovanni Antipala on 10/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class addFood : UIViewController{
    
    @IBOutlet var product: UITextField!
    
    @IBOutlet var calories: UITextField!
    
    @IBOutlet var protein: UITextField!
    
    @IBOutlet var carbs: UITextField!
    
    @IBOutlet var fats: UITextField!
    
    @IBOutlet var date: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    @IBAction func submit(sender: AnyObject) {
        
        if(product.text == "" || calories.text == "" || protein.text == "" || carbs.text == "" || fats.text == ""){
            
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Food info submission failed!"
            
            alertView.message = "All fields are required."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
        }else{
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Food info submission success!"
            
            alertView.message = "Thanks for submitting."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://www.digilog.io/addFood.php")!)
            
            request.HTTPMethod = "POST"
            
            let postString = "a=\(product.text!)&b=\(calories.text!)&c=\(protein.text!)&d=\(carbs.text!)&e=\(fats.text!)"
            
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
        
    @IBAction func updateNLog(sender: AnyObject) {
        
        if(product.text == "" || calories.text == "" || protein.text == "" || carbs.text == "" || fats.text == "" || date.text == ""){
            
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Updating Log failed."
            
            alertView.message = "All fields are required."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
        }else{
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Success!"
            
            alertView.message = "Updated!"
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://www.digilog.io/updateNLog.php")!)
            
            request.HTTPMethod = "POST"
            
            let postString = "a=\(product.text!)&b=\(calories.text!)&c=\(protein.text!)&d=\(carbs.text!)&e=\(fats.text!)&f=\(date.text!)"
            
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



