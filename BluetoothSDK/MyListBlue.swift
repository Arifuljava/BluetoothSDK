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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print()
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
               tableView.delegate = self
               tableView.dataSource = self

        // Do any additional setup after loading the view.
        
        manager = CBCentralManager(delegate: self, queue: nil)
        
    }
    

    
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
    func centralManager(_ central: CBCentralManager,
        didConnect peripheral: CBPeripheral) {
            print("connected to : "+peripheral.description)

        peripheral.discoverServices(nil)
    }
    }
