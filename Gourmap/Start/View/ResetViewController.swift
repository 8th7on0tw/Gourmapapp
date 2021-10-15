//
//  ResetViewController.swift
//  Gourmap
//
//  Created by hiro on 2021/08/28.
//

import UIKit
import NCMB

class ResetViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mailAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mailAddress.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func send(_ sender: Any) {
        
        if mailAddress.text == "" {
            alert(message: "メールアドレスを入力してください")
            return
        }
        
        if let mailAddress = mailAddress.text{
            NCMBUser.requestPasswordReset(mailAddress: mailAddress)
            alert(message: "パスワード再設定用メールを送信しました")
        }
    }
    
    private func alert(message: String) {
        let alertController = UIAlertController(title: "",message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}
