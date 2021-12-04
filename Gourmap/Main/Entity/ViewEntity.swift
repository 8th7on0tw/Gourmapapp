//
//  ViewEntity.swift
//  Gourmap
//
//  Created by hiro on 2021/09/13.
//

import Foundation
import MapKit

class ShopPinAnnotation: NSObject,MKAnnotation{
    
    init(latitude: CLLocationDegrees = 0.0,longitude: CLLocationDegrees = 0.0,shopName:String = "") {
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    @objc dynamic var coordinate: CLLocationCoordinate2D
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
    @objc dynamic var likeStatus: Bool = false
    @objc dynamic var wishStatus: Bool = false
    @objc dynamic var title: String? = ""
    @objc dynamic var subtitle: String? = ""
    
    func createShopData(i: Hotpepper,j: Int){
        guard let shop = i.results.shop else { return }
        coordinate.latitude = shop[j].lat
        coordinate.longitude = shop[j].lng
        api_version = i.results.api_version
        results_start = i.results.results_start ?? 1
        //        results_available = i.results.results_available
        //        results_returned = i.results.results_returned
        shop_id = shop[j].id
        shop_name = shop[j].name
        title = shop[j].name
        shop_logo_image = shop[j].logo_image
        shop_address = shop[j].address
        shop_station_name = shop[j].station_name
        shop_lat = shop[j].lat
        shop_lng = shop[j].lng
        shop_genre_name = shop[j].genre.name
        subtitle = shop[j].genre.name
        shop_budget_name = shop[j].budget.name
        shop_capacity = shop[j].capacity
        shop_access = shop[j].access
        shop_urls_pc = shop[j].urls.pc
        shop_open = shop[j].open
        shop_close = shop[j].close
        shop_card = shop[j].card
        shop_parking = shop[j].parking
        shop_coupon_urls_pc = shop[j].coupon_urls.pc
        shop_coupon_urls_sp = shop[j].coupon_urls.sp
        shop_photo_pc_l = shop[j].photo.pc.l
        shop_photo_pc_m = shop[j].photo.pc.m
        shop_photo_pc_s = shop[j].photo.pc.s
        shop_photo_mobile_l = shop[j].photo.mobile.l
        shop_photo_mobile_s = shop[j].photo.mobile.s
        
        likeStatus = false
        wishStatus = false
    }
}
