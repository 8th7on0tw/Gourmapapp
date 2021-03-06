//
//  LikeEntity.swift
//  Gourmap
//
//  Created by hiro on 2021/09/05.
//

import Foundation
import RealmSwift

class ShopList: Object {
    @objc dynamic var api_version: String = "error"
    @objc dynamic var results_available: Int = 0
    @objc dynamic var results_returned: String = "error"
    @objc dynamic var results_start: Int = 0
    @objc dynamic var shop_address: String = "error"
    @objc dynamic var shop_genre: String = "error"
    @objc dynamic var shop_lat: Double = 0
    @objc dynamic var shop_lng: Double = 0
    @objc dynamic var shop_logo_image: String = "error"
    @objc dynamic var shop_photo_mobile: String = "error"
    @objc dynamic var shop_name: String = "error"
    @objc dynamic var object_id: String = "error"
    @objc dynamic var likeStatus: Bool  = false
    @objc dynamic var wishStatus: Bool  = false

    override static func primaryKey() -> String? {
        return "object_id"
    }
    
    func createShopDataEntity(data:ShopList){
        api_version = data.api_version
//        results_available = data.results_available
//        results_returned = data.results_returned
        results_start = data.results_start
        shop_address = data.shop_address
        shop_genre = data.shop_genre
        shop_lat = data.shop_lat
        shop_lng = data.shop_lng
        shop_logo_image = data.shop_logo_image
        shop_photo_mobile = data.shop_photo_mobile
        shop_name = data.shop_name
        object_id = data.object_id
        likeStatus = data.likeStatus
        wishStatus = data.wishStatus
    }
}
