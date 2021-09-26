//
//  StartViewModel.swift
//  Gourmap
//
//  Created by hiro on 2021/08/23.
//

//import Foundation
//import NCMB
//
//class StartViewModel: NSObject {
//
//    func loginUser(mailAddress: String,password: String){
//
//        NCMBUser.logInInBackground(mailAddress: mailAddress, password: password, callback: { result in
//            switch result {
//            case .success:
//                print("ログインに成功しました")
//                if let user = NCMBUser.currentUser {
//                    print("ログイン中のユーザー: \(user.userName!)")
//                } else {
//                    print("ログインしていません")
//                }
//
//            case let .failure(error):
//                print("ログインに失敗しました: \(error)")
//            }
//        })
//
//    }
//
//}
