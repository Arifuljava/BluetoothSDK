//
//  MyToast.swift
//  BluetoothSDK
//
//  Created by sang on 15/10/1444 AH.
//

import Foundation
import UIKit

class MyToast {

    class func show(message: String, controller: UIViewController) {
        let toastLabel = UILabel(frame: CGRect(x: controller.view.frame.size.width/2 - 150, y: controller.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true

        controller.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
