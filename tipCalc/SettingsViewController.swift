//
//  SettingsViewController.swift
//  tipCalc
//
//  Created by Akash Gheewala on 10/26/18.
//  Copyright © 2018 Akash Gheewala. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipDefault: UISegmentedControl!
    
    let defaults = UserDefaults.standard
    let tipSettings = [0.18, 0.2, 0.25]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // purpose of this code is to maintain the selected default
        // amount even after leaving the settings viewController
        let dAmount = defaults.double(forKey:"tipAmount")
        if (dAmount == 0.18) {
            tipDefault.selectedSegmentIndex = 0
        } else if (dAmount == 0.2){
            tipDefault.selectedSegmentIndex = 1
        } else {
            tipDefault.selectedSegmentIndex = 2
        }
    }
    
    @IBAction func setDefaultTip(_ sender: Any) {
        defaults.set(tipSettings[tipDefault.selectedSegmentIndex], forKey: "tipAmount")
        
        defaults.synchronize()
    }
    
}
