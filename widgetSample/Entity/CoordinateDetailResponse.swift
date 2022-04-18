//
//  CoordinateData.swift
//  widgetSampleExtension
//
//  Created by Arai, Kosuke | ECMPD on 2022/04/05.
//

// https://room.rakuten.co.jp/api/coordinate/e889e83f-6578-4da9-839b-425b805ba4a2?api_version=2

import Foundation

struct CoordinateDetailResponse: Codable {
    let status: String?
    let code: Int?
    let data: CoordinateDetailData?
    
    init() {
        status = nil
        code = nil
        data = nil
    }
}

struct CoordinateDetailData: Codable {
    let coordinateItem: [CoordinateItem]?
}

struct CoordinateItem: Codable {
    let image: [ImageInCoordinate]?
}

struct ImageInCoordinate: Codable {
    let url: String
}
