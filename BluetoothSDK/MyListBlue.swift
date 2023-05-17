//
//  MyListBlue.swift
//  BluetoothSDK
//
//  Created by sang on 16/5/23.
//

import UIKit
import CoreBluetooth
import SwiftUI
import SPIndicator
import Printer

class BluetoothViewModel: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    @Published var peripheralNames: [String] = []
    
    
    //did
    
    
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

class MyListBlue: UIViewController,  CBCentralManagerDelegate, CBPeripheralDelegate, UITableViewDelegate, UITableViewDataSource{
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
        print()
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
               tableView.delegate = self
               tableView.dataSource = self

        // Do any additional setup after loading the view.
        
        manager = CBCentralManager(delegate: self, queue: nil)
        
    }
    

    var  mainflagg = 0
    var bluename = "demo"
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
            if central.state == .poweredOn {
                central.scanForPeripherals(withServices: nil, options: nil)
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
               
                
                        print("My  discover peripheral", peripheral)
                self.manager.stopScan()

                
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
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
            isMyPeripheralConected = true //when connected change to true
            peripheral.delegate = self
            peripheral.discoverServices(nil)
    
        print("Conn")
        var statusMessage = "Connected Successfully with this device : "+BEAN_NAME.description
        SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .done, from: .bottom)
        
        
            
        }
        
        func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
            isMyPeripheralConected = false //and to falso when disconnected
            var statusMessage = "Can't  connected with this device : "+BEAN_NAME.description
            SPIndicator.present(title: ""+statusMessage, message: "Connection Status", preset: .error, from: .bottom)
            print("dis")
        }
   
    
    
    /*
     func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
             guard let services = peripheral.services else { return }
             
             for service in services {
               // peripheral.discoverCharacteristics(nil, for: service)
             }
         }
     func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
             guard let characteristics = service.characteristics else { return }
             
             for characteristic in characteristics {
                 if characteristic.properties.contains(.writeWithoutResponse) {
                     printerCharacteristic = characteristic
                     break
                 }
             }
         }
         
         func printText(_ text: String) {
             var ttt = "fggfgfg"
             guard let data = ttt.data(using: .utf8) else { return }
             
             peripheral.writeValue(data, for: printerCharacteristic, type: .withoutResponse)
         }
     private var printerCharacteristic: CBCharacteristic!
     */
        
    
   /*
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
            guard let characteristics = service.characteristics else { return }
            
            for characteristic in characteristics {
                if characteristic.properties.contains(.writeWithoutResponse) {
                    printerCharacteristic = characteristic
                    break
                }
            }
        }
        
        func printText(_ text: String) {
            var ttt = "fggfgfg"
            guard let data = ttt.data(using: .utf8) else { return }
            
            peripheral.writeValue(data, for: printerCharacteristic, type: .withoutResponse)
        }
    private var printerCharacteristic: CBCharacteristic!
    */
}
