//
//  Loader.swift
//  widgetSampleExtension
//
//  Created by Arai, Kosuke | ECMPD on 2022/04/05.
//

import Foundation
import Alamofire

final class Loader {
    static func fetchCoordinate(completion: @escaping (CoordinateResponse?) -> Void) {
        AF.request("https://room.rakuten.co.jp/api/coordinate")
            .responseJSON { response in
                if response.error != nil {
                    print(response.error?.localizedDescription)
                    completion(nil)
                }
                let decoder = JSONDecoder()
                do {
                    guard let data = response.data else { return }
                    let coord: CoordinateResponse = try decoder.decode(CoordinateResponse.self, from: data)
                    completion(coord)
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
    }
    
    static func fetchCollect(completion: @escaping (CollectDataResponse?) -> Void) {
        AF.request("https://room.rakuten.co.jp/api/collect")
            .responseJSON { response in
                if response.error != nil {
                    print(response.error?.localizedDescription)
                    completion(nil)
                }
                let decoder = JSONDecoder()
                do {
                    guard let data = response.data else { return }
                    let collect: CollectDataResponse = try decoder.decode(CollectDataResponse.self, from: data)
                    completion(collect)
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
    }
    
}