//
//  Coord.swift
//  ROOM
//
//  Created by Fukuyama, Shingo | Shin | ECMD on 2020/01/16.
//

import Foundation

struct CoordinateDetailResponse: Codable, FeedCoordinateListable {
    var id: String
    var draft: Int
    var content: String?
    var createdAt: String?
    var releasedAt: String?
    var image: Image?
    var user: Model.User?
    var items: [CoordinateDetailResponse.Item]
    var models: [CoordinateDetailResponse.FashionModel]
    var infoTags: [CoordinateDetailResponse.Tag]
    var likedUsers: [Model.User]
    var likesCount: Int
    var commentsCount: Int
    var isLiked: Bool
    var isCommented: Bool
    var canLike: Bool
    var canComment: Bool
    var isDraft: Bool {
        draft == 1
    }
    //Local variable to track if main coordinate image is changed or not
    var isImageChange: Bool = false

    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case draft
        case content
        case createdAt
        case releasedAt = "releaseAt"
        case user
        case items = "coordinateItem"
        case models = "coordinateModel"
        case infoTags = "itemTaglist"
        case image = "topImage"
        case likesCount = "cntLike"
        case commentsCount = "cntComment"
        case isLiked
        case isCommented
        case canLike
        case canComment
        case likedUsers
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(.id)
        draft = values.decodeSafely(.draft) ?? 0
        content = values.decodeSafelyIfPresent(.content)
        createdAt = values.decodeSafelyIfPresent(.createdAt)
        releasedAt = values.decodeSafelyIfPresent(.releasedAt)
        user = values.decodeSafelyIfPresent(.user)
        items = values.decodeSafelyArray(CoordinateDetailResponse.Item.self, forKey: .items)
        models = values.decodeSafelyArray(CoordinateDetailResponse.FashionModel.self, forKey: .models)
        infoTags = values.decodeSafelyArray(CoordinateDetailResponse.Tag.self, forKey: .infoTags)
        likedUsers = values.decodeSafelyArray(Model.User.self, forKey: .likedUsers)
        image = values.decodeSafelyIfPresent(.image)
        likesCount = values.decodeSafely(.likesCount) ?? 0
        commentsCount = values.decodeSafely(.commentsCount) ?? 0
        isLiked = values.decodeSafely(.isLiked) ?? false
        isCommented = values.decodeSafely(.isCommented) ?? false
        canLike = values.decodeSafely(.canLike) ?? false
        canComment = values.decodeSafely(.canComment) ?? false
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(draft, forKey: .draft)
        try container.encodeIfPresent(content, forKey: .content)
        try container.encodeIfPresent(createdAt, forKey: .createdAt)
        try container.encodeIfPresent(releasedAt, forKey: .releasedAt)
        try container.encodeIfPresent(user, forKey: .user)
        try container.encode(items, forKey: .items)
        try container.encode(models, forKey: .models)
        try container.encode(infoTags, forKey: .infoTags)
        try container.encode(likedUsers, forKey: .likedUsers)
        try container.encodeIfPresent(image, forKey: .image)
        try container.encode(likesCount, forKey: .likesCount)
        try container.encode(commentsCount, forKey: .commentsCount)
        try container.encode(isLiked, forKey: .isLiked)
        try container.encode(isCommented, forKey: .isCommented)
        try container.encode(canLike, forKey: .canLike)
        try container.encode(canComment, forKey: .canComment)
    }
}

extension CoordinateDetailResponse {
    static let heightRange: ClosedRange<Int> = 50...200
    static let ageRange: ClosedRange<Int>  = 0...99
}

extension CoordinateDetailResponse {
    struct FashionModel: Codable {
        var id: String?
        var coordId: String?
        var order: Int?
        var height: Int?
        var gender: String?
        var age: Int?
        var hairstyle: String?
        enum CodingKeys: String, CodingKey {
            case order, height, gender, age, hairstyle
            case coordId = "coordinateId"
            case id = "uuid"
        }
        static var otherCategory = "other"

        // gender property can have either key or value
        static let fashionCategoryMap: [(String, String)] = [
            ("lady", "レディース"),
            ("man", "メンズ"),
            ("kid", "キッズ")
        ]
    
