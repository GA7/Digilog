//
//  example.swift
//  DGv1
//
//  Created by Giovanni Antipala on 15/05/2016.
//  Copyright © 2016 Giovanni Antipala. All rights reserved.
//

import Foundation
import UIKit

class example : UIViewController{
    
    @IBOutlet var Open: UIBarButtonItem!
    
    var varView = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Open.target = self.revealViewController()
        
        Open.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        if(varView == 0){
            print("login page")
        }else{
            print("other pages")
        }
    }
}