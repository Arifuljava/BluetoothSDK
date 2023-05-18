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
import SPIndicator
import Bluejay
import Bluejay


var peripherals:[CBPeripheral] = []
var centralManager: CBCentralManager!
var managerBLE: CBCentralManager?
var arr = Array<String>()
class BluetoothDeList: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CBCentralManagerDelegate {
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
    
      var cbcm: CBCentralManager!;
    
    @IBOutlet weak var hintText: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var labb: UILabel!
    @IBOutlet weak var syncButton: UIButton!
    @IBOutlet weak var blueOff: UIButton!
    @IBOutlet weak var blueOn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //MyToast.show(message: "Hello, Toast!", controller: self)
        // Do any additional setup after loading the view.
        hintText.isHidden = true
        pickerView.isHidden = true
        
        
        pickerView.dataSource = self
                
        pickerView.delegate = self
                  
                for i in 0..<21{
                    arr.insert("item "+(i+1).description, at: i)
                }
        cbcm = CBCentralManager();
        cbcm = CBCentralManager.init()
        self.cbcm = CBCentralManager(delegate: self, queue: nil)
        
        
        
        //
        let datata=UITapGestureRecognizer(target: self, action: #selector(mydate(sender:)))
                pickerView.isUserInteractionEnabled = true
        pickerView.addGestureRecognizer(datata)
       // centralManager = CBCentralManager(delegate: self, queue: .main)
        let bluejay = Bluejay()
        bluejay.start()
    }
    
