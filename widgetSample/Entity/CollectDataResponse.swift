//
//  CollectData.swift
//  widgetSampleExtension
//
//  Created by Arai, Kosuke | ECMPD on 2022/04/05.
//

import Foundation

struct CollectDataResponse: Codable {
    let status: String?
    let code: Int?
    let data: [CollectData]?
    
    init() {
        status = nil
        code = nil
        data = nil
    }
}

struct CollectData: Codable {
    let
}
