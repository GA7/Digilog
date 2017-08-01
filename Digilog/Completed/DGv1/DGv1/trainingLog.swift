//
//  trainingLog.swift
//  DGv1
//
//  Created by Giovanni Antipala on 04/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class trainingLog : UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    @IBOutlet var date: UITextField!
    
    @IBOutlet var exercise: UITextField!
    
    @IBOutlet var increment: UITextField!

    @IBOutlet var max: UITextField!
    
    @IBOutlet var percentMax: UITextField!
    
    @IBOutlet var goalSets: UITextField!
    
    @IBOutlet var goalReps: UITextField!
    
    @IBOutlet var setsDone: UITextField!
    
    @IBOutlet var repsDone: UITextField!
    
    @IBOutlet var weightCalc_perc: UILabel!
    
    @IBOutlet var weightCalc_Inc: UILabel!
    
    // These variables are to be stored in "TrainingTable" in Digilog Database
    var mx : Float = 0 // max
    var globalResult_1 : Float = 0 //pwCalculated
    var gs : Float = 0 // goalSets
    var gr : Float = 0 // goalReps
    var sd : Float = 0 // setsDone
    var rd : Float = 0 // repsDone
    var ib : Float = 0 // incrementedBy
    var pc : Float = 0 // percentage
    var globalResult_2 : Float = 0 //incWCalculated
    
    @IBAction func calculate(sender: AnyObject) {
        
        // This method calculates the amount of weight to be lifted.
        // maxLifted, percentage to be stored in the DB.
        
        if (max.text == "" || percentMax.text == ""){
            
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Calculation failed!"
            
            alertView.message = "All fields are required."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
        }else{
            let a : Float = 0.01
            
            let maxLifted = (max.text! as NSString).floatValue
            
            let percentage = (percentMax.text! as NSString).floatValue
            
            let result = maxLifted * percentage * a
            
            mx = maxLifted
            
            pc = percentage
            
            globalResult_1 = result
            
            weightCalc_perc.text = String(result)
        }
        
    }

    @IBAction func save(sender: AnyObject) {
        
        
        let sets_d = (setsDone.text! as NSString).floatValue
        
        let reps_d = (repsDone.text! as NSString).floatValue
        
        let goal_s = (goalSets.text! as NSString).floatValue
        
        let goal_r = (goalReps.text! as NSString).floatValue
        
        let incBy = (increment.text! as NSString).floatValue
        
        // This method calculates only if the goal sets and reps are reached.
        
        // This method saves regardless of the result.
        
        if(date.text == "" || exercise.text == "" || increment.text == "" || max.text == "" || percentMax.text == "" || goalSets.text == "" || goalReps.text == "" || setsDone.text == "" || repsDone.text == "" || weightCalc_perc.text == "" || weightCalc_Inc.text == ""){
            
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Logging training failed!"
            
            alertView.message = "All fields are required."
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
        }else if(sets_d == goal_s && reps_d == goal_r){
            
            let res_incd = globalResult_1 + incBy
            
            globalResult_2 = res_incd
            
            weightCalc_Inc.text = String(res_incd)
            
            sd = sets_d
            
            rd = reps_d
            
            gs = goal_s
            
            gr = goal_r
            
            if(increment.text == "")
            {
                ib = 0
                print("zero")
            }else{
                ib = incBy
            }
            
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Goal reached!"
            
            alertView.message = "Better, faster, stronger, good luck on the next training!"
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://www.digilog.io/insertTraining.php")!)
            
            request.HTTPMethod = "POST"
            
            let postString = "a=\(mx)&b=\(globalResult_1)&c=\(gs)&d=\(gr)&e=\(sd)&f=\(rd)&g=\(ib)&h=\(globalResult_2)&i=\(date.text!)&j=\(exercise.text!)&k=\(pc) "
            
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
        }else{
            
            sd = sets_d
            
            rd = reps_d
            
            gs = goal_s
            
            gr = goal_r
            
            if( increment.text == ""){
                ib = 0
                print("zero")
            }
            
            let alertView:UIAlertView = UIAlertView()
            
            alertView.title = "Failed goal!"
            
            alertView.message = "You'll get it next time, just save your training, this time!"
            
            alertView.delegate = self
            
            alertView.addButtonWithTitle("OK")
            
            alertView.show()
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://www.digilog.io/insertTraining.php")!)
            
            request.HTTPMethod = "POST"
            
            let postString = "a=\(mx)&b=\(globalResult_1)&c=\(gs)&d=\(gr)&e=\(sd)&f=\(rd)&g=\(ib)&h=\(globalResult_2)&i=\(date.text!)&j=\(exercise.text!)&k=\(pc) "
            
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
        
        
        
        /*
        // Testing if all values are stored in a global variable, these are to be stored to the database.
        // Good
        print("Records: ", "date: ", date.text, "movement: ", exercise.text, "max: ", mx, "pwCalculated: ", globalResult_1, "goalSets: ", gs, "goalReps: ", gr, "setsDone: ", sd, "repsDone: ", rd, "incrementedBy: ", ib, "incWCalculated:", globalResult_2)
        */
        
        //11 vars to be inserted in the DB
        
        /*
         // These variables are to be stored in "TrainingTable" in Digilog Database
         var mx : Float = 0 // max
         var globalResult_1 : Float = 0 //pwCalculated
         var gs : Float = 0 // goalSets
         var gr : Float = 0 // goalReps
         var sd : Float = 0 // setsDone
         var rd : Float = 0 // repsDone
         var ib : Float = 0 // incrementedBy
         var pc : Float = 0 // percentage
         var globalResult_2 : Float = 0 //incWCalculated
        */
        
        /*
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.digilog.io/insertTraining.php")!)
        
        request.HTTPMethod = "POST"
        
        let postString = "a=\(mx)&b=\(globalResult_1)&c=\(gs)&d=\(gr)&e=\(sd)&f=\(rd)&g=\(ib)&h=\(globalResult_2)&i=\(date.text!)&j=\(exercise.text!)&k=\(pc) "
        
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
         */
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
}