//
//  UIViewController + Ext.swift
//  RESO-Project
//
//  Created by Andrey on 07.05.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
