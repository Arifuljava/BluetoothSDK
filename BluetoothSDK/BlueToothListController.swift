//
//  BlueToothListController.swift
//  BluetoothSDK
//
//  Created by sang on 18/5/23.
//

import UIKit
import CoreBluetooth
import SwiftUI
import SPIndicator
import Printer


class BlueToothListController: UIViewController , CBCentralManagerDelegate, CBPeripheralDelegate, UITableViewDelegate, UITableViewDataSource{
    private var centralManager: CBCentralManager?
        private var discoveredPeripherals: [CBPeripheral] = []
        

    @IBOutlet weak var tableView: UITableView!
    
    //cnc
    var manager:CBCentralManager!
    var peripheral:CBPeripheral!

    let BEAN_NAME = "AC695X_1(BLE)"
    var myCharacteristic : CBCharacteristic!
        
        var isMyPeripheralConected = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
               tableView.delegate = self
               tableView.dataSource = self

        // Do any additional setup after loading the view.
        
        manager = CBCentralManager(delegate: self, queue: nil)
        
        
        
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
            if central.state == .poweredOn {
                central.scanForPeripherals(withServices: nil, options: nil)
                
                centralManager?.cancelPeripheralConnection(peripheral)
                
            } else {
                print("Bluetooth is not available.")
            }
        }
   
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !discoveredPeripherals.contains(peripheral) {
           
            discoveredPeripherals.append(peripheral)
            tableView.reloadData()
            
        }
      //  print(mainflagg.description)
        if peripheral.name?.contains("AC695X_1(BLE)") == true {
           

                    self.peripheral = peripheral
                    self.peripheral.delegate = self

                    manager.connect(peripheral, options: nil)
            peripheral.delegate = self
            peripheral.discoverServices(nil)
           
                    print("My  discover peripheral", peripheral)
            self.manager.stopScan()
//check pherifiral
           
            
            
                }
        
        
        
    }
    // MARK: - UITableViewDelegate & UITableViewDataSource
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let peripheral = discoveredPeripherals[indexPath.row]
    let devicename = peripheral.identifier.uuidString
    let devicenamfe = peripheral.name
    let scond =  peripheral.name
    let alert = UIAlertController(title: scond ?? "Unknown Name "+"", message: "Are you want to connect this printer with your bluetooth?", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
        switch action.style{
            case .default:

            
           
           
            
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       /// print("se")
        return discoveredPeripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let peripheral = discoveredPeripherals[indexPath.row]
        cell.textLabel?.text = peripheral.name ?? "Unknown Device"
        cell.detailTextLabel?.text = peripheral.identifier.uuidString
        /*
         if peripheral.name?.contains("AC695X_1(BLE)") == true {

                     print("Did discover peripheral", peripheral)

             
                 }
         */
        
        return cell
    }
func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
    if let error = error {
        print("Failed to connect to peripheral: \(error.localizedDescription)")
    } else {
        print("Failed to connect to peripheral")
    }
    // Perform any necessary error handling or recovery steps
}

    func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
        print("not connect")
    }

 func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
     if peripheral.state == .connecting{
         print("ghghghg")
     }
         isMyPeripheralConected = true //when connected change to true
         peripheral.delegate = self
         peripheral.discoverServices(nil)
     let id = peripheral.identifier.uuid
     
 
     print("Conn \(id)")
     var statusMessage = "Connected Successfully with this device : "+BEAN_NAME.description
     SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .done, from: .bottom)
     
     
         
     }

    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        isMyPeripheralConected = false //and to falso when disconnected
        var statusMessage = "Can't  connected with this device : "+BEAN_NAME.description
        SPIndicator.present(title: ""+statusMessage, message: "Connection Status", preset: .error, from: .bottom)
        print("dis")
    }
    
    let Notify_BlueTooth_update = "Notify_BlueTooth_update"
    let Notify_BlueTooth_descriptor_update = "Notify_BlueTooth_descriptor_update"
    let print_characteristic_uuid = "BEF8D6C9-9C21-4C9E-B632-BD58C1009F9F"
    let print_service_uuid = "E7810A71-73AE-499D-8C15-FAA9AEF0C3F2"
    let printUI = "60520B00-43C3-55D4-E8C6-A2B64733D833"
    
    //connect pherificat


    
    var peripheralList = [CBPeripheral]()
    var currentConnect: CBPeripheral?
  
    
}
