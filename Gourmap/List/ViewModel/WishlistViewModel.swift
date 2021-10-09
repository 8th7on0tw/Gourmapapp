//
//  WishlistViewModel.swift
//  Gourmap
//
//  Created by hiro on 2021/10/09.
//

import Foundation

class WishlistViewModel {
    let wishUseCase = WishUseCase()
    
    func saveWishShop(data: ShopList){
        let wishEntity = ShopList()
        wishEntity.createShopDataEntity(data: data)
        wishUseCase.saveWishShop(wishShop: wishEntity)
    }
    
    func getWishStatus(shop_id: String,completion: (Bool) -> Void) {
        switch wishUseCase.getWishStatus(shop_id: shop_id) {
        case .success(let wishStatus):
            completion(wishStatus)
            break
        case .failure(let error):
            completion(false)
            print(error)
            break
        }
    }
    
    func deleteWishShop(data: ShopList){
        let wishEntity = ShopList()
        wishEntity.createShopDataEntity(data: data)
        wishUseCase.deleteWishShop(wishShop: wishEntity)
    }
}

