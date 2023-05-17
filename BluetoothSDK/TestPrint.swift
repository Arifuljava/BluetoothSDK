//
//  TestPrint.swift
//  BluetoothSDK
//
//  Created by sang on 17/5/23.
//

import UIKit

class TestPrint: UIViewController {

    @IBOutlet weak var textview: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func print(_ sender: UIButton) {
        /*
         let printController = UIPrintInteractionController.shared
         let printInfo = UIPrintInfo(dictionary: nil)
         printInfo.outputType = UIPrintInfo.OutputType.general
         printInfo.jobName = "test"
         printController.printInfo = printInfo
         
         let formatter = UIMarkupTextPrintFormatter(markupText: "Bangladesh, to the east of India on the Bay of Bengal, is a South Asian country marked by lush greenery and many waterways. Its Padma (Ganges), Meghna and Jamuna rivers create fertile plains, and travel by boat is common. On the southern coast, the Sundarbans, an enormous mangrove forest shared with Eastern India, is home to the royal Bengal tiger. ")
         formatter.perPageContentInsets = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
         printController.printFormatter = formatter
         printController.present(animated: true,completionHandler: nil)
         */
        let image = UIImage(named: "mm")
        guard UIPrintInteractionController.isPrintingAvailable else {
           // print("Printing is not available.")
            
            return
        }
        
        // Create a print interaction controller
        let printController = UIPrintInteractionController.shared
        
        // Set the printing options
        let printInfo = UIPrintInfo.printInfo()
        printInfo.outputType = .photo
        printController.printInfo = printInfo
        
        // Set the image to be printed
        printController.printingItem = image
        
        // Show the print picker
        printController.present(animated: true) { (printController, completed, error) in
            if let error = error {
              //  print("Printing failed: \(error.localizedDescription)")
            } else if completed {
               // print("Printing completed.")
            } else {
               // print("Printing canceled.")
            }
        }
        
    }
    func printImageUsingWiFiPrinter(image: UIImage) {
        // Check if the printer is available
       
    }

    // Usage
   
    
}
