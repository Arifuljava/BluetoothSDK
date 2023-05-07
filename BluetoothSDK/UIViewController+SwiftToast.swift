//
//  UIViewController+SwiftToast.swift
//  BluetoothSDK
//
//  Created by sang on 16/10/1444 AH.
//

import Foundation
import UIKit

public extension UIViewController {
    public func present(_ toast: SwiftToastProtocol, animated: Bool) {
        SwiftToastController.shared.present(toast, swiftToastView: SwiftToastView(), animated: animated)
    }
    
    public func present(_ toast: SwiftToastProtocol, withCustomSwiftToastView customToastView: SwiftToastViewProtocol, animated: Bool) {
        SwiftToastController.shared.present(toast, swiftToastView: customToastView, animated: animated)
    }
    
    public func dismissSwiftToast(_ animated: Bool) {
        SwiftToastController.shared.dismiss(animated)
    }
}
