//
//  searchResultModel.swift
//  DGv1
//
//  Created by Giovanni Antipala on 09/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class searchResultModel : UITableViewCell{
    
    @IBOutlet var product: UILabel!
    
    @IBOutlet var calorie: UILabel!
    
    @IBOutlet var protein: UILabel!
    
    @IBOutlet var carbs: UILabel!
    
    @IBOutlet var fats: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}