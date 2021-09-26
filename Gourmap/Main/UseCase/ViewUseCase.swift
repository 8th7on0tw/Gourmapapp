//
//  ViewUseCase.swift
//  Gourmap
//
//  Created by hiro on 2021/09/13.
//

import Foundation
import RealmSwift

class ViewUseCase {
    
    func createShopData(shops: [Hotpepper]) -> [ShopPinAnnotation] {
        var shopPinAnnotations: [ShopPinAnnotation] = []
        let realm = try! Realm()
        for i in shops{
            let count: Int = i.results.shop.count - 1
            for j in 0...count{
                let shopPinAnnotation = ShopPinAnnotation()
                shopPinAnnotation.createShopData(i: i,j: j)
                //likeStatusが取得できたら上書き
                let shopId = i.results.shop[j].id
                realm.object(ofType: LikeShop.self, forPrimaryKey: shopId)?.value(forKey: "likeStatus").map {
                    shopPinAnnotation.likeStatus = $0 as! Bool
                }
                shopPinAnnotations.append(shopPinAnnotation)
            }
        }
        return shopPinAnnotations
    }
}
