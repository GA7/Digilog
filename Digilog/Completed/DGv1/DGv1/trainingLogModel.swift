//
//  trainingLogModel.swift
//  DGv1
//
//  Created by Giovanni Antipala on 05/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class trainingLogModel : UITableViewCell{
    
    @IBOutlet var date: UILabel!
    
    @IBOutlet var exercise: UILabel!
    
    @IBOutlet var max: UILabel!
    
    @IBOutlet var percMax: UILabel!
    
    @IBOutlet var goalSets: UILabel!
    
    @IBOutlet var goalReps: UILabel!
    
    @IBOutlet var incrementBy: UILabel!
    
    @IBOutlet var setsDone: UILabel!
    
    @IBOutlet var repsDone: UILabel!
    
    @IBOutlet var calcWeight: UILabel!
    
    @IBOutlet var incWeight: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
