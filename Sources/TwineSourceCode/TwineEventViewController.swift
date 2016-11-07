//
//  TwineEventViewController.swift
//  TwineSDK
//
//  Created by John Mohler on 9/29/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

import UIKit

class TwineEventViewController: UIViewController {
    
    @IBOutlet var detailTextView: UITextView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var submittedLabel: UILabel!
    
    @IBAction func submitButtonAction(_ sender: AnyObject) {
        
            TwineEventMessage().send(nameTextField.text!, detail: detailTextView.text!)
            submittedLabel.text = "Posted! Name: \(nameTextField.text!), Detail: \(detailTextView.text!)"

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
