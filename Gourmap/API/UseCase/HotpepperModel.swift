//
//  HotpepperModel.swift
//  Gourmap
//
//  Created by hiro on 2021/07/25.
//

import Foundation

protocol HotpepperModel {
    func getShopData(lat: String,lng: String,completion: (Result<[Hotpepper],Error>) -> Void)
}

class HotpepperModelImpl: HotpepperModel{
    
    let max: Int = 10
    var detail: Hotpepper?
    var stores: [Hotpepper] = []
    var list: [Shop] = []
    let semaphore = DispatchSemaphore(value: 0)
    
    func getShopData(lat: String,lng: String,completion: (Result<[Hotpepper],Error>) -> Void){
        var start :Int = 1
        var flag :Bool = false
        for i in 1...3 {
            if flag == true { break }
            let url = URL(string: "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=0d99f5ede1c5eb2c&lat=\(lat)&lng=\(lng)&range=1&order=4&format=json&start=\(start)&count=\(max)")!
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }
                do {
                    let store = try JSONDecoder().decode(Hotpepper.self, from: data)
                    let object = try JSONSerialization.jsonObject(with: data, options: [])
                    self.stores.append(store)
                    
                    self.list = self.list + store.results.shop
                    if store.results.shop.count < self.max {
                        flag = true
                    }
                    start = store.results.shop.count * i + 1
                    self.semaphore.signal()
                } catch let error {
                    print(error)
                    flag = true
                }
            }
            task.resume()
            semaphore.wait()
        }
        completion(Result.success(stores))
    }
}

