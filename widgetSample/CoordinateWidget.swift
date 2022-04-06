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

struct Provider: IntentTimelineProvider {
//    このWidgetが何を表示するものなのかを表すことがポイント
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), configuration: ConfigurationIntent(), imagesURLString: [String](), deepLinks: [String]())
    }
    
    // snapshot　タイムエントリーを返す
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, imagesURLString: [String](), deepLinks: [String]())
        completion(entry)
    }
    
    // timeline　タイムエントリーにタイムポリシーを添付する。タイムポリシーは３種類ある
//    A<B>という型は、Aを継承しているB？わからん
    // ここでAPI呼べる　https://medium.com/kinandcartacreated/widgetkit-advanced-development-part-1-dbb0e49e849c
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        Loader.fetchCoordinate { coordinate in
            var entries: [SimpleEntry] = []
            let currentDate = Date()
            
            print(coordinate)
            
            if let coordinate = coordinate?.data {
                
                print("entityを生成できるかな？")
                var urlsString: [String] = []
                var deepLinks: [String] = []
                
                for value in coordinate {
                    print("あああ")
                    print(value.topImage.url)
                    print(value.user.url)
//                    guard let imageURL = value.topImage.url else { return }
                    let deepLink = value.user.url + "/coordinate/" + value.uuid
                    urlsString.append(value.topImage.url)
                    deepLinks.append(deepLink)
                }
                print("ループ終わり")
                print(urlsString)
                print(deepLinks)
                
                for hourOffset in 0 ..< 5 {
                    let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                    let entry = SimpleEntry(date: entryDate, configuration: configuration, imagesURLString: urlsString, deepLinks: deepLinks)
                    entries.append(entry)
                }
                
                
            } else {
                for hourOffset in 0 ..< 5 {
                    let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                    let entry = SimpleEntry(date: entryDate, configuration: configuration, imagesURLString: [String](), deepLinks: [String]())
                    entries.append(entry)
                }
                                
            }
            
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
                
    }
}

// 両方に共通して必要なのは、画像のURLのリスト、ディープリンク用のURLのみかな
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let imagesURLString: [String]
    let deepLinks: [String]
}

//ビューはこっちで構成する多分。受け取ったデータをどのUIに適用するか
struct coordinateEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .center, spacing: 10.0) {
            Text(entry.date, style: .time)
            if let imageUrl =  entry.imagesURLString.first {
                NetworkImage(withURL: imageUrl, size: CGSize(width: 100, height: 100))
            }
            Text("コーディネート")
        }.widgetURL(URL(string: "https://room.rakuten.co.jp/room_553edc611c/coordinate/77258da7-a5bd-4562-aa0f-26c2c21471de"))

    }
    
}

// こいつが本体な気がします　ウィジェット一個
//ひとつのExtensionで複数のウィジェットを作成することができます
// このコードはもともとあったやつで、＠mainもここにあったんだけど、複数のウィジェットを選択するにはwidgetBundleを継承してそこをmainにする必要があった
struct CoordinateWidget: Widget {
    
    let kind: String = "coordinateWidget"
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            coordinateEntryView(entry: entry) // これが実際に表示されるビュー
        }
        .configurationDisplayName("コーディネート") //ウィジェットの名前
        .description("コーディネートの最新投稿が表示されます") //ウィジェットの説明
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge]) // サポートしているウィジェットの大きさ
    }
}


@main
struct ExampleWidgets: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        CoordinateWidget()
//        CollectWidget()
    }
}

struct widgetSample_Previews: PreviewProvider {
    
    // プレビューの選択肢を定義している　嘘かも知れない これ右側のやつでしょ？開発者しか見なくない？
    static var previews: some View {
        coordinateEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), imagesURLString: [String](), deepLinks: [String]()))
            .preferredColorScheme(.light)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
//        Group {
//            widgetSampleEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), coordinateData: CoordinateData()))
//                .previewContext(WidgetPreviewContext(family: .systemSmall))
//
//            widgetSampleEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), coordinateData: CoordinateData()))
//                .previewContext(WidgetPreviewContext(family: .systemMedium))
//
//            widgetSampleEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), coordinateData: CoordinateData()))
//                .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
//        }
    }
}


