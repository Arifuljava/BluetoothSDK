//
//  MyListBlue.swift
//  BluetoothSDK
//
//  Created by sang on 16/5/23.
//

import UIKit
import CoreBluetooth
import SwiftUI
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

class MyListBlue: UIViewController{
   
          var bluetoothViewModel = BluetoothViewModel()
    var centralManager: CBCentralManager?
    var peripherals = Array<CBPeripheral>()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print()
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)

        // Do any additional setup after loading the view.
    }
    

    

}


extension MyListBlue: CBCentralManagerDelegate {
func centralManagerDidUpdateState(_ central: CBCentralManager) {
if (central.state == .poweredOn){
self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
}
else {
// do something like alert the user that ble is not on
}
}
 
func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
peripherals.append(peripheral)
tableView.reloadData()
}
}
 
extension MyListBlue: UITableViewDataSource {
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
 
let peripheral = peripherals[indexPath.row]
cell.textLabel?.text = peripheral.name
 
return cell
}
 
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
return peripherals.count
}
}
