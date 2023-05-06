//
//  ViewController.swift
//  BluetoothSDK
//
//  Created by sang on 13/10/1444 AH.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gonext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func mygonext(_ sender: UIButton) {
        let sec = storyboard?.instantiateViewController(identifier: "printers") as! PrinterCategories
                    present(sec,animated: true)
    }
    
}

