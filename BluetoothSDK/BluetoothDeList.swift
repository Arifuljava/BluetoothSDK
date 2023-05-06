//
//  BluetoothDeList.swift
//  BluetoothSDK
//
//  Created by sang on 15/10/1444 AH.
//

import UIKit

class BluetoothDeList: UIViewController {

    @IBOutlet weak var syncButton: UIButton!
    @IBOutlet weak var blueOff: UIButton!
    @IBOutlet weak var blueOn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func clicksync(_ sender: UIButton) {
        let alert = UIAlertController(title: "Sync Devices", message: "Are you want to sync bluetooth devices?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch action.style{
                case .default:
                let url = URL(string: "App-Prefs:root=Bluetooth") //for bluetooth setting
                let app = UIApplication.shared
                app.openURL(url!)
                print("default")
                
               
                case .cancel:
                
                print("cancel")
                
                
                case .destructive:
                
                print("destructive")
                
                
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func clickOFF(_ sender: UIButton) {
        let alert = UIAlertController(title: "Bluetooth OFF", message: "Are you want to off bluetooth?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch action.style{
                case .default:
                let url = URL(string: "App-Prefs:root=Bluetooth") //for bluetooth setting
                let app = UIApplication.shared
                app.openURL(url!)
                print("default")
                
               
                case .cancel:
                
                print("cancel")
                
                
                case .destructive:
                
                print("destructive")
                
                
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func clickblueOn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Bluetooth On", message: "Are you want to On bluetooth?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch action.style{
                case .default:
                let url = URL(string: "App-Prefs:root=Bluetooth") //for bluetooth setting
                let app = UIApplication.shared
                app.openURL(url!)
                print("default")
                
               
                case .cancel:
                
                print("cancel")
                
                
                case .destructive:
                
                print("destructive")
                
                
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    

}
