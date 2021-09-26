//
//  DefineAlart.swift
//  Gourmap
//
//  Created by hiro on 2021/08/28.
//

import UIKit
import Foundation

class Alert {
    
    private func alert(message: String) {
        let alertController = UIAlertController(title: "エラー",message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}
