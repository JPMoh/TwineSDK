//
//  TwineIdentityViewController.swift
//  TwineSDK
//
//  Created by John Mohler on 9/29/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

import UIKit

class TwineIdentityViewController: UIViewController {

    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var submittedLabel: UILabel!
    @IBAction func submitButtonAction(_ sender: AnyObject) {
        
        NSLog("@submit button pressed");
        TwineIdentityMessage().send(emailTextField.text!, phoneNumber: phoneNumberTextField.text!)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
