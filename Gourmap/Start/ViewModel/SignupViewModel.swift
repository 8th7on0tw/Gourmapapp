//
//  SignupViewModel.swift
//  Gourmap
//
//  Created by hiro on 2021/08/28.
//

import Foundation
import NCMB

class SignupViewModel: NSObject {
    func registration(mailAdress: String) {
        let result = NCMBUser.requestAuthenticationMailInBackground(mailAddress: mailAdress, callback: { result in
            switch result {
                case .success:
                    // 会員登録用メールの要求に成功した場合の処理
                    print("会員登録用メールの要求に成功しました")
                case let .failure(error):
                    // 会員登録用のメール要求に失敗した場合の処理
                    print("会員登録用メールの要求に失敗しました: \(error)")
            }
        })
    }

}

