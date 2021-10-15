//
//  DetailUseCase.swift
//  Gourmap
//
//  Created by hiro on 2021/10/15.
//

import Foundation
import RealmSwift

class DetailUseCase{
    
    init(){
//        let config = Realm.Configuration(
//            schemaVersion: 3,
//            migrationBlock: { migration, oldSchemaVersion in
//                if (oldSchemaVersion < 1) {
//                }
//            })
//        Realm.Configuration.defaultConfiguration = config
    }
        
    func getShopDetail(shop_id: String)  -> Result<ShopList?,Error> {
        do{
            let realm = try? Realm()
            let shopData = realm?.object(ofType: ShopList.self, forPrimaryKey: shop_id)
            return Result.success(shopData)
        }catch{
            return Result.failure(error)
        }
    }
}
