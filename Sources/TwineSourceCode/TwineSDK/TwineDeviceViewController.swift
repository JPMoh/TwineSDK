//
//  TwineDeviceViewController.swift
//  Twine SDK
//
//  Created by John Mohler on 9/26/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

import UIKit

class TwineDeviceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var result: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 152/255, blue: 152/255, alpha: 1.0)
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "Avenir-Black", size: 20)!
        ]
        
        NotificationCenter.default.addObserver(self, selector: #selector(TwineDeviceViewController.scanDone(_:)),name:NSNotification.Name(rawValue: "twineDeviceScanDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TwineDeviceViewController.scanStarted(_:)),name:NSNotification.Name(rawValue: "twineDeviceScanStarted"), object: nil)
        
    }
    
    func scanStarted(_ notification: Notification) {
        
        
    }
    
    func scanDone(_ notification: Notification){
        
        
        let userInfo : [String:[AnyObject]?] = (notification as NSNotification).userInfo as! [String:[AnyObject]?]
        NSLog("scan done pre result")
        result = userInfo["Result"]!!
        NSLog("scan done post result")
        NSLog("\(result)")

        DispatchQueue.main.async{
            //code
            
            self.tableView.reloadData()
        }
        
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 8
        }
        else if section == 2 {
            return 1
        }
        else {
            return 0
        }
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).row == 0 && (indexPath as NSIndexPath).section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwineDeviceScanCell", for: indexPath) as! TwineDeviceTableViewCell
            
            cell.aquireDataLabel?.font = UIFont(name:"avenir", size:16)
            
            
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwineDeviceCell", for: indexPath)
            
            
            
            cell.backgroundColor = UIColor.white
            cell.textLabel?.textColor = UIColor.black
            
            if result.count != 0 {
                
                if (indexPath as NSIndexPath).section == 1 {
                    
                    if (indexPath as NSIndexPath).row == 0 {
                        
                        cell.textLabel?.font = UIFont(name:"avenir", size:15)
                        
                        cell.textLabel?.text = "Ad ID:  \(result[0])"
                    }
                        
                    else if (indexPath as NSIndexPath).row == 1 {
                        
                        cell.textLabel?.font = UIFont(name:"avenir", size:15)
                        cell.textLabel?.text = "OS Version:  \(result[1])"
                        
                    }
                        
                    else if (indexPath as NSIndexPath).row == 2 {
                        
                        cell.textLabel?.font = UIFont(name:"avenir", size:12)
                        
                        cell.textLabel?.text = "Wireless Carrier:  \(result[2])"
                        
                        
                    }
                        
                    else if (indexPath as NSIndexPath).row == 3 {
                        
                        cell.textLabel?.font = UIFont(name:"avenir", size:15)
                        
                        cell.textLabel?.text = "Country Code:  \(result[3])"
                        
                        
                        
                    }
                        
                    else if (indexPath as NSIndexPath).row == 4 {
                        
                        cell.textLabel?.font = UIFont(name:"avenir", size:11)
                        
                        cell.textLabel?.text = "Language:  \(result[4])"
                        
                    }
                        
                    else if (indexPath as NSIndexPath).row == 5 {
                        
                        cell.textLabel?.font = UIFont(name:"avenir", size:12)
                        cell.textLabel?.text = "Handset Model: \(result[5])"
                        
                    }
                    else if (indexPath as NSIndexPath).row == 6 {
                        
                        cell.textLabel?.font = UIFont(name:"avenir", size:12)
                        cell.textLabel?.text = "Bundle ID: \(result[6])"
                        
                    }
                    else if (indexPath as NSIndexPath).row == 7 {
                        
                        cell.textLabel?.font = UIFont(name:"avenir", size:12)
                        cell.textLabel?.text = "Time Point: \(result[7])"
                        
                    }


                    
                }
                else if (indexPath as NSIndexPath).section == 2 {
                    
                    cell.textLabel?.text = "\(result[8])"
                    cell.textLabel?.font = UIFont(name:"avenir", size:15)
                    
                }
                else {
                    cell.textLabel?.text = "\((indexPath as NSIndexPath).row)"
                }
                
                
            }
            
            return cell
            
        }
    }
    
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Start a Scan"
        }
        else if section == 1 {
            
            return "Device Info"
        }  else if section == 2 {
            
            return "Last Aquisition Time"
        }
        
        return "title"
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NSLog("\(indexPath)")

    }
    
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let title = UILabel()    
        title.font = UIFont(name: "Avenir-Black", size: 18)!
        title.textColor = UIColor.white
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
       header.contentView.backgroundColor = UIColor(red: 38/255, green: 36/255, blue: 96/255, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
