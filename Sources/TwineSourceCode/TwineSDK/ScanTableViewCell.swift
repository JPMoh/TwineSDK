//
//  OptionsTableViewCell.swift
//  TWRSwiftSDK
//


import UIKit

class ScanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var scanColonLabel: UILabel!
    @IBOutlet weak var scanningStateLabel: UILabel!
    @IBOutlet weak var switchOutlet: UISwitch!
    @IBOutlet var activityViewOutlet: UIActivityIndicatorView!
    
    @IBAction func `switch`(_ sender: AnyObject) {
        
        if switchOutlet.isOn  {

            NSLog("scantablecell switch on")
            TwineSignalManager.shared()
            
            scanningStateLabel.text = "Scanning..."
            activityViewOutlet.startAnimating()
            switchOutlet.isEnabled = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "scanStarted"), object: nil)
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ScanTableViewCell.scanDone(_:)),name:NSNotification.Name(rawValue: "scanDone"), object: nil)
        activityViewOutlet.color = UIColor(red: 0.53, green: 0.81, blue: 0.94, alpha: 1.0)
        // Initialization code
        
    }
    
    func scanDone(_ notification: Notification) {
        
        DispatchQueue.main.async{
            
        self.switchOutlet.setOn(false, animated: true)
        self.scanningStateLabel.text = "Done Scanning"
        self.switchOutlet.isEnabled = true
            
        }
    }

}
