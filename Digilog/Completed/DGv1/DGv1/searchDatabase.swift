//
//  searchDatabase.swift
//  DGv1
//
//  Created by Giovanni Antipala on 08/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class searchDatabase : UIViewController{

    
    @IBOutlet var search: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    @IBAction func submit(sender: AnyObject) {
        
        if(search.text == ""){
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Search Failed!"
            
            alertView.message = "Search field is empty!"
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
        }else{
            print(search.text)
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://www.digilog.io/searchFood.php")!)
            
            request.HTTPMethod = "POST"
            
            let postString = "searchInput=\(search.text!)"
            
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