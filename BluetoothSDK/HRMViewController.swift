//
//  HRMViewController.swift
//  BluetoothSDK
//
//  Created by sang on 16/5/23.
//

import UIKit
import CoreBluetooth


class HRMViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var cbCentralManager: CBCentralManager?
    var cbPeripheral: CBPeripheral?
     var discoveredPeripherals = [CBPeripheral]()
    var connected = ""
    var bodyData = ""
    var manufacturer = ""
    var deviceData = ""
    var heartRate: UInt16 = 0
    var localNameArray = [String]()

    var pulseTimer: Timer?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.lightGray
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 1.0
        tableView.layer.cornerRadius = 2.0
        tableView.layer.masksToBounds = true
        let centralManager = CBCentralManager(delegate: self, queue: nil)
        self.cbCentralManager = centralManager



    }

    }
var signalStrengthMax = 20
var signalStrengthMin = 50

     extension HRMViewController : CBCentralManagerDelegate, CBPeripheralDelegate {

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {


        let localName = advertisementData[CBAdvertisementDataLocalNameKey] as? String ?? ""
        if localName.count > 0 {


            if RSSI.intValue > signalStrengthMax {

                if let index = self.discoveredPeripherals.index(of: peripheral) {
                    self.discoveredPeripherals.remove(at: index)
                    self.localNameArray.remove(at: index)
                    self.tableView.reloadData()
                }

                return
            }

            if RSSI.intValue < signalStrengthMin {

                if let index = self.discoveredPeripherals.index(of: peripheral) {
                    self.discoveredPeripherals.remove(at: index)
                    self.localNameArray.remove(at: index)
                    self.tableView.reloadData()
                }

                return
            }

            print("Discovered: \(peripheral.name ?? "a device") with udid: \(peripheral.identifier) at \(RSSI)")



            if !(self.discoveredPeripherals.contains(peripheral)) {
                self.discoveredPeripherals.append(peripheral)
                self.localNameArray.append(localName)
                self.tableView.reloadData()
            }

        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {

        peripheral.delegate = self
        peripheral.discoverServices(nil)

        self.connected = "Connected: \((peripheral.state == .connected) ? "Yes" : "No")"


    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state != .poweredOn {
            return
        }

        if central.state == .poweredOn {
            let deviceService = CBUUID(string: HRMConstants.Services.deviceInfoUUID)
            let heartRateService = CBUUID(string: HRMConstants.Services.heartRateUUID)
            let services = [deviceService,heartRateService]
            cbCentralManager?.scanForPeripherals(withServices: services, options: nil)
        }
    }


    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {

        for service in peripheral.services ?? [CBService]() {
            peripheral.discoverCharacteristics(nil, for: service)
        }

    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {

        if service.uuid == CBUUID(string: HRMConstants.Services.heartRateUUID) {
            for character in service.characteristics ?? [CBCharacteristic]() {

                if character.uuid == CBUUID(string: HRMConstants.Characteristics.measurementUUID) {
                    self.cbPeripheral?.setNotifyValue(true, for: character)
                }
                else if character.uuid == CBUUID(string: HRMConstants.Characteristics.bodyLocationUUID) {
                    self.cbPeripheral?.readValue(for: character)
                }
            }
        }

        if service.uuid == CBUUID(string: HRMConstants.Services.deviceInfoUUID) {
            for character in service.characteristics ?? [CBCharacteristic]() {
                if character.uuid == CBUUID(string: HRMConstants.Characteristics.manufacturerNameUUID) {
                    self.cbPeripheral?.readValue(for: character)
                }
            }
        }

    }


    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {

        if characteristic.uuid == CBUUID(string: HRMConstants.Characteristics.measurementUUID) {
            self.getHeartRateData(for: characteristic, error: error)
        }

        if characteristic.uuid == CBUUID(string: HRMConstants.Characteristics.manufacturerNameUUID) {
            self.getManufacturerName(for: characteristic)
        }

        else if characteristic.uuid == CBUUID(string: HRMConstants.Characteristics.bodyLocationUUID) {
            self.getBodyLocation(for: characteristic)
        }
    }
     }

     extension HRMViewController {

    func getHeartRateData(for characteristic: CBCharacteristic, error: Error?) {


        if let _ = error {
            print("Error: \(error?.localizedDescription ??  "Unknown")")
            return
        }

        guard let value = characteristic.value else { return }

        let bpm : UInt16
        if (value[0] & 0x01) == 0 {
            bpm = UInt16(value[1])
        } else {
            bpm = UInt16(littleEndian: value.subdata(in: 1..<3).withUnsafeBytes { $0.pointee } )
        }

        heartRate = bpm
        doHeartBeat()
        pulseTimer = Timer.scheduledTimer(timeInterval: 60.0 / Double(heartRate), target: self, selector: #selector(self.doHeartBeat), userInfo: nil, repeats: false)


        /*
        var reportData = [UInt8](value)
        var bpm: UInt16 = 0
        if (reportData[0] & 0x01) == 0 {
            bpm = UInt16(reportData[1])
        }
        else {
             bpm = CFSwapInt16LittleToHost(UInt16(reportData[1]))
        }
        heartRate = bpm

        doHeartBeat()
        pulseTimer = Timer.scheduledTimer(timeInterval: 60.0 / Double(heartRate), target: self, selector: #selector(self.doHeartBeat), userInfo: nil, repeats: false)
        */


    }

    func getManufacturerName(for characteristic: CBCharacteristic) {

        guard let value = characteristic.value else { return }
        let manufacturerName = String(data: value, encoding: .utf8)


    }

    func getBodyLocation(for characteristic: CBCharacteristic) {

        guard let value = characteristic.value else { return }
        var location = ""
        // 1
        var bodyData = [UInt8](value)
        if !bodyData.isEmpty {
            let bodyLocation: UInt8 = bodyData[0]
            // 2
            location = "Body Location: \(bodyLocation == 1 ? "Chest" : "Undefined")"
            // 3
        }
        else {
            // 4
            location = "Body Location: N/A"
        }
        print(location)
    }

    @objc func doHeartBeat() {


    }


    }

     extension HRMViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")

        cell?.textLabel?.text = "\(localNameArray[indexPath.row]) \(discoveredPeripherals[indexPath.row].identifier )"
        return cell!

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let newPeripheral = discoveredPeripherals[indexPath.row]

        if let _ = cbPeripheral { // had a device selected already
            if newPeripheral != cbPeripheral! { // clean up old peripheral
                self.cleanUp()
            }
        }

        cbPeripheral = newPeripheral

        self.cbCentralManager?.stopScan()
        cbPeripheral?.delegate = self
        self.cbCentralManager?.connect(cbPeripheral!, options: nil)


    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveredPeripherals.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }

    func cleanUp() {

        if !(cbPeripheral!.state == .connected) { // Don't do anything if we're not connected
            return
        }

        if let services = self.cbPeripheral!.services {
            for eachService in services {
                if let characteristics = eachService.characteristics {
                    for eachCharacteristic in characteristics {
                        if eachCharacteristic.uuid.isEqual(CBUUID(string: HRMConstants.Characteristics.bodyLocationUUID)) {
                            if eachCharacteristic.isNotifying {
                                self.cbPeripheral?.setNotifyValue(false, for: eachCharacteristic)
                            }
                        }

                        if eachCharacteristic.uuid.isEqual(CBUUID(string: HRMConstants.Characteristics.manufacturerNameUUID)) {
                            if eachCharacteristic.isNotifying {
                                self.cbPeripheral?.setNotifyValue(false, for: eachCharacteristic)
                            }
                        }

                        if eachCharacteristic.uuid.isEqual(CBUUID(string: HRMConstants.Characteristics.measurementUUID)) {
                            if eachCharacteristic.isNotifying {
                                self.cbPeripheral?.setNotifyValue(false, for: eachCharacteristic)
                            }
                        }
                    }
                }
            }
        }
        self.cbCentralManager?.cancelPeripheralConnection(self.cbPeripheral!)
        self.cbPeripheral = nil
    }

     }