        var isOtherFashionCategory: Bool {
            return gender == FashionModel.otherCategory ? true : false
        }
        
        var mappedCategoryKey: String? {
            return FashionModel.fashionCategoryMap.first(where: { $0.1 == gender })?.0
        }

        var mappedCategoryValue: String? {
            return FashionModel.fashionCategoryMap.first(where: { $0.0 == gender})?.1
        }
    }
}

extension CoordinateDetailResponse {
    struct Tag: Codable {
        var id: String
        var brand: String?
        var price: Int?
        var offsetX: Float?
        var offsetY: Float?

        enum CodingKeys: String, CodingKey {
            case id = "coordinateItemUuid"
            case brand, price, offsetX, offsetY
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decode(.id)
            brand = values.decodeSafelyIfPresent(.brand)
            price = values.decodeSafelyIfPresent(.price)
            offsetX = values.decodeSafelyIfPresent(.offsetX)
            offsetY = values.decodeSafelyIfPresent(.offsetY)
        }
    }
}

extension CoordinateDetailResponse {
    struct Item: Codable {
        struct Tag: Codable {
            var order: Int?
            var offsetX: Float?
            var offsetY: Float?
            
            var asPoint: CGPoint? {
                guard let horizontalOffset = offsetX, let verticalOffset = offsetY else {
                    return nil
                }
                return CGPoint(x: CGFloat(horizontalOffset), y: CGFloat(verticalOffset))
            }
        }

        var id: String?
        var userId: String?
        var name: String?
        var content: String?
        var size: String?
        var genreLv1Id: Int?
        var genreLv1Name: String?
        var genreLv2Id: Int?
        var genreLv2Name: String?
        var item: Model.Item?
        var brandId: Int?
        var brandName: String?
        var colorId: Int?
        var colorName: String?
        var price: Int?
        var itemTag: CoordinateDetailResponse.Item.Tag?
        var images: [Image]
        var image: Image? {
            return images.first
        }
        var croppedImage: Image?

        var localId = UUID().uuidString

        private enum CodingKeys: String, CodingKey {
            case id = "uuid"
            case name, content, size, price, item
            case userId
            case genreLv1Id
            case genreLv1Name
            case genreLv2Id
            case genreLv2Name
            case brandId
            case brandName
            case colorId
            case colorName
            case itemTag
            case images = "image"
            case croppedImage = "imageCrop"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = values.decodeSafelyIfPresent(.id)
            userId = values.decodeSafelyIfPresent(.userId)
            name = values.decodeSafelyIfPresent(.name)
            content = values.decodeSafelyIfPresent(.content)
            size = values.decodeSafelyIfPresent(.size)
            genreLv1Id = values.decodeSafelyIfPresent(.genreLv1Id)
            genreLv1Name = values.decodeSafelyIfPresent(.genreLv1Name)
            genreLv2Id = values.decodeSafelyIfPresent(.genreLv2Id)
            genreLv2Name = values.decodeSafelyIfPresent(.genreLv2Name)
            item = values.decodeSafelyIfPresent(.item)
            brandId = values.decodeSafelyIfPresent(.brandId)
            brandName = values.decodeSafelyIfPresent(.brandName)
            colorId = values.decodeSafelyIfPresent(.colorId)
            colorName = values.decodeSafelyIfPresent(.colorName)
            price = values.decodeSafelyIfPresent(.price)
            itemTag = values.decodeSafelyIfPresent(.itemTag)
            images = values.decodeSafelyArray(Image.self, forKey: .images)
            croppedImage = values.decodeSafelyIfPresent(.croppedImage)
        }
    }
}

extension CoordinateDetailResponse {
    struct Comment: Codable {
        var uuid: String?
        var content: String?
        var createdAt: String?
        var user: Model.User?
        
        //Local variable
        var isOpened: Bool? = false
    }
}

extension CoordinateDetailResponse.Item {
    var priceString: String? {
        if let price = price {
            return "¥" + "\(price)".room.setPriceFormat()
        }
        return nil
    }
}

