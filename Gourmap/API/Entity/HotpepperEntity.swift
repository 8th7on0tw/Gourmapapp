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
//    var results_available: Int?
    var results_returned: String
    var results_start: Int
    var shop: [Shop]
}

struct Shop: Codable{
    var address: String
    var genre: Genre
    var lat: Double
    var lng: Double
    var logo_image: String
    var name: String
    var id: String
    var photo: Photo
}

struct Genre: Codable{
    var name: String
}

struct Photo: Codable{
    var pc :Pc
    var mobile :Mobile
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
