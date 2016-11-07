//
//  LocationViewController.swift
//  TwineSDK
//
//  Created by John Mohler on 10/3/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

import UIKit

class TwineLocationViewController: UIViewController {
    @IBOutlet var timeLabel: UILabel!

    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var adIdLabel: UILabel!
    @IBOutlet var horizontalAccuracyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        TwineScanManager.shared()

        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.scanDone(_:)),name:NSNotification.Name(rawValue: "twineLocationScanDone"), object: nil)

        // Do any additional setup after loading the view.
    }
    
    
    func scanDone(_ notification: Notification){

        let userInfo : [String:[AnyObject]?] = (notification as NSNotification).userInfo as! [String:[AnyObject]?]
        var result: [AnyObject] = userInfo["Result"]!!

        NSLog("twineLocationScanDone notification received")
        DispatchQueue.main.async{
            self.timeLabel.text = result[0] as? String
            self.adIdLabel.text = result[1] as? String
            self.latitudeLabel.text = result[2] as? String
            self.longitudeLabel.text = result[3] as? String
            self.horizontalAccuracyLabel.text = result[4] as? String
        }

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
