//
//  WishUseCase.swift
//  Gourmap
//
//  Created by hiro on 2021/10/09.
//

import Foundation
import RealmSwift

class WishUseCase{
    
    init(){
        //        let config = Realm.Configuration(
        //            schemaVersion: 3,
        //            migrationBlock: { migration, oldSchemaVersion in
        //                if (oldSchemaVersion < 1) {
        //                }
        //            })
        //        Realm.Configuration.defaultConfiguration = config
    }
    
    func saveWishShop(wishShop: ShopList){
        let realm = try! Realm()
        let shop_id = wishShop.object_id
        
        try! realm.write {
            realm.object(ofType: ShopList.self, forPrimaryKey: shop_id).map {
                wishShop.likeStatus = $0.likeStatus
            }
            wishShop.wishStatus = true
            realm.add(wishShop,update: .modified)
        }
    }
    
    func getWishStatus(shop_id: String)  -> Result<Bool,Error> {
        do{
            let realm = try? Realm()
            let shop = realm?.object(ofType: ShopList.self, forPrimaryKey: shop_id)
            return Result.success(shop?.wishStatus ?? false)
        }catch{
            return Result.failure(error)
        }
    }
    
    func deleteWishShop(wishShop: ShopList){
        let realm = try! Realm()
        let shopId = wishShop.object_id
        try! realm.write {
            //高階関数　値が取得できた場合のみ処理をする
            realm.object(ofType: ShopList.self, forPrimaryKey: shopId).map {
                $0.wishStatus = false
                realm.add($0, update: .modified)
            }
        }
    }
}
