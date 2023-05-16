//
//  ListWifi.swift
//  BluetoothSDK
//
//  Created by sang on 23/10/1444 AH.
//

import UIKit

class ListWifi: UIViewController {
    var names = ["THT","Space","Electrical","Company","Ltd"]
    
    @IBOutlet weak var listmylist: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        listmylist.delegate = self
        listmylist.dataSource = self
      
    }
    


}
extension ListWifi : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(names[indexPath.row])
    }
}
    extension ListWifi : UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
               return 1;
               
           }
           func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return names.count
                 
           }
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
               cell.textLabel?.text = names[indexPath.row]
               cell.textLabel?.textAlignment = .center
               //cell.textLabel?.textColor = UIColor.red
               
               
               return cell
             
           }
    
}
