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
import SPIndicator
import SystemConfiguration.CaptiveNetwork
import CoreBluetooth

var flag = 0

func fetchSSIDInfo() ->  String {
    var currentSSID = ""
    if let interfaces:CFArray = CNCopySupportedInterfaces() {
        for i in 0..<CFArrayGetCount(interfaces){
            let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interfaces, i)
            let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
            let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString)
            if unsafeInterfaceData != nil {
                let interfaceData = unsafeInterfaceData! as Dictionary?
                for dictData in interfaceData! {
                    if dictData.key as! String == "SSID" {
                        currentSSID = dictData.value as! String
                    }
                }
            }
        }
    }
    return currentSSID
}
func isWifiEnabled() -> Bool {

        var hasWiFiNetwork: Bool = false
        let interfaces: NSArray = CFBridgingRetain(CNCopySupportedInterfaces()) as! NSArray

        for interface  in interfaces {
           // let networkInfo = (CFBridgingRetain(CNCopyCurrentNetworkInfo(((interface) as! CFString))) as! NSDictionary)
            let networkInfo: [AnyHashable: Any]? = CFBridgingRetain(CNCopyCurrentNetworkInfo(((interface) as! CFString))) as? [AnyHashable : Any]
            if (networkInfo != nil) {
                hasWiFiNetwork = true
                break
            }
        }
        return hasWiFiNetwork;
    }


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

class PrinterCategories: UIViewController, CBCentralManagerDelegate {
    var flag = 0
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
       
        var statusMessage = ""
        //TestView.text  = "clicked"
        switch central.state {
        case .poweredOn:
            statusMessage = "Bluetooth Status: Turned On"
            flag = 1
            
            SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .done, from: .bottom)
            
            //TestView.text = statusMessage
            //labeltext.text = statusMessage
            

