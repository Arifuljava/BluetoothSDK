//
//  BluetoothDeList.swift
//  BluetoothSDK
//
//  Created by sang on 15/10/1444 AH.
//

import UIKit
import CoreBluetooth
import CoreBluetooth
import Foundation

var managerBLE: CBCentralManager?

class BluetoothDeList: UIViewController {

    @IBOutlet weak var labb: UILabel!
    @IBOutlet weak var syncButton: UIButton!
    @IBOutlet weak var blueOff: UIButton!
    @IBOutlet weak var blueOn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //MyToast.show(message: "Hello, Toast!", controller: self)
        // Do any additional setup after loading the view.
        var cmc: CBPeripheralManager!
                   cmc = CBPeripheralManager.init()
                   
                   peripheralManagerDidUpdateState(peripheral: cmc)
      
        
    }
    
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {

            var statusMessage = ""
            //TestView.text  = "clicked"
            switch peripheral.state {
            case .poweredOn:
                statusMessage = "Bluetooth Status: Turned On"
               

            case .poweredOff:
                statusMessage = "Bluetooth Status: Turned Off"
                

            case .resetting:
                statusMessage = "Bluetooth Status: Resetting"
              

            case .unauthorized:
                statusMessage = "Bluetooth Status: Not Authorized"

            case .unsupported:
                statusMessage = "Bluetooth Status: Not Supported"
                

            case .unknown:
              
                statusMessage = "Bluetooth Status: Unknown"
               /*
                let alert = UIAlertController(title: "Bluetooth Status", message: "Bluetooth status is off. Please enable/ON  bluetooth.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
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
                */
               
            }

            print(statusMessage)

            if peripheral.state == .poweredOff {
                //TODO: Update this property in an App Manager class
            }
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


