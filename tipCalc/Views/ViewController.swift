//
//  ViewController.swift
//  tipCalc
//
//  Created by Akash Gheewala on 10/25/18.
//  Copyright © 2018 Akash Gheewala. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    // Outlets
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var additionLabel: UILabel!
    @IBOutlet weak var equalLabel: UILabel!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var calcView: UIView!
    @IBOutlet weak var twoP: UILabel!
    @IBOutlet weak var threeP: UILabel!
    @IBOutlet weak var fourP: UILabel!
    @IBOutlet weak var twoTotal: UILabel!
    @IBOutlet weak var threeTotal: UILabel!
    @IBOutlet weak var fourTotal: UILabel!
    
    
    let defaults = UserDefaults.standard
    // property to make sure that animation only occurs once
    var animationHasOccurred = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // retrieving the default tip amount
        let dAmount = defaults.double(forKey:"tipAmount")
        
        // updating the segmented control button with default tip amount
        if (dAmount == 0.18) {
            tipControl.selectedSegmentIndex = 0
        } else if (dAmount == 0.2){
            tipControl.selectedSegmentIndex = 1
        } else {
            tipControl.selectedSegmentIndex = 2
        }
        
        billField.delegate = self
        
        // listen for keyboard events
        billField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        // setting up for animations
        billField.center.y += 200
        tipControl.center.y += 500
        calcView.center.y += 500

        // view fonts & sizes
        billField.font = UIFont(name: Theme.current.mainFontName, size: 70)
        totalLabel.font = UIFont(name: Theme.current.mainFontName, size: 50)
        tipLabel.font = UIFont(name: Theme.current.mainFontName, size: 20)
        additionLabel.font = UIFont(name: Theme.current.mainFontName
            , size: 30)
        equalLabel.font = UIFont(name: Theme.current.mainFontName, size: 50)
        twoTotal.font = UIFont(name: Theme.current.mainFontName, size: 40)
        threeTotal.font = UIFont(name: Theme.current.mainFontName, size: 30)
        fourTotal.font = UIFont(name: Theme.current.mainFontName, size: 25)
        
        // theme colors
        self.view.backgroundColor = Theme.current.backgroundOne
        calcView.backgroundColor = Theme.current.backgroundTwo
       // tipControl.backgroundColor = Theme.current.backgroundOne
        tipControl.tintColor = Theme.current.text
        billField.textColor = Theme.current.text
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // launching keypad
        billField.becomeFirstResponder()
        
        view.backgroundColor = Theme.current.backgroundOne
        
        
        
    }

    // actions
    @IBAction func onTap(_ sender: Any) {
        hideKeyboard()
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        twoTotal.text = String(format: "$%.2f", total/2)
        threeTotal.text = String(format: "$%.2f", total/3)
        fourTotal.text = String(format: "$%.2f", total/4)
    }
    
    // methods
    func hideKeyboard() {
        billField.resignFirstResponder()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (!animationHasOccurred) {
            UIView.animate(withDuration: 0.2) {
                self.billField.center.y -= 200
                self.tipControl.center.y -= 500
                self.calcView.center.y -= 500
            }
            // animation should only occur once
            animationHasOccurred = true
        }

    }
    
    // UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
}

