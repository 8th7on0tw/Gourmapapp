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
        makeCell.append(data.shop_name) //店名
        makeCell.append(data.shop_urls_pc) //店舗ページ
        makeCell.append(data.shop_address) //住所
        makeCell.append(data.shop_station_name)//最寄駅
        makeCell.append(data.shop_access)//交通アクセス
        makeCell.append(data.shop_open)//営業時間
        makeCell.append(data.shop_close)//定休日
        makeCell.append(data.shop_budget_name)//予算
        makeCell.append(data.shop_card)//カード利用
        makeCell.append(String(data.shop_capacity))//総席数
        makeCell.append(data.shop_parking)//駐車場
        makeCell.append(data.shop_coupon_urls_pc)//PCクーポン
        makeCell.append(data.shop_coupon_urls_sp)//スマホクーポン
        return makeCell
    }
}
