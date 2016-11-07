//
//  TwineDeviceTableViewCell.swift
//  Twine SDK
//
//  Created by John Mohler on 9/26/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

import UIKit

class TwineDeviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet weak var aquireDataLabel: UILabel!
    
    @IBAction func `switch`(_ sender: AnyObject) {
        
        if switchOutlet.isOn  {
            
            TwineScanManager.shared()
            
        //    TwineScanManager.shared().sendLocation(0.0, longitude: 0.0, horizontalAccuracy: 0.0);
        //    TwineScanManager.shared().sendDevice();
            
            switchOutlet.isEnabled = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "twineDeviceScanStarted"), object: nil)
            
        }

    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(TwineDeviceTableViewCell.scanDone(_:)),name:NSNotification.Name(rawValue: "twineDeviceScanDone"), object: nil)
        
    }
    
    func scanDone(_ notification: Notification) {
        
        DispatchQueue.main.async{
            self.switchOutlet.setOn(false, animated: true)
            self.switchOutlet.isEnabled = true
        }
    }
    
}
