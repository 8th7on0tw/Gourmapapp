//
//  SignupViewController.swift
//  Gourmap
//
//  Created by hiro on 2021/08/28.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mailAddress: UITextField!
    let signupViewModel = SignupViewModel()
    
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
            signupViewModel.registration(mailAdress: mailAddress)
            alert(message: "新規登録用メールを送信しました")
        }
    }
    
    private func alert(message: String) {
        let alertController = UIAlertController(title: "",message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

}
