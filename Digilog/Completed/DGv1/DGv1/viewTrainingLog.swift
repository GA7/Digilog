//
//  viewTrainingLog.swift
//  DGv1
//
//  Created by Giovanni Antipala on 05/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class viewTrainingLog : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    var values : NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        get()
    }
    
    func get(){
        let url = NSURL(string: "http://digilog.io/viewTrainingLog.php")
        let data = NSData(contentsOfURL: url!)
        values = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! trainingLogModel
        let maindata = values[indexPath.row]
        cell.date.text = maindata["dateLogged"] as? String
        cell.exercise.text = maindata["movement"] as? String
        cell.max.text = maindata["max"] as? String
        cell.percMax.text = maindata["percentage"] as? String
        cell.calcWeight.text = maindata["pWCalculated"] as? String
        cell.goalSets.text = maindata["goalSets"] as? String
        cell.goalReps.text = maindata["goalReps"] as? String
        cell.setsDone.text = maindata["setsDone"] as? String
        cell.repsDone.text = maindata["repsDone"] as? String
        cell.incrementBy.text = maindata["incrementedBy"] as? String
        cell.incWeight.text = maindata["incWCalculated"] as? String
        
        return cell;
        
    }

    
}