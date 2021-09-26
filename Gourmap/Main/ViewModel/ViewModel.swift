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
}
