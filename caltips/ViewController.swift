//
//  ViewController.swift
//  caltips
//
//  Created by AHT on 3/12/17.
//  Copyright © 2017 AHT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "default_tip_index")
        
        tipLabel.text = "$0.00";
        totalLabel.text = "$0.00";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        tipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "default_tip_index")
        
        calculateTotal(selectedSegmentIndex: tipControl.selectedSegmentIndex)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //print("view did disappear")
    }


    @IBAction func onEditingChanged(_ sender: AnyObject) {
        
        calculateTotal(selectedSegmentIndex: tipControl.selectedSegmentIndex)
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true);
    }
    
    
    func calculateTotal(selectedSegmentIndex: Int){
        var tipPercentValues = [0.18, 0.2, 0.22];
        let selectedTipValue = tipPercentValues[selectedSegmentIndex];
        
        let billAmount = Double(billField.text!) ?? 0;
        let tip = billAmount * selectedTipValue
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip);
        totalLabel.text = String(format: "$%.2f", total);
    }
}

