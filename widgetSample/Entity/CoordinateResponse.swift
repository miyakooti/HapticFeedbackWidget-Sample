//
//  CoordinateData.swift
//  widgetSampleExtension
//
//  Created by Arai, Kosuke | ECMPD on 2022/04/05.
//

// https://room.rakuten.co.jp/room_553edc611c/coordinate/77258da7-a5bd-4562-aa0f-26c2c21471de

import Foundation

struct CoordinateResponse: Codable {
    let status: String?
    let code: Int?
    let data: [CoordinateData]?
    
    init() {
        status = nil
        code = nil
        data = nil
    }
}

struct CoordinateData: Codable {
    let uuid: String
    let topImage: TopImage
    let user: User
    let content: String
    let cntLike: Int
}

struct TopImage: Codable {
    let url: String
}

struct User: Codable {
    let url: String
    let profile: Profile
    let fullname: String
}

struct Profile: Codable {
    let imageAvatar: ImageAvatar
}

struct ImageAvatar: Codable {
    let url: String
}
