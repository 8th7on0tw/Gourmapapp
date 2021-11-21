//
//  DetailViewModel.swift
//  Gourmap
//
//  Created by hiro on 2021/10/15.
//

import Foundation
import RealmSwift

let detailUseCase = DetailUseCase()

class DetailViewModel {
    func getShopData(shop_id: String,completion: (ShopList) -> Void) {
        switch detailUseCase.getShopDetail(shop_id: shop_id) {
        case .success(let shopData):
            guard let shopData = shopData else { break }
            completion(shopData)
            break
        case .failure(_):
            break
        }
    }
    
    func makeContentsDetail(data: ShopList) -> [String?] {
        var makeCell:[String?] = []
        makeCell.append(data.shop_name)
        makeCell.append(Optional(nil)) //電話番号
        makeCell.append(data.shop_address)
        makeCell.append(Optional(nil))//最寄駅
        makeCell.append(Optional(nil))//交通アクセス
        makeCell.append(Optional(nil))//営業時間
        makeCell.append(Optional(nil))//定休日
        makeCell.append(Optional(nil))//予算
        makeCell.append(Optional(nil))//カード利用
        makeCell.append(Optional(nil))//総席数
        makeCell.append(Optional(nil))//駐車場
        makeCell.append(Optional(nil))//PCクーポン
        makeCell.append(Optional(nil))//スマホクーポン
        return makeCell
    }
}
