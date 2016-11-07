//
//  ViewControllerExtensionViewController.swift
//  TwineSDK
//
//  Created by John Mohler on 10/3/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
