//
//  searchResult.swift
//  DGv1
//
//  Created by Giovanni Antipala on 09/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class searchResult : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    
    var values : NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        get()
    }
    
    
    func get(){
        let url = NSURL(string: "http://digilog.io/searchFood.php")
        let data = NSData(contentsOfURL: url!)
        values = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! searchResultModel
        let maindata = values[indexPath.row]
        cell.product.text = maindata["product"] as? String
        cell.calorie.text = maindata["calories"] as? String
        cell.protein.text = maindata["protein"] as? String
        cell.carbs.text = maindata["carbohydrates"] as? String
        cell.fats.text = maindata["fats"] as? String
        return cell;
        
    }

}