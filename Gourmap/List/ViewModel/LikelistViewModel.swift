//
//  LikelistViewModel.swift
//  Gourmap
//
//  Created by hiro on 2021/09/05.
//

import Foundation

class LikelistViewModel {
    let likeUseCase = LikeUseCase()
    
    func saveLikeShop(data: ShopPinAnnotation){
        let likeEntity = ShopList()
        likeEntity.createLikeEntity(data: data)
        likeUseCase.saveLikeShop(likeShop: likeEntity)
    }
    
    func getLikeStatus(shop_id: String,completion: (Bool) -> Void) {
        switch likeUseCase.getLikeStatus(shop_id: shop_id) {
        case .success(let likeStatus):
            completion(likeStatus)
            break
        case .failure(let error):
            completion(false)
            print(error)
            break
        }
    }
    
    func deleteLikeShop(data: ShopPinAnnotation){
        let likeEntity = ShopList()
        likeEntity.createLikeEntity(data: data)
        likeUseCase.deleteLikeShop(likeShop: likeEntity)
    }
}

