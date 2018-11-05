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
    @IBOutlet weak var additionLabel: UILabel!
    @IBOutlet weak var equalLabel: UILabel!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var calcView: UIView!
    
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
        // setting up views for animations
        tipControl.center.y -= view.bounds.height
        calcView.center.y -= view.bounds.height
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting font & size for all views
        billField.font = UIFont(name: Theme.mainFontName, size: 70)
        totalLabel.font = UIFont(name: Theme.mainFontName, size: 50)
        tipLabel.font = UIFont(name: Theme.mainFontName, size: 30)
        additionLabel.font = UIFont(name: Theme.mainFontName
            , size: 30)
        equalLabel.font = UIFont(name: Theme.mainFontName, size: 50)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //launching keypad when app opens
        billField.becomeFirstResponder()
        
        // animating views
        UIView.animate(withDuration: 3.0) {
            self.tipControl.center.y += self.view.bounds.height
            self.calcView.center.y += self.view.bounds.height
        }
        
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

