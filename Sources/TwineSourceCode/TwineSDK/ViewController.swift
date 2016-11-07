//
//  ViewController.swift
//  TWRSwiftSDK
//
//  Created by JP Mohler on 4/22/16.
//  Copyright © 2016 JP Mohler. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation
import SystemConfiguration.CaptiveNetwork

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
 {

    var result: [AnyObject] = []
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var twrTabBarItem: UITabBarItem!
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 152/255, blue: 152/255, alpha: 1.0)
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "Avenir-Black", size: 20)!
        ]

        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.scanDone(_:)),name:NSNotification.Name(rawValue: "scanDone"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.scanStarted(_:)),name:NSNotification.Name(rawValue: "scanStarted"), object: nil)

    }
    
    func scanStarted(_ notification: Notification) {
        
        self.tableView.isUserInteractionEnabled = false

    }
    
    
    
    func scanDone(_ notification: Notification){
        
        let userInfo : [String:[AnyObject]?] = (notification as NSNotification).userInfo as! [String:[AnyObject]?]
        result = userInfo["Result"]!!
    

        DispatchQueue.main.async{
            //code
        
        self.tableView.reloadData()
        self.tableView.isUserInteractionEnabled = true
        }
        
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
            
        else if section == 1 {
            
            return 6
        }  else if section == 2 {
            
            if result.count == 0 {
                return 0
            }
            
            else {
                return result[4].count
            }
            
        }
        else if section == 3 {
            
            return 1
            
        }
            
        else {
            return 0
        }
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).row == 0 && (indexPath as NSIndexPath).section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScanCell", for: indexPath) as! ScanTableViewCell
            
            cell.scanningStateLabel?.font = UIFont(name:"avenir-black", size:17)
            cell.scanColonLabel?.font = UIFont(name:"avenir", size:16)

            NSLog("1")

            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            NSLog("2")


            cell.backgroundColor = UIColor.white
            cell.textLabel?.textColor = UIColor.black
            
            if result.count != 0 {

            if (indexPath as NSIndexPath).section == 1 {

                if (indexPath as NSIndexPath).row == 0 {
                    
                    cell.textLabel?.font = UIFont(name:"avenir", size:15)

                    cell.textLabel?.text = "Model Name:  \(result[0])"
                }
                
                else if (indexPath as NSIndexPath).row == 1 {
                    
                    cell.textLabel?.font = UIFont(name:"avenir", size:15)
                    cell.textLabel?.text = "App Name:  \(result[1])"

                }
                
                else if (indexPath as NSIndexPath).row == 2 {
                    
                    cell.textLabel?.font = UIFont(name:"avenir", size:12)
                    cell.textLabel?.text = "Ad ID:  \(result[2])"
                    
                }
                
                else if (indexPath as NSIndexPath).row == 3 {
                    
                    cell.textLabel?.font = UIFont(name:"avenir", size:15)

                    cell.textLabel?.text = "Connected Wi-Fi:  \(result[3])"
                    
                }
                
                else if (indexPath as NSIndexPath).row == 4 {
                    
                    cell.textLabel?.font = UIFont(name:"avenir", size:11)

                    cell.textLabel?.text = "iBeacon:  0CF052C2-97CA-407C-84F8-B62AAC4E9027"

                }
                
                else if (indexPath as NSIndexPath).row == 5 {
                   
                    cell.textLabel?.font = UIFont(name:"avenir", size:12)
                    cell.textLabel?.text = "Location: \(result[6])"
                    
                }
                
            }
            else if (indexPath as NSIndexPath).section == 2 {
                
                
                cell.textLabel?.font = UIFont(name:"avenir", size:12)

                cell.textLabel?.text = "BLE Device"

            }
                
            else if (indexPath as NSIndexPath).section == 3 {
                
                cell.textLabel?.text = "\(result[5])"
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
        } else if section == 2 {
            
            return "BLE Devices"
        } else if section == 3 {
            
            return "Last Scan Time"
        }
        
        return "title"
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
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

