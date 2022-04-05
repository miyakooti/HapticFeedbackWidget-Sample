//
//  CoordinateData.swift
//  widgetSampleExtension
//
//  Created by Arai, Kosuke | ECMPD on 2022/04/05.
//

import Foundation

struct CoordinateData: Codable {
    let status: String?
    let code: Int?
    let data: [Datum]?
    
    init() {
        status = nil
        code = nil
        data = nil
    }
}

struct Datum: Codable {
    let uuid: String?
    let topImage: TopImage?
//    let user: User?
}

struct TopImage: Codable {
    let url: String
}

struct User: Codable {
    let url: String
}
