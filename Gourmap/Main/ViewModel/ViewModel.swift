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
    func initialRealmData()
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
        shopData.results_start = anno.results_start
//        shopData.results_available = anno.results_available
//        shopData.results_returned = anno.results_returned
        shopData.shop_id = anno.shop_id
        shopData.shop_name = anno.shop_name
        shopData.shop_logo_image = anno.shop_logo_image
        shopData.shop_address = anno.shop_address
        shopData.shop_station_name = anno.shop_station_name
        shopData.shop_lat = anno.shop_lat
        shopData.shop_lng = anno.shop_lng
        shopData.shop_genre_name = anno.shop_genre_name
        shopData.shop_budget_name = anno.shop_budget_name
        shopData.shop_capacity = anno.shop_capacity
        shopData.shop_access = anno.shop_access
        shopData.shop_urls_pc = anno.shop_urls_pc
        shopData.shop_open = anno.shop_open
        shopData.shop_close = anno.shop_close
        shopData.shop_card = anno.shop_card
        shopData.shop_parking = anno.shop_parking
        shopData.shop_coupon_urls_pc = anno.shop_coupon_urls_pc
        shopData.shop_coupon_urls_sp = anno.shop_coupon_urls_sp
        shopData.shop_photo_pc_l = anno.shop_photo_pc_l
        shopData.shop_photo_pc_m = anno.shop_photo_pc_m
        shopData.shop_photo_pc_s = anno.shop_photo_pc_s
        shopData.shop_photo_mobile_l = anno.shop_photo_mobile_l
        shopData.shop_photo_mobile_s = anno.shop_photo_mobile_s
        shopData.likeStatus = anno.likeStatus
        shopData.wishStatus = anno.wishStatus
        return shopData
    }
    
    func registerRealmData(shop_data: ShopPinAnnotation){
        let realm = try! Realm()
        let shop_Datail = self.createDetailData(anno: shop_data)
        try! realm.write {
            realm.object(ofType: ShopList.self, forPrimaryKey: shop_data.shop_id).map {
                shop_Datail.likeStatus = $0.likeStatus
                shop_Datail.wishStatus = $0.wishStatus
            }
            realm.add(shop_Datail,update: .modified)
        }
    }
    
    func initialRealmData(){
        self.migrationRealmData()
        let realm = try! Realm()
        let targetDeleteData = realm.objects(ShopList.self).filter("likeStatus == false AND wishStatus == false")
        do{
            try realm.write{
                realm.delete(targetDeleteData)
            }
        }catch {
            print("Error \(error)")
        }
    }
    
    func migrationRealmData(){
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    //変更時の処理
                }
            })
        Realm.Configuration.defaultConfiguration = config
    }
}