    @objc func mydate(sender : UITapGestureRecognizer)
       {
           let bluejay = Bluejay()
           bluejay.start()
           
           let heartRateService = ServiceIdentifier(uuid: "180D")
           let bodySensorLocation = CharacteristicIdentifier(uuid: "2A38", service: heartRateService)
           let heartRate = CharacteristicIdentifier(uuid: "2A37", service: heartRateService)
           
           bluejay.scan(
               serviceIdentifiers: [heartRateService],
               discovery: { [weak self] (discovery, discoveries) -> ScanAction in
                   guard let weakSelf = self else {
                       return .stop
                   }

                   
                   //weakSelf.discoveries = discoveries
                   //weakSelf.tableView.reloadData()
                   SPIndicator.present(title: "Devices : "+discoveries.description, message: "Bluetooth Status", preset: .done, from: .bottom)

                   return .continue
               },
               stopped: { (discoveries, error) in
                   if let error = error {
                       debugPrint("Scan stopped with error: \(error.localizedDescription)")
                   }
                   else {
                       debugPrint("Scan stopped without error.")
                   }
           })
           
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
        /*
         let bluejay = Bluejay()
         bluejay.start()
         let heartRateService = ServiceIdentifier(uuid: "180D")
         let bodySensorLocation = CharacteristicIdentifier(uuid: "2A38", service: heartRateService)
         let heartRate = CharacteristicIdentifier(uuid: "2A37", service: heartRateService)
         
         bluejay.scan(
             duration: 15,
             allowDuplicates: true,
             serviceIdentifiers: nil,
             discovery: { [weak self] (discovery, discoveries) -> ScanAction in
                 guard let weakSelf = self else {
                     return .stop
                 }

                

                 return .continue
             },
             expired: { [weak self] (lostDiscovery, discoveries) -> ScanAction in
                 guard let weakSelf = self else {
                     return .stop
                 }

                 print("Lost discovery: \(lostDiscovery)")

               

                 return .continue
         }) { (discoveries, error) in
                 if let error = error {
                     debugPrint("Scan stopped with error: \(error.localizedDescription)")
                 }
                 else {
                     debugPrint("Scan stopped without error.")
                 }
         }
         */
    
       if(flag==1)
        {
           

      
            let alert = UIAlertController(title: "Bluetooth Devices Sync", message: "Are you want to sync bluetooth devices?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                switch action.style{
                    case .default:
                    var    statusMessage = "Bluetooth Status: Alreay On. You can sync bluetooth devices "
                      SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .done, from: .bottom)
                    
                    let sec1 = self.storyboard?.instantiateViewController(identifier: "cotroller") as! BlueToothListController
                    self.present(sec1,animated: true)
                    
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
        else{
          var    statusMessage = "Bluetooth Status: Turned Off , please turn on bluetooth."
            SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
            let alert = UIAlertController(title: "Bluetooth On", message: "Are you want to turn On bluetooth?", preferredStyle: .alert)
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
    @IBAction func clickOFF(_ sender: UIButton) {
       if(flag==2)
        {
           var    statusMessage = "Bluetooth Status: Turned Off , please turn on bluetooth."
             SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
       }
        else if(flag==1)
        {
            var    statusMessage = "Bluetooth Status: Turned On. Do you want to turn off bluetooth."
              SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
              let alert = UIAlertController(title: "Bluetooth On", message: "Are you want to turn On bluetooth?", preferredStyle: .alert)
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
    @IBAction func clickblueOn(_ sender: UIButton) {
        
       if(flag==1)
        {
           var    statusMessage = "Bluetooth Status: Alreay On. "
             SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .done, from: .bottom)
       
       }
        else{
          var    statusMessage = "Bluetooth Status: Turned Off , please turn on bluetooth."
            SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
            let alert = UIAlertController(title: "Bluetooth On", message: "Are you want to turn On bluetooth?", preferredStyle: .alert)
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
    func peripheralManagerDidUpdateStateBlueayncDevices(peripheral: CBPeripheralManager!) {
        SPIndicator.present(title: ""+"statusMessage", message: "Bluetooth Status", preset: .done, from: .bottom)
           var statusMessage = ""
           //TestView.text  = "clicked"
           switch peripheral.state {
           case .poweredOn:
               statusMessage = "Bluetooth Status: Aready  On"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .done, from: .bottom)
               
               let alert = UIAlertController(title: "Sync Devices", message: "Are you want to sync bluetooth devices?", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                   switch action.style{
                       case .default:
                      
                       print("default")
                       SPIndicator.present(title: "Bluetooth devices scan is started", message: "Bluetooth Scan", preset: .done, from: .bottom)
                       
                           //let options: [String: Any] = [CBCentralManagerScanOptionAllowDuplicatesKey:NSNumber(value: false)]
                           ///cbcm?.scanForPeripherals(withServices: nil, options: nil)
                           DispatchQueue.main.asyncAfter(deadline: .now() + 60.0) {
                             //self.centralManager.stopScan()
                             print("Scanning stop")
                           }
                       
                       
                       print("Start")
                      
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
           case .poweredOff:
               statusMessage = "Bluetooth Status: Turned Off , please turn on bluetooth."
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
               let alert = UIAlertController(title: "Bluetooth On", message: "Are you want to turn On bluetooth?", preferredStyle: .alert)
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
              
               
           case .resetting:
               statusMessage = "Bluetooth Status: Resetting"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
              
               

           case .unauthorized:
               statusMessage = "Bluetooth Status: Not Authorized"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
             
               

           case .unsupported:
               statusMessage = "Bluetooth Status: Not Supported"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
            
               

           case .unknown:
               statusMessage = "Bluetooth Status: Unknown"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)

           }

           print(statusMessage)

           if peripheral.state == .poweredOff {
               //TODO: Update this property in an App Manager class
           }
}
  
    //
    func peripheralManagerDidUpdateStateBlueOff(peripheral: CBPeripheralManager!) {

           var statusMessage = ""
           //TestView.text  = "clicked"
           switch peripheral.state {
           case .poweredOn:
               statusMessage = "Bluetooth Status: Turned On"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .done, from: .bottom)
               let alert = UIAlertController(title: "Bluetooth Off", message: "Are you want to turn off  bluetooth?", preferredStyle: .alert)
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
           case .poweredOff:
               statusMessage = "Bluetooth Status: Turned Off"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
               let alert = UIAlertController(title: "Bluetooth On", message: "Are you want to turn On bluetooth?", preferredStyle: .alert)
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
               
           case .resetting:
               statusMessage = "Bluetooth Status: Resetting"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
              
               

           case .unauthorized:
               statusMessage = "Bluetooth Status: Not Authorized"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
             
               

           case .unsupported:
               statusMessage = "Bluetooth Status: Not Supported"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
            
               

           case .unknown:
               statusMessage = "Bluetooth Status: Unknown"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)

           }

           print(statusMessage)

           if peripheral.state == .poweredOff {
               //TODO: Update this property in an App Manager class
           }
}
    
    func peripheralManagerDidUpdateStateBlueon(peripheral: CBPeripheralManager!) {
        SPIndicator.present(title: ""+"statusMessage", message: "Bluetooth Status", preset: .done, from: .bottom)
           var statusMessage = ""
           //TestView.text  = "clicked"
           switch peripheral.state {
           case .poweredOn:
               statusMessage = "Bluetooth Status: Aready  On"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .done, from: .bottom)
               

           case .poweredOff:
               statusMessage = "Bluetooth Status: Turned Off , please turn on bluetooth."
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
               let alert = UIAlertController(title: "Bluetooth On", message: "Are you want to turn On bluetooth?", preferredStyle: .alert)
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
              
               
           case .resetting:
               statusMessage = "Bluetooth Status: Resetting"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
              
               

           case .unauthorized:
               statusMessage = "Bluetooth Status: Not Authorized"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
             
               

           case .unsupported:
               statusMessage = "Bluetooth Status: Not Supported"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)
            
               

           case .unknown:
               statusMessage = "Bluetooth Status: Unknown"
               SPIndicator.present(title: ""+statusMessage, message: "Bluetooth Status", preset: .error, from: .bottom)

           }

           print(statusMessage)

           if peripheral.state == .poweredOff {
               //TODO: Update this property in an App Manager class
           }
}
}


extension ViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
      
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arr.count
    }
      
}
  
  
extension ViewController : UIPickerViewDelegate{
      
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arr[row]
    }
}



