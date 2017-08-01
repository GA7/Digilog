//
//  backTableVC.swift
//  DGv1
//
//  Created by Giovanni Antipala on 14/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation


class backTableVC : UITableViewController{
    
    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["Login","Signup","TDEE Calculator","Macro Calculator", "Training Log", "View Training Log", "Add food", "View Nutrition Log", "Search Food Database", "View Adverts", "Register Adverts", "Search Result"]
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TableArray.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        return cell
    }
}