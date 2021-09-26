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
        let config = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                }
            })
        Realm.Configuration.defaultConfiguration = config
    }
    
    func saveLikeShop(likeShop: LikeShop){
        let realm = try! Realm()
        let shopId = likeShop.object_id
        
        try! realm.write {
            realm.object(ofType: LikeShop.self, forPrimaryKey: shopId).map {
                realm.add($0,update: .modified)
            }
        }
    }
    
    func getLikeShop()  -> Result<Void,Error> {
        do{
            let realm = try? Realm()
            let shops = realm?.objects(LikeShop.self)
            return Result.success(())
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
