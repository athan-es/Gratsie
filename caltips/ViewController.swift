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
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var totalText: UILabel!
    
    @IBOutlet weak var tipText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.billField.becomeFirstResponder()
        
        tipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "default_tip_index")
        
        tipLabel.text = "$0.00";
        totalLabel.text = "$0.00";
        
        if billField.text == "" {
            resetState()
        }
        applyTheme(themeIndex: UserDefaults.standard.integer(forKey: "theme_index"))
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
        applyTheme(themeIndex: UserDefaults.standard.integer(forKey: "theme_index"))
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
        
        if billField.text != "" {
            self.billField.becomeFirstResponder()
            
            UIView.animate(withDuration: 1, animations: {
                self.totalView.alpha = 0
                self.billField.layer.borderWidth = 1
                self.billField.borderStyle = .bezel
                self.billField.textAlignment = .right
            })
        }
        else {
            resetState();
        }
        calculateTotal(selectedSegmentIndex: tipControl.selectedSegmentIndex)
    }
    
    func resetState() {
        UIView.animate(withDuration: 2, animations: {
            self.totalView.alpha = 1
            self.billField.layer.borderWidth = 0
            self.billField.textAlignment = .center
            self.billField.borderStyle = .none
        })
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
    
    func applyTheme(themeIndex: Int){
        if(themeIndex == 1) {
            self.view.backgroundColor = UIColor.cyan
            self.billField.backgroundColor = UIColor.white
            self.totalView.backgroundColor = UIColor.cyan
            self.billField.textColor = UIColor.blue
            self.tipLabel.textColor = UIColor.blue
            self.totalLabel.textColor = UIColor.blue
            self.divider.backgroundColor = UIColor.blue
            self.tipText.textColor = UIColor.blue
            self.totalText.textColor = UIColor.blue
            self.tipControl.backgroundColor = UIColor.cyan
            self.tipControl.tintColor = UIColor.blue
        }
        else {
            self.view.backgroundColor = UIColor.black
            self.billField.backgroundColor = UIColor.lightGray
            self.totalView.backgroundColor = UIColor.black
            self.billField.textColor = UIColor.white
            self.tipLabel.textColor = UIColor.white
            self.totalLabel.textColor = UIColor.white
            self.divider.backgroundColor = UIColor.white
            self.tipText.textColor = UIColor.white
            self.totalText.textColor = UIColor.white
            self.tipControl.backgroundColor = UIColor.lightGray
            self.tipControl.tintColor = UIColor.white
            
        }
    }
}

