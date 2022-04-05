//
//  widgetSample.swift
//  widgetSample
//
//  Created by Arai, Kosuke | ECMPD on 2022/03/23.
//

import WidgetKit
import SwiftUI
import Intents
//import HapticFeedbackSampleApp

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let name = UserDefaults(suiteName: "group.com.rakuten.HapticFeedbackSampleApp")?.object(forKey: "name") as! String

        return SimpleEntry(date: Date(), configuration: ConfigurationIntent(), name: name)
    }

    // snapshot　タイムエントリーを返す
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let name = UserDefaults(suiteName: "group.com.rakuten.HapticFeedbackSampleApp")?.object(forKey: "name") as! String
        let entry = SimpleEntry(date: Date(), configuration: configuration, name: name)
        completion(entry)
    }

    // timeline　タイムエントリーにタイムポリシーを添付する。タイムポリシーは３種類ある
    // ここでAPI呼べる　https://medium.com/kinandcartacreated/widgetkit-advanced-development-part-1-dbb0e49e849c
//    isnt a return type
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let name = UserDefaults(suiteName: "group.com.rakuten.HapticFeedbackSampleApp")?.object(forKey: "name") as! String
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, name: name)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let name: String
}

//ビューはこっちで構成する多分
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
//
//class Loader {
//    
//}
