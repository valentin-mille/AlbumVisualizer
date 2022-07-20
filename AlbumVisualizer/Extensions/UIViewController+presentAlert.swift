//
//  UIViewController+presentAlert.swift
//  AlbumVisualizer
//
//  Created by Valentin Mille on 7/17/22.
//

import Foundation
import UIKit

extension UIViewController {
    func presentNetworkAlert() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: Strings.Network.title, message: Strings.Network.message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true)
        }
    }
}