        case .poweredOff:
            flag = 2
            statusMessage = "Bluetooth Status: Turned Off"
            SPIndicator.present(title: ""+statusMessage+" Please open bluetooth. ", message: "Bluetooth Status", preset: .done, from: .bottom)
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
            SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .done, from: .bottom)
        case .unauthorized:
            statusMessage = "Bluetooth Status: Not Authorized"
            //TestView.text = statusMessage
            //labeltext.text = statusMessage
            SPIndicator.present(title: ""+statusMessage+". Please check bluetooth again.", message: "Bluetooth Status", preset: .done, from: .bottom)
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
            SPIndicator.present(title: ""+statusMessage+". Please check bluetooth again.", message: "Bluetooth Status", preset: .done, from: .bottom)
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
            
            statusMessage = "Bluetooth Status: Unknown"
            SPIndicator.present(title: ""+statusMessage+". Please check bluetooth again.", message: "Bluetooth Status", preset: .done, from: .bottom)
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
       
    }
    func maintesting(_ central: CBCentralManager){
      
    }
    
  
    var cbcm: CBCentralManager!;
        
    @IBOutlet weak var labeltext: UILabel!
    @IBOutlet weak var cloudButton: UIButton!
    @IBOutlet weak var wifiButton: UIButton!
    @IBOutlet weak var bluetoothButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        cbcm = CBCentralManager();
        cbcm = CBCentralManager.init()
        self.cbcm = CBCentralManager(delegate: self, queue: nil)
       
        
      
        // Do any additional setup after loading the view.
    }
  
      
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {

            var statusMessage = ""
            //TestView.text  = "clicked"
            switch peripheral.state {
            case .poweredOn:
                statusMessage = "Bluetooth Status: Turned On"
                SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .done, from: .bottom)
                
                //TestView.text = statusMessage
                //labeltext.text = statusMessage
                let sec = storyboard?.instantiateViewController(identifier: "bluesecond") as! BluetoothSecond
                            present(sec,animated: true)

            case .poweredOff:
                statusMessage = "Bluetooth Status: Turned Off"
                SPIndicator.present(title: ""+statusMessage+" Please open bluetooth. ", message: "Bluetooth Status", preset: .done, from: .bottom)
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
                SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .done, from: .bottom)
            case .unauthorized:
                statusMessage = "Bluetooth Status: Not Authorized"
                //TestView.text = statusMessage
                //labeltext.text = statusMessage
                SPIndicator.present(title: ""+statusMessage+". Please check bluetooth again.", message: "Bluetooth Status", preset: .done, from: .bottom)
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
                SPIndicator.present(title: ""+statusMessage+". Please check bluetooth again.", message: "Bluetooth Status", preset: .done, from: .bottom)
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
                
                statusMessage = "Bluetooth Status: Unknown"
                SPIndicator.present(title: ""+statusMessage+". Please check bluetooth again.", message: "Bluetooth Status", preset: .done, from: .bottom)
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
          
      if(flag==1)
        {
          let sec = storyboard?.instantiateViewController(identifier: "bluesecond") as! BluetoothDeList
                                     present(sec,animated: true)
                   
                         ///SPIndicator.present(title:"Bluetooth Status: Unknown \n Please check bluetooth again.", message: "Bluetooth Status", preset: .done, from: .bottom)
      }
        else{
            let alert = UIAlertController(title: "Bluetooth Status ", message: "Bluetooth status is OFF . Please check bluetooth again.", preferredStyle: .alert)
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
        }
      }
    

    @IBAction func wifi(_ sender: UIButton) {
        if fetchSSIDInfo() != nil {
            /* Wi-Fi is Connected */
            let sec = storyboard?.instantiateViewController(identifier: "wifii") as! WifiActivity
                        present(sec,animated: true)
            
        }
        else{
            let wifiNotifcation = UIAlertController(title: "Please Connect to Wi-Fi", message: "Please connect to your standard Wi-Fi Network", preferredStyle: .alert)
            wifiNotifcation.addAction(UIAlertAction(title: "Open Wi-Fi", style: .default, handler: { (nil) in
                 let url = URL(string: "App-Prefs:root=WIFI")

                 if UIApplication.shared.canOpenURL(url!){
                       UIApplication.shared.openURL(url!)
                       self.navigationController?.popViewController(animated: false)
                 }
            }))
            self.present(wifiNotifcation, animated: true, completion: nil)
            
            SPIndicator.present(title: "Pldase turn on wifi"+". Please check wifi again.", message: "Wifi Status", preset: .done, from: .bottom)
        }
       
       
        
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
    
    
    func peripheralManagerDidUpdateState11(peripheral: CBCentralManager!) {

            var statusMessage = ""
            //TestView.text  = "clicked"
            switch peripheral.state {
            case .poweredOn:
                statusMessage = "Bluetooth Status: Turned On"
                SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .done, from: .bottom)
                
                //TestView.text = statusMessage
                //labeltext.text = statusMessage
                let sec = storyboard?.instantiateViewController(identifier: "bluesecond") as! BluetoothSecond
                            present(sec,animated: true)

            case .poweredOff:
                statusMessage = "Bluetooth Status: Turned Off"
                SPIndicator.present(title: ""+statusMessage+" Please open bluetooth. ", message: "Bluetooth Status", preset: .done, from: .bottom)
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
                SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .done, from: .bottom)
            case .unauthorized:
                statusMessage = "Bluetooth Status: Not Authorized"
                //TestView.text = statusMessage
                //labeltext.text = statusMessage
                SPIndicator.present(title: ""+statusMessage+". Please check bluetooth again.", message: "Bluetooth Status", preset: .done, from: .bottom)
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
                SPIndicator.present(title: ""+statusMessage+". Please check bluetooth again.", message: "Bluetooth Status", preset: .done, from: .bottom)
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
                
                statusMessage = "Bluetooth Status: Unknown"
                SPIndicator.present(title: ""+statusMessage+". Please check bluetooth again.", message: "Bluetooth Status", preset: .done, from: .bottom)
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
}


