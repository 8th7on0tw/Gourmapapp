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
            guard let shop = i.results.shop else { return shopPinAnnotations }
            if shop.count == 0 { return shopPinAnnotations }
            for j in 0...shop.count-1{
                let shopPinAnnotation = ShopPinAnnotation()
                shopPinAnnotation.createShopData(i: i,j: j)
                let shopId = shop[j].id
                realm.object(ofType: ShopList.self, forPrimaryKey: shopId)?.value(forKey: "likeStatus").map {
                    shopPinAnnotation.likeStatus = $0 as! Bool
                    shopPinAnnotation.wishStatus = $0 as! Bool
                }
                shopPinAnnotations.append(shopPinAnnotation)
            }
        }
        return shopPinAnnotations
    }
    
}
