//
//  UIViewController+presentAlert.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/17/22.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
