//
//  ViewController.swift
//  BluetoothSDK
//
//  Created by sang on 13/10/1444 AH.
//

import UIKit
import Toast
import SwiftUI
import SPIndicator

class ViewController: UIViewController {

    @IBOutlet weak var gonext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Toast("Initilize SDK").show(self)
        // Do any additional setup after loading the view.
        ToastView.self
        
        //let indicatorView = SPIndicatorView(title: "Complete", preset: .done)
        //indicatorView.present(duration: 3)
        
       

        // or for custom `SPIndicatorView`

        //indicatorView.presentSide = .bottom
    }

    @IBAction func mygonext(_ sender: UIButton) {
        SPIndicator.present(title: "Initilize Successfully", message: "bluetooth SDk successfully initilized successfully done.", preset: .done, from: .bottom)
    
        let sec = storyboard?.instantiateViewController(identifier: "bluelist") as! BluetoothListActivity
                    present(sec,animated: true)
        
        
        
    
    }
    
}
class Toast: UILabel {

private let BOTTOM_MARGIN: CGFloat = 16
private let SIDE_MARGIN: CGFloat = 16
private let HEIGHT: CGFloat = 35
private let SHOW_TIME_SECONDS = TimeInterval(3)
private let BACKGROUND_COLOR = UIColor.darkGray.withAlphaComponent(0.7).cgColor
private let TEXT_COLOR = UIColor.white
private let ANIMATION_DURATION_SEC = 0.33

private static var queue: [ToastHolder] = []
private static var showing: Toast?

init(_ text: String) {
    super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    self.text = text
    self.textColor = TEXT_COLOR
    textAlignment = .center
    self.layer.backgroundColor = BACKGROUND_COLOR
    self.layer.cornerRadius = 5
}

public func show(_ parent: UIViewController) {
    frame = CGRect(x: SIDE_MARGIN, y: UIScreen.main.bounds.height - BOTTOM_MARGIN - HEIGHT, width: UIScreen.main.bounds.width - 2 * SIDE_MARGIN, height: HEIGHT)

    if Toast.showing == nil {
       // Log.d("showing \(String(describing: text))")
        Toast.showing = self
        alpha = 0
        parent.view.addSubview(self)
        UIView.animate(withDuration: ANIMATION_DURATION_SEC, animations: {
            self.alpha = 1
        }, completion: { (completed) in
            Timer.scheduledTimer(timeInterval: self.SHOW_TIME_SECONDS, target: self, selector: #selector(self.onTimeout), userInfo: nil, repeats: false)
        })
    } else {
        Toast.queue.append(ToastHolder(self, parent))
    }
}

@objc func onTimeout() {
    UIView.animate(withDuration: ANIMATION_DURATION_SEC, animations: {
        self.alpha = 0
    }, completion: { (completed) in
        Toast.showing = nil
        self.removeFromSuperview()

        if !Toast.queue.isEmpty {
            let holder = Toast.queue.removeFirst()
            holder.toast.show(holder.parent)
        }
    })
}

required init?(coder aDecoder: NSCoder) {
    fatalError("this initializer is not supported")
}

private class ToastHolder {
    let toast: Toast
    let parent: UIViewController

    init(_ t: Toast, _ p: UIViewController) {
        toast = t
        parent = p
    }
}
}
