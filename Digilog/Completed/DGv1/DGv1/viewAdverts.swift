//
//  viewAdverts.swift
//  DGv1
//
//  Created by Giovanni Antipala on 04/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class viewAdverts : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet var tableView: UITableView!
    
    var values : NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        get()
    }
    
    
    func get(){
        let url = NSURL(string: "http://digilog.io/adView.php")
        let data = NSData(contentsOfURL: url!)
        values = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! advertModel
        let maindata = values[indexPath.row]
        cell.gym.text = maindata["gymName"] as? String
        cell.address_one.text = maindata["addressOne"] as? String
        cell.address_two.text = maindata["addressTwo"] as? String
        cell.address_three.text = maindata["addressThree"] as? String
        cell.website.text = maindata["website"] as? String
        cell.monthly.text = maindata["price1m"] as? String
        cell.three_months.text = maindata["price3m"] as? String
        cell.yearly.text = maindata["priceYearly"] as? String
        return cell;
        
    }
    
}