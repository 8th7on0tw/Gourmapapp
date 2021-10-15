//
//  ViewModel.swift
//  Gourmap
//
//  Created by hiro on 2021/07/25.
//

import Foundation
import CoreLocation
import RealmSwift

enum ViewModelError: Error, LocalizedError {
    case hoge
    case fuga
    
    var errorDescription: String? {
        switch self {
        case .hoge:
            return "hoge Error"
        case .fuga:
            return "fuga Error"
        }
    }
}

enum SuccessPatarn{
    case start
    case shopDates([ShopPinAnnotation])
    case close
}

protocol ViewModel {
    func createShopData(lat: String,lng: String,completion:  (Result<SuccessPatarn,ViewModelError>) -> Void)
    func createDetailData(anno: ShopPinAnnotation) -> ShopList
    func registerRealmData(shop_data: ShopPinAnnotation)
}

class ViewModelImpl: ViewModel {
    let hottpepperModel: HotpepperModel = HotpepperModelImpl()
    
    func createShopData(lat: String,lng: String,completion: (Result<SuccessPatarn,ViewModelError>) -> Void){
        
        completion(Result.success(SuccessPatarn.start))
        
        hottpepperModel.getShopData(lat: lat, lng: lng) {
            switch $0 {
            case .success(let shops):
                let viewUseCase = ViewUseCase()
                var shopPinAnnotations: [ShopPinAnnotation] = []
                shopPinAnnotations = viewUseCase.createShopData(shops: shops)
                completion(Result.success(SuccessPatarn.shopDates(shopPinAnnotations)))
                completion(Result.success(SuccessPatarn.close))
                
            case .failure(let error):
                print(error)
                completion(Result.failure(ViewModelError.fuga))
            }
        }
    }
    
    func createDetailData(anno: ShopPinAnnotation) -> ShopList {
        let shopData = ShopList()
        shopData.api_version = anno.api_version
        shopData.results_available = anno.results_available
        shopData.results_returned = anno.results_returned
        shopData.results_start = anno.results_start
        shopData.shop_address = anno.shop_address
        shopData.shop_genre = anno.shop_genre
        shopData.shop_lat = anno.shop_lat
        shopData.shop_lng = anno.shop_lng
        shopData.shop_logo_image = anno.shop_logo_image
        shopData.shop_photo_mobile = anno.shop_photo_mobile
        shopData.shop_name = anno.shop_name
        shopData.object_id = anno.object_id
        shopData.likeStatus = anno.likeStatus
        shopData.wishStatus = anno.wishStatus
        return shopData
    }
    
    func registerRealmData(shop_data: ShopPinAnnotation){
        let realm = try! Realm()
        let shop_Datail = self.createDetailData(anno: shop_data)
        try! realm.write {
            realm.add(shop_Datail,update: .modified)
        }
    }
}
