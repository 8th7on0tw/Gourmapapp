//
//  HotpepperEntity.swift
//  Gourmap
//
//  Created by hiro on 2021/09/19.
//

import Foundation

struct Hotpepper: Codable {
    var results: Results
}

struct Results: Codable {
    var api_version: String
    var results_start: Int?
    var shop: [Shop]?
}

struct Shop: Codable{
    var id: String
    var name: String
    var logo_image: String
    var address: String
    var station_name: String
    var lat: Double
    var lng: Double
    var genre: Genre
    var budget: Budget
    var capacity: Int
    var access: String
    var urls: Urls
    var open: String
    var close: String
    var card: String
    var parking: String
    var coupon_urls: Coupon_urls
    var photo: Photo
}

struct Genre: Codable{
    var name: String
}

struct Budget: Codable{
    var name: String
}

struct Urls: Codable{
    var pc: String
}

struct Coupon_urls: Codable{
    var pc: String
    var sp: String
}

struct Photo: Codable{
    var pc: Pc
    var mobile: Mobile
}

struct Pc: Codable{
    var l: String
    var m: String
    var s: String
}

struct Mobile: Codable{
    var l: String
    var s: String
}
