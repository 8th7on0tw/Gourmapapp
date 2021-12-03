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
    @objc dynamic var results_start: Int = 0
//    @objc dynamic var results_available: Int = 0
//    @objc dynamic var results_returned: String = "error"
    @objc dynamic var shop_id: String = "error"
    @objc dynamic var shop_name: String = "error"
    @objc dynamic var shop_logo_image: String = "error"
    @objc dynamic var shop_address: String = "error"
    @objc dynamic var shop_station_name: String = "error"
    @objc dynamic var shop_lat: Double = 0
    @objc dynamic var shop_lng: Double = 0
    @objc dynamic var shop_genre_name: String = "error"
    @objc dynamic var shop_budget_name: String = "error"
    @objc dynamic var shop_capacity: Int = 0
    @objc dynamic var shop_access: String = "error"
    @objc dynamic var shop_urls_pc: String = "error"
    @objc dynamic var shop_open: String = "error"
    @objc dynamic var shop_close: String = "error"
    @objc dynamic var shop_card: String = "error"
    @objc dynamic var shop_parking: String = "error"
    @objc dynamic var shop_coupon_urls_pc: String = "error"
    @objc dynamic var shop_coupon_urls_sp: String = "error"
    @objc dynamic var shop_photo_pc_l: String = "error"
    @objc dynamic var shop_photo_pc_m: String = "error"
    @objc dynamic var shop_photo_pc_s: String = "error"
    @objc dynamic var shop_photo_mobile_l: String = "error"
    @objc dynamic var shop_photo_mobile_s: String = "error"
    
    @objc dynamic var likeStatus: Bool  = false
    @objc dynamic var wishStatus: Bool  = false

    override static func primaryKey() -> String? {
        return "shop_id"
    }
    
    func createShopDataEntity(data:ShopList){
        api_version = data.api_version
        results_start = data.results_start
        shop_id = data.shop_id
        shop_name = data.shop_name
        shop_logo_image = data.shop_logo_image
        shop_address = data.shop_address
        shop_station_name = data.shop_station_name
        shop_lat = data.shop_lat
        shop_lng = data.shop_lng
        shop_genre_name = data.shop_genre_name
        shop_budget_name = data.shop_budget_name
        shop_capacity = data.shop_capacity
        shop_access = data.shop_access
        shop_urls_pc = data.shop_urls_pc
        shop_open = data.shop_open
        shop_close = data.shop_close
        shop_card = data.shop_card
        shop_parking = data.shop_parking
        shop_coupon_urls_pc = data.shop_coupon_urls_pc
        shop_coupon_urls_sp = data.shop_coupon_urls_sp
        shop_photo_pc_l = data.shop_photo_pc_l
        shop_photo_pc_m = data.shop_photo_pc_m
        shop_photo_pc_s = data.shop_photo_pc_s
        shop_photo_mobile_l = data.shop_photo_mobile_l
        shop_photo_mobile_s = data.shop_photo_mobile_s
        likeStatus = data.likeStatus
        wishStatus = data.wishStatus
    }
}
