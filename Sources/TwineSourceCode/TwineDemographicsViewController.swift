//
//  TwineDemographicsViewController.swift
//  TwineSDK
//
//  Created by John Mohler on 9/29/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

import UIKit

class TwineDemographicsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var genderPicker: UIPickerView!
    @IBOutlet var languageTextField: UITextField!
    @IBOutlet var daysPicker: UIPickerView!
    @IBOutlet var yearsPicker: UIPickerView!
    @IBOutlet var ageRangePicker: UIPickerView!
    @IBOutlet var agePicker: UIPickerView!
    
    @IBOutlet var submittedLabel: UILabel!
    @IBOutlet var monthsPicker: UIPickerView!
    let genderArray = ["Male", "Female"]
    let ageRangeArray = ["<12", "12-17", "18-24", "25-34","35-44","45-54","55-64","65-74","75+"]
    let monthsArray = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    var age = ""
    var ageRange = ""
    var gender = ""
    var language = ""
    var birthday = ""
    var birthyear = ""
    var day = ""
    var month = ""
    var year = ""
    
    
        @IBAction func submitButtonAction(_ sender: AnyObject) {
        
            language = languageTextField.text!
        if day != "" && month != "" && year != "" {
            
            birthday = "\(month), \(day), \(year)"
        }
        
            TwineDemographicsMessage().send(gender, birthDay: birthday, birthYear: year, age: age,  ageRange: ageRange)
        submittedLabel.text = "Posted! Gender: \(gender), Age: \(age), Age Range: \(ageRange), Birthday: \(birthday), Language: \(language))"
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 {
            return 100
        }
        else if pickerView.tag == 1 {
            return 9
        }
        
        else if pickerView.tag == 2 {
            return 2
        }
        else if pickerView.tag == 3 {
            return 31
        }
        else if pickerView.tag == 4{
            return 12
        }
        else if pickerView.tag == 5 {
            return 100
        }
        return 1
    }
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            return "\(row + 5)"
        }
        else if pickerView.tag == 1 {
            return ageRangeArray[row]
        }
            
        else if pickerView.tag == 2 {
            return genderArray[row]
        }
        else if pickerView.tag == 3 {
            return "\(row)"
        }
        else if pickerView.tag == 4{
            NSLog("monthsarray")
            return monthsArray[row]
        }
        else if pickerView.tag == 5 {
            return "\(1910 + row)"
        }
        
      return "tralallaa"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //do something with pick
        if pickerView.tag == 0 {
            age = "\(row + 5)"
        }
        else if pickerView.tag == 1 {
            ageRange = ageRangeArray[row]
        }
            
        else if pickerView.tag == 2 {
             gender = genderArray[row]
        }
        else if pickerView.tag == 3 {
            day = "\(row)"
        }
        else if pickerView.tag == 4{
            NSLog("monthsarray")
            month = monthsArray[row]
        }
        else if pickerView.tag == 5 {
            year =  "\(1910 + row)"
        }

    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPickers()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    
    func setUpPickers() {
        
        agePicker.dataSource = self
        agePicker.delegate = self
        agePicker.tag = 0
        
        ageRangePicker.dataSource = self
        ageRangePicker.delegate = self
        ageRangePicker.tag = 1
        
        genderPicker.dataSource = self
        genderPicker.delegate = self
        genderPicker.tag = 2
        
        
        daysPicker.dataSource = self
        daysPicker.delegate = self
        daysPicker.tag = 3

        monthsPicker.dataSource = self
        monthsPicker.delegate = self
        monthsPicker.tag = 4
        
        yearsPicker.dataSource = self
        yearsPicker.delegate = self
        yearsPicker.tag = 5

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
