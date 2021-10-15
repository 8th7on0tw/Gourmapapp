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
}
