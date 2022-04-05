//
//  widgetSample.swift
//  widgetSample
//
//  Created by Arai, Kosuke | ECMPD on 2022/03/23.
//

import WidgetKit
import SwiftUI
import Intents
import Alamofire
//import HapticFeedbackSampleApp

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), configuration: ConfigurationIntent(), name: "kousuke")
    }
    
    // snapshot　タイムエントリーを返す
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, name: "kousuke")
        completion(entry)
    }
    
    // timeline　タイムエントリーにタイムポリシーを添付する。タイムポリシーは３種類ある
    // ここでAPI呼べる　https://medium.com/kinandcartacreated/widgetkit-advanced-development-part-1-dbb0e49e849c
    //    isnt a return type
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        
        
        
        
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, name: "kousuke")
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        
        
        
        
        
        
        Loader.fetch { coordinate in
            print("データのロードが終わりました")
            print(coordinate)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let name: String
}

//ビューはこっちで構成する多分。受け取ったデータをどのUIに適用するか
struct widgetSampleEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .center, spacing: 10.0) {
            Text(entry.date, style: .time)
            Text(entry.name)
            Image(systemName: "figure.walk")
                .font(.system(.largeTitle).bold())
                .widgetURL(URL(string: "https://room.rakuten.co.jp/room_553edc611c/coordinate/77258da7-a5bd-4562-aa0f-26c2c21471de"))
        }
        
    }
}

// こいつが本体な気がします
@main
struct widgetSample: Widget {
    
    // ひとつのextensionで複数のUIを構築することができる。
    let kind: String = "widgetSample"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            widgetSampleEntryView(entry: entry) // これが実際に表示されるビュー
        }
        .configurationDisplayName("My Widget") //ウィジェットの名前
        .description("This is an example widget.") //ウィジェットの説明
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct widgetSample_Previews: PreviewProvider {
    static var previews: some View { // なんか選択する時のやつ？ 最初は一個だったけどなんかSMLのサイズを用意するために必要らしい
        Group {
            widgetSampleEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), name: String()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            widgetSampleEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), name: String()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            widgetSampleEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), name: String()))
                .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
        }
    }
}

final class Loader {
    static func fetch(completion: @escaping (Coordinate?) -> Void) {
        AF.request("https://room.rakuten.co.jp/api/coordinate")
            .responseJSON { response in
                if response.error != nil {
                    print("alamofire error")
                    print(response.error?.localizedDescription)
                    completion(nil)
                }
                let decoder = JSONDecoder()
                do {
                    print("do")
                    guard let data = response.data else { return }
                    let coord: Coordinate = try decoder.decode(Coordinate.self, from: data)
                    print("デコードできました", coord.status)
                    print(coord.data)
                    completion(coord)
                } catch {
                    print("parse ERROR ↓")
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
    }
    
}

struct Coordinate: Codable {
    let status: String?
    let code: Int?
    let data: [Datum]?
}
//
//// MARK: - Datum
///
///
struct Datum: Codable {
    let uuid: String?
//    let user: User?
}

struct User: Codable {
    let url: String
}
//struct Datum: Codable {
//    let uuid, name, content: String
//    let draft: Int
//    let releaseAt, createdAt: String
//    let user: User
//    let topImage: TopImage
//    let cntLike, cntComment, cntItem: Int
//    let isLiked, isCommented, canLike, canComment: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case uuid, name, content, draft
//        case releaseAt = "release_at"
//        case createdAt = "created_at"
//        case user
//        case topImage = "top_image"
//        case cntLike = "cnt_like"
//        case cntComment = "cnt_comment"
//        case cntItem = "cnt_item"
//        case isLiked = "is_liked"
//        case isCommented = "is_commented"
//        case canLike = "can_like"
//        case canComment = "can_comment"
//    }
//}
//
//// MARK: - TopImage
//struct TopImage: Codable {
//    let uuid: String?
//    let url: String
//    let mimetype: Mimetype
//    let height, width: Int
//}
//
//enum Mimetype: String, Codable {
//    case imageGIF = "image/gif"
//    case imageJPEG = "image/jpeg"
//    case imagePNG = "image/png"
//}
//
//// MARK: - User
//struct User: Codable {
//    let id: String
//    let url: String
//    let fullname: String
//    let type: TypeEnum
//    let profile: Profile
//    let isBlocking, canComment, canFollow: Bool
//    let rank: Int
//    let userIconDetail: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, url, fullname, type, profile
//        case isBlocking = "is_blocking"
//        case canComment = "can_comment"
//        case canFollow = "can_follow"
//        case rank
//        case userIconDetail = "user_icon_detail"
//    }
//}
//
//// MARK: - Profile
//struct Profile: Codable {
//    let imageAvatar: TopImage
//
//    enum CodingKeys: String, CodingKey {
//        case imageAvatar = "image_avatar"
//    }
//}
//
//enum TypeEnum: String, Codable {
//    case member = "member"
//}
//
//
//
