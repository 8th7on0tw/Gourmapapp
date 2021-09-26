//
//  LikelistViewModel.swift
//  Gourmap
//
//  Created by hiro on 2021/09/05.
//

import Foundation

class LikelistViewModel {
    let likeUseCase = LikeUseCase()
    
    func                                                                                                 saveLikeShop(data: ShopPinAnnotation){
        let likeEntity = LikeShop()
        likeEntity.createLikeEntity(data: data)
        likeUseCase.saveLikeShop(likeShop: likeEntity)
    }
     
//    func getLikeShop() -> Result<Void,Error>{
//        switch likeUseCase.getLikeShop() {
//        case .success():
//            //成功した時の処理
//            break
//        case .failure(let error):
//            //失敗した時の処理
//            break
//        }
//        //処理がない場合はそのままViewControllerに返す
//        //return likeUseCase.getLikeShop()
//    }
    
    func deleteLikeShop(data: ShopPinAnnotation){
        let likeEntity = LikeShop()
        likeEntity.createLikeEntity(data: data)
        likeUseCase.deleteLikeShop(likeShop: likeEntity)
    }
}

