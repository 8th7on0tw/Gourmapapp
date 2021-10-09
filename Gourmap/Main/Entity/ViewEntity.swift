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
    @objc dynamic var results_available: Int = 0
    @objc dynamic var results_returned: String = "error"
    @objc dynamic var results_start: Int = 0
    @objc dynamic var shop_address: String = "error"
    @objc dynamic var shop_genre: String = "error"
    @objc dynamic var shop_lat: Double = 0
    @objc dynamic var shop_lng: Double = 0
    @objc dynamic var shop_logo_image: String = "error"
    @objc dynamic var shop_name: String = "error"
    @objc dynamic var object_id: String = "error"
    @objc dynamic var wishStatus: Bool = false
    @objc dynamic var likeStatus: Bool = false
    @objc dynamic var title: String? = ""
    @objc dynamic var subtitle: String? = ""
    @objc dynamic var photo_pc: String = "error"
    @objc dynamic var photo_mobile: String = "error"
    
    func createShopData(i: Hotpepper,j: Int){
        
        coordinate.latitude = i.results.shop[j].lat
        coordinate.longitude = i.results.shop[j].lng
        api_version = i.results.api_version
//        results_available = i.results.results_available
//        results_returned = i.results.results_returned
        results_start = i.results.results_start ?? 1
        shop_address = i.results.shop[j].address
        shop_genre = i.results.shop[j].genre.name
        shop_logo_image = i.results.shop[j].logo_image
        shop_name = i.results.shop[j].name
        title = i.results.shop[j].name
        subtitle = i.results.shop[j].address
        object_id = i.results.shop[j].id
        photo_pc = i.results.shop[j].photo.pc.m
        photo_mobile = i.results.shop[j].photo.mobile.l
        likeStatus = false
    }
}
