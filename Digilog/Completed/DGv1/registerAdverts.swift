//
//  registerAdverts.swift
//  DGv1
//
//  Created by Giovanni Antipala on 03/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import UIKit
import Foundation

class registerAdverts : UIViewController{
    
    @IBOutlet var gymName: UITextField!
    
    @IBOutlet var addressOne: UITextField!
    
    @IBOutlet var addressTwo: UITextField!
    
    @IBOutlet var addressThree: UITextField!
    
    @IBOutlet var website: UITextField!
    
    @IBOutlet var monthly: UITextField!
    
    @IBOutlet var threeMonths: UITextField!
    
    @IBOutlet var yearly: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    @IBAction func register(sender: AnyObject) {
        
        if(gymName.text == "" || addressOne.text == "" || addressTwo.text == "" || addressThree.text == "" || website.text == "" || monthly.text == "" || threeMonths.text == "" || yearly.text == ""){
            
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Registration Failed!"
            
            alertView.message = "All fields are required."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
            
        }else{
            
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Registration"
            
            alertView.message = "Registration Successful!"
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://www.digilog.io/adRegister.php")!)
            
            request.HTTPMethod = "POST"
            
            let postString = "a=\(gymName.text!)&b=\(addressOne.text!)&c=\(addressTwo.text!)&d=\(addressThree.text!)&e=\(website.text!)&f=\(monthly.text!)&g=\(threeMonths.text!)&h=\(yearly.text!)"
            
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