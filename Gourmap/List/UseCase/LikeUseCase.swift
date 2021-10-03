//
//  LikeUseCase.swift
//  Gourmap
//
//  Created by hiro on 2021/09/05.
//

import Foundation
import RealmSwift

class LikeUseCase{
    
    init(){
//        let config = Realm.Configuration(
//            schemaVersion: 3,
//            migrationBlock: { migration, oldSchemaVersion in
//                if (oldSchemaVersion < 1) {
//                }
//            })
//        Realm.Configuration.defaultConfiguration = config
    }
    
    func saveLikeShop(likeShop: LikeShop){
        let realm = try! Realm()
        let shopId = likeShop.object_id
        
        try! realm.write {
            likeShop.likeStatus = true
            realm.add(likeShop,update: .modified)
//            if let likeData =  realm.object(ofType: LikeShop.self, forPrimaryKey: shopId) {
//                likeData.likeStatus = true
//                realm.add(likeData,update: .modified)
//            } else {
//                realm.add(likeShop,update: .modified)
//            }
        }
    }
    
    func getLikeStatus(shop_id: String)  -> Result<Bool,Error> {
        do{
            let realm = try? Realm()
            let shop = realm?.object(ofType: LikeShop.self, forPrimaryKey: shop_id)
            return Result.success(shop?.likeStatus ?? false)
        }catch{
            return Result.failure(error)
        }
    }
    
    func deleteLikeShop(likeShop: LikeShop){
        let realm = try! Realm()
        let shopId = likeShop.object_id
        try! realm.write {
            //高階関数　値が取得できた場合のみ処理をする
            realm.object(ofType: LikeShop.self, forPrimaryKey: shopId).map {
                realm.delete($0)
            }
        }
    }
}
