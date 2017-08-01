//
//  userLogin.swift
//  DGv1
//
//  Created by Giovanni Antipala on 05/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class userLogin : UIViewController {
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    @IBAction func login(sender: AnyObject) {
        
        if(username.text == "" || password.text == ""){
            
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Login Failed!"
            
            alertView.message = "All fields are required."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()

        }else{
            print(username.text, password.text)
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://www.digilog.io/userLogin.php")!)
            
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