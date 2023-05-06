//
//  PrinterCategories.swift
//  BluetoothSDK
//
//  Created by sang on 15/10/1444 AH.
//

import UIKit
import CoreBluetooth
import CoreBluetooth
import SwiftUI
import SystemConfiguration
import Reachability
import GoogleUtilities_Reachability



class BluetoothViewModel: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    @Published var peripheralNames: [String] = []
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "unnamed device")
        }
    }
}
class PrinterCategories: UIViewController {

    @IBOutlet weak var labeltext: UILabel!
    @IBOutlet weak var cloudButton: UIButton!
    @IBOutlet weak var wifiButton: UIButton!
    @IBOutlet weak var bluetoothButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // Do any additional setup after loading the view.
    }
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {

            var statusMessage = ""
            //TestView.text  = "clicked"
            switch peripheral.state {
            case .poweredOn:
                statusMessage = "Bluetooth Status: Turned On"
                //TestView.text = statusMessage
                //labeltext.text = statusMessage
                let sec = storyboard?.instantiateViewController(identifier: "bluesecond") as! BluetoothSecond
                            present(sec,animated: true)

            case .poweredOff:
                statusMessage = "Bluetooth Status: Turned Off"
                //TestView.text = statusMessage
               // labeltext.text = statusMessage
                let alert = UIAlertController(title: "Bluetooth Status", message: "Bluetooth status is off. Please enable/ON  bluetooth.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
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
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
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
                

            case .resetting:
                statusMessage = "Bluetooth Status: Resetting"
                //TestView.text = statusMessage
                //labeltext.text = statusMessage

            case .unauthorized:
                statusMessage = "Bluetooth Status: Not Authorized"
                //TestView.text = statusMessage
                //labeltext.text = statusMessage
                let alert = UIAlertController(title: "Bluetooth Status", message: "Bluetooth status is not authorized. Please check bluetooth again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
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
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
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

            case .unsupported:
                statusMessage = "Bluetooth Status: Not Supported"
                //TestView.text = statusMessage
               // labeltext.text = statusMessage
                let alert = UIAlertController(title: "Bluetooth Status", message: "Bluetooth is not supported. Please check bluetooth again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
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
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
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

            case .unknown:
                let sec = storyboard?.instantiateViewController(identifier: "bluesecond") as! BluetoothDeList
                            present(sec,animated: true)
                statusMessage = "Bluetooth Status: Unknown"
               /// TestView.text = statusMessage
                let alert = UIAlertController(title: "Bluetooth Status", message: "Bluetooth status is unknown. Please check bluetooth again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
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
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
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
                
                //labeltext.text = statusMessage///
            }

            print(statusMessage)

            if peripheral.state == .poweredOff {
                //TODO: Update this property in an App Manager class
            }
        }
    func openBluetooth(){
        let url = URL(string: "App-Prefs:root=Bluetooth") //for bluetooth setting
        let app = UIApplication.shared
        app.openURL(url!)
    }
    @IBAction func bluetooth(_ sender: UIButton) {
            var cmc: CBPeripheralManager!
                        cmc = CBPeripheralManager.init()
                        
                        peripheralManagerDidUpdateState(peripheral: cmc)
        
        if isInternetAvailable() {
            print("if called Internet Connectivity success \(isInternetAvailable())");
        } else {
            print("else called Internet Connectivity success \(isInternetAvailable())");
        }
    }
    

    @IBAction func wifi(_ sender: UIButton) {
       
        let sec = storyboard?.instantiateViewController(identifier: "wifii") as! WifiActivity
                    present(sec,animated: true)
        
    }
    
    @IBAction func cloud(_ sender: UIButton) {
        let sec = storyboard?.instantiateViewController(identifier: "cloude") as! CloudActivity
                    present(sec,animated: true)
        
    }
   
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
         }
        }

       var flags = SCNetworkReachabilityFlags()

       if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
          return false
       }
       let isReachable = flags.contains(.reachable)
       let needsConnection = flags.contains(.connectionRequired)
       //   print(isReachable && !needsConnection)
       return (isReachable && !needsConnection)
    }
}
