//
//  SettingsViewController.swift
//  caltips
//
//  Created by AHT on 3/13/17.
//  Copyright © 2017 AHT. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var defaultTipPicker: UIPickerView!
    @IBOutlet weak var defaultTipLabel: UILabel!
    @IBOutlet weak var themePicker: UISegmentedControl!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var divider: UIView!
    
    var tipPickerData = ["18%", "20%", "22%"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       themePicker.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "theme_index")
        setTheme(themeIndex: UserDefaults.standard.integer(forKey: "theme_index"))
        
        defaultTipPicker.delegate = self
        defaultTipPicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("settings view did appear")
        
        print(UserDefaults.standard.integer(forKey: "default_tip_index"))
        
        let selUserDefault = UserDefaults.standard.integer(forKey: "default_tip_index")
        
        defaultTipPicker.selectRow(selUserDefault , inComponent: 0, animated: true)

    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tipPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        UserDefaults.standard.set(row, forKey: "default_tip_index")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func onSelectChange(_ sender: AnyObject) {
        let themeIndex = self.themePicker.selectedSegmentIndex
        UserDefaults.standard.set(themeIndex, forKey: "theme_index")
        UserDefaults.standard.synchronize()
        
        setTheme(themeIndex: themeIndex)
        
    }
    
    func setTheme(themeIndex: Int){
        if(themeIndex == 1) {
            self.view.backgroundColor = UIColor.cyan
            self.themeLabel.textColor = UIColor.blue
            self.defaultTipLabel.textColor = UIColor.blue
            self.divider.backgroundColor = UIColor.blue
            self.defaultTipPicker.backgroundColor = UIColor.clear
            self.themePicker.backgroundColor = UIColor.cyan
            self.themePicker.tintColor = UIColor.blue
        }
        else {
            self.view.backgroundColor = UIColor.black
            self.themeLabel.textColor = UIColor.white
            self.defaultTipLabel.textColor = UIColor.white
            self.defaultTipPicker.backgroundColor = UIColor.white
            self.divider.backgroundColor = UIColor.white
            self.themePicker.backgroundColor = UIColor.lightGray
            self.themePicker.tintColor = UIColor.white
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
