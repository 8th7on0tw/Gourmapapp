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
    
    func saveLikeShop(likeShop: ShopList){
        let realm = try! Realm()
        let shop_id = likeShop.shop_id
        try! realm.write {
            realm.object(ofType: ShopList.self, forPrimaryKey: shop_id).map {
                likeShop.wishStatus = $0.wishStatus
            }
            likeShop.likeStatus = true
            realm.add(likeShop,update: .modified)
        }
    }
    
    func getLikeStatus(shop_id: String)  -> Result<Bool,Error> {
        do{
            let realm = try? Realm()
            let shop = realm?.object(ofType: ShopList.self, forPrimaryKey: shop_id)
            return Result.success(shop?.likeStatus ?? false)
        }catch{
            return Result.failure(error)
        }
    }
    
    func deleteLikeShop(likeShop: ShopList){
        let realm = try! Realm()
        let shopId = likeShop.shop_id
        try! realm.write {
            //高階関数　値が取得できた場合のみ処理をする
            realm.object(ofType: ShopList.self, forPrimaryKey: shopId).map {
                $0.likeStatus = false
                realm.add($0, update: .modified)
            }
        }
    }
}
