//
//  Alerts.swift
//  InfosysAssignment
//
//  Created by Jayachandra on 12/13/19.
//  Copyright © 2019 BlueRose Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

protocol Alerts {
}

extension Alerts {
    func showAlert(title: String,
                   message: String,
                   from viewController: UIViewController? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        if let lFrom = viewController {
            lFrom.present(alert, animated: true, completion: nil)
        } else {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
