//
//  StartViewController.swift
//  Gourmap
//
//  Created by hiro on 2021/08/17.
//

import UIKit
import NCMB
import KeychainAccess

class StartViewController: UIViewController {
    
    @IBOutlet weak var mailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var startLabel: UILabel!
    let uuid = UIDevice.current.identifierForVendor?.uuidString
    var keychain: Keychain {
        guard let identifier = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String else { return Keychain(service: "") }
        return Keychain(service: identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = NCMBUser.currentUser {
            guard let userMailAddress = keychain[string: "mailAddress"] else { return }
            self.mailAddress.text = userMailAddress
            print(userMailAddress)
            guard let userPassword = keychain[string: "password"] else { return }
            self.password.text = userPassword
            print(userPassword)
            NCMBUser.logInInBackground(mailAddress: userMailAddress, password: userPassword, callback: { result in
                switch result {
                case .success():
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "login", sender: nil)
                        }
                case .failure(_):
                    return
                }
            })
        } else {
            print("ログインしていません")
        }
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        guard let address = mailAddress.text else {
            alert(message: "メールアドレスを入力してください")
            return
        }
        
        if address == "" {
            alert(message: "メールアドレスを入力してください")
            return
        }
        
        guard let pass = password.text else {
            alert(message: "パスワードを入力してください")
            return
        }
        
        if pass == "" {
            alert(message: "パスワードを入力してください")
            return
        }
        
        NCMBUser.logInInBackground(mailAddress: address, password: pass, callback: { result in
            switch result {
            case .success:
                
                print("ログインに成功しました")
                try? self.keychain[string: "mailAddress"] = address
                try? self.keychain[string: "password"] = pass
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "login", sender: nil)
                }
                
                if let user = NCMBUser.currentUser {
                    print("ログイン中のユーザー: \(user.userName!)")
                } else {
                    print("ログインしていません")
                }
                
            case let .failure(error):
                print("ログインに失敗しました: \(error)")
                DispatchQueue.main.async {
                    self.startLabel.text = "メールアドレスまたはパスワードが違います"
                }
            }
        })
        
        
    }
    
    private func alert(message: String) {
        let alertController = UIAlertController(title: "エラー",message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
