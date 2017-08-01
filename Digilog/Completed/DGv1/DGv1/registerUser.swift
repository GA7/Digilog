//
//  registerUser.swift
//  DGv1
//
//  Created by Giovanni Antipala on 05/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class registerUser : UIViewController{
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    @IBAction func Register(sender: AnyObject) {
        
        if(username.text == "" || password.text == ""){
            
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Registration Failed!"
            
            alertView.message = "All fields are required."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
        }else{
            
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Registration Success!"
            
            alertView.message = "Proceed to login."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://www.digilog.io/userRegister.php")!)
            
            request.HTTPMethod = "POST"
            
            let postString = "a=\(username.text!)&b=\(password.text!)"
            
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

    
