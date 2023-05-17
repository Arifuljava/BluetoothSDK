//
//  WifiActivity.swift
//  BluetoothSDK
//
//  Created by sang on 15/10/1444 AH.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
import Foundation
import Bluejay
import GoogleUtilities_Reachability
import UIKit
import CoreBluetooth
import CoreBluetooth
import SwiftUI
import SystemConfiguration
import Reachability
import GoogleUtilities_Reachability
import SPIndicator
import SystemConfiguration.CaptiveNetwork
import Printer
/*
 
 let showcontroller = UIPrintInteractionController.shared
 let printInfo = UIPrintInfo(dictionary: nil)
 printInfo.outputType = UIPrintInfoOutputType.general
 */



var array = Array<String>()

class WifiActivity: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //labb.text = ""+arr.count.description
        return arr.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //
      //  labb.text = arr[row]
        return arr[row]
    }
    
   
    

    @IBOutlet weak var wifihint: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var wifiONN: UIButton!
    @IBOutlet weak var wifiOfff: UIButton!
    @IBOutlet weak var wifisyncc: UIButton!
    
    @IBOutlet weak var hinttext: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        wifihint.isHidden = true
        pickerView.isHidden = true
        pickerView.dataSource = self
                
        pickerView.delegate = self
                  
                for i in 0..<21{
                    arr.insert("item "+(i+1).description, at: i)
                }
        hinttext.isHidden = true
        pickerView.isHidden = true
        

        // Do any additional setup after loading the view.
    }
    func getAllname() ->String?{
        var ssid: String?
                if let interfaces = CNCopySupportedInterfaces() as NSArray? {
                    for interface in interfaces {
                        if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                            ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                            break
                        }
                    }
                }
                return ssid
        
        
    }
    func getAllWiFiNameList() -> String? {
                var ssid: String?
                if let interfaces = CNCopySupportedInterfaces() as NSArray? {
                for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                            ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                            break
                        }
                    }
                }
                return ssid
            }
    @IBAction func aysncWifi(_ sender: UIButton) {
        if fetchSSIDInfo() != nil
        {
            SPIndicator.present(title: "Already wifi is open."+"Please sync for wifi channels", message: "Wifi Status", preset: .done, from: .bottom)
            let alert = UIAlertController(title: "Sync Wifi Channels", message: "wifi is stable now. you can sync wifi channels. Are you want to sync wifi channels?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                switch action.style{
                    case .default:
                    let ssid = self.getAllWiFiNameList();
                    print(ssid)
                    
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
        else
        {
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
    @IBAction func wifiON(_ sender: UIButton) {
        let info = self.getAllname();
        print(info)
       
        if fetchSSIDInfo() != nil
        {
            SPIndicator.present(title: "Already wifi is open.", message: "Wifi Status", preset: .done, from: .bottom)
        }
        else
        {
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
    
    @IBAction func wifiOf(_ sender: UIButton) {
        if fetchSSIDInfo() != nil
        {
            SPIndicator.present(title: "Already wifi is open.", message: "Wifi Status", preset: .done, from: .bottom)
        }
        else
        {
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
}
