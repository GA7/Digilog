//
//  viewNutritionLog.swift
//  DGv1
//
//  Created by Giovanni Antipala on 13/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class viewNutritionLog : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var values : NSArray = []
    
    var values2 : NSArray = []
    
    @IBOutlet var tableView1: UITableView!
    
    @IBOutlet var tableView2: UITableView!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        getUserStats()
        
        getUserConsumed()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    func getUserStats(){
        let url1 = NSURL(string: "http://digilog.io/viewSetTDEEMacro.php")
        let data1 = NSData(contentsOfURL: url1!)
        values = try! NSJSONSerialization.JSONObjectWithData(data1!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        tableView1.reloadData()
    }
    
    func getUserConsumed(){
        let url2 = NSURL(string: "http://digilog.io/loggedFood.php")
        let data2 = NSData(contentsOfURL: url2!)
        values2 = try! NSJSONSerialization.JSONObjectWithData(data2!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        tableView2.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == tableView1){
            return values.count
        }
        if(tableView == tableView2){
            return values2.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! nutritionLogModel
        
        if(tableView == tableView1){
            let cc = values[indexPath.row]
            
            cell.setTdee.text = cc["tdee"] as? String
            cell.setProtein.text = cc["protein"] as? String
            cell.setCarbs.text = cc["carbohydrates"] as? String
            cell.setFat.text = cc["fats"] as? String
        }
        
        if(tableView == tableView2){
            let lf = values2[indexPath.row]
            cell.mealProduct.text = lf["product"] as? String
            cell.dateLBL.text = lf["dateLogged"] as? String
            cell.proLBL.text = lf["protein"] as? String
            cell.choLBL.text = lf["carbohydrates"] as? String
            cell.fatLBL.text = lf["fats"] as? String
        }
        
        return cell;
        
    }
}
