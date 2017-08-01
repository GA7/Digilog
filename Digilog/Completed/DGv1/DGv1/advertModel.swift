//
//  advertModel.swift
//  DGv1
//
//  Created by Giovanni Antipala on 04/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class advertModel : UITableViewCell{
    
    @IBOutlet var gym: UILabel!
    
    @IBOutlet var address_one: UILabel!
    
    @IBOutlet var address_two: UILabel!
    
    @IBOutlet var address_three: UILabel!
    
    @IBOutlet var website: UILabel!
    
    @IBOutlet var monthly: UILabel!
    
    @IBOutlet var three_months: UILabel!
    
    @IBOutlet var yearly: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}