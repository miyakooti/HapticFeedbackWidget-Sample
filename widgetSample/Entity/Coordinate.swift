//
//  Coordinate.swift
//  HapticFeedbackSampleApp
//
//  Created by Arai, Kosuke | ECMPD on 2022/04/05.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let coordinate = try? newJSONDecoder().decode(Coordinate.self, from: jsonData)

// MARK: - Coordinate
struct Coordinate: Codable {
    let status: String
    let code: Int
    let data: [Datum]
    let meta: Meta
}

// MARK: - Datum
struct Datum: Codable {
    let uuid, name, content: String
    let draft: Int
    let releaseAt, createdAt: String
    let user: User
    let topImage: TopImage
    let cntLike, cntComment, cntItem: Int
    let isLiked, isCommented, canLike, canComment: Bool

    enum CodingKeys: String, CodingKey {
        case uuid, name, content, draft
        case releaseAt = "release_at"
        case createdAt = "created_at"
        case user
        case topImage = "top_image"
        case cntLike = "cnt_like"
        case cntComment = "cnt_comment"
        case cntItem = "cnt_item"
        case isLiked = "is_liked"
        case isCommented = "is_commented"
        case canLike = "can_like"
        case canComment = "can_comment"
    }
}

// MARK: - TopImage
struct TopImage: Codable {
    let uuid: String?
    let url: String
    let mimetype: Mimetype
    let height, width: Int
}

enum Mimetype: String, Codable {
    case imageGIF = "image/gif"
    case imageJPEG = "image/jpeg"
    case imagePNG = "image/png"
}

// MARK: - User
struct User: Codable {
    let id: String
    let url: String
    let fullname: String
    let type: TypeEnum
    let profile: Profile
    let isBlocking, canComment, canFollow: Bool
    let rank: Int
    let userIconDetail: String

    enum CodingKeys: String, CodingKey {
        case id, url, fullname, type, profile
        case isBlocking = "is_blocking"
        case canComment = "can_comment"
        case canFollow = "can_follow"
        case rank
        case userIconDetail = "user_icon_detail"
    }
}

// MARK: - Profile
struct Profile: Codable {
    let imageAvatar: TopImage

    enum CodingKeys: String, CodingKey {
        case imageAvatar = "image_avatar"
    }
}

enum TypeEnum: String, Codable {
    case member = "member"
}

// MARK: - Meta
struct Meta: Codable {
    let afterKey: String
    let nextPage: String
    let hits: Int

    enum CodingKeys: String, CodingKey {
        case afterKey = "after_key"
        case nextPage = "next_page"
        case hits
    }
}
