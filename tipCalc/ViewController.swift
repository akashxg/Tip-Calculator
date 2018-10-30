//
//  ViewController.swift
//  tipCalc
//
//  Created by Akash Gheewala on 10/25/18.
//  Copyright © 2018 Akash Gheewala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // retrieving the default tip amount
        let dAmount = defaults.double(forKey:"tipAmount")
        // updating the segmented control button with the default tip amount
        if (dAmount == 0.18) {
            tipControl.selectedSegmentIndex = 0
        } else if (dAmount == 0.2){
            tipControl.selectedSegmentIndex = 1
        } else {
            tipControl.selectedSegmentIndex = 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
}

