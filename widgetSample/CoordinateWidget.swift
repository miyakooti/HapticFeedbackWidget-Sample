//
//  roomWidget.swift
//  roomWidget
//
//  Created by Arai, Kosuke | ECMPD on 2022/04/06.
//

import WidgetKit
import SwiftUI
import Intents
import Alamofire

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), imagesURLString: [String](), deepLinks: [String]())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), imagesURLString: [String](), deepLinks: [String]())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Loader.fetchCoordinate { coordinate in
            var entries: [SimpleEntry] = []
            let currentDate = Date()
                        
            if let coordinate = coordinate?.data {
                
                var urlsString: [String] = []
                var deepLinks: [String] = []
                for value in coordinate {
                    let deepLink = value.user.url + "/coordinate/" + value.uuid
                    urlsString.append(value.topImage.url)
                    deepLinks.append(deepLink)
                }
                for hourOffset in 0 ..< 5 {
                    let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                    let entry = SimpleEntry(date: entryDate, imagesURLString: urlsString, deepLinks: deepLinks)
                    entries.append(entry)
                }
                
            } else {
                for hourOffset in 0 ..< 5 {
                    let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                    let entry = SimpleEntry(date: entryDate, imagesURLString: [String](), deepLinks: [String]())
                    entries.append(entry)
                }
            }
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
                
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let imagesURLString: [String]
    let deepLinks: [String]
}

struct coordinateEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family: WidgetFamily

    var body: some View {
        
        switch family {
            
        case .systemSmall:
            VStack(alignment: .center, spacing: 5.0) {
//                if let imageUrl = entry.imagesURLString.first {
//                    NetworkImage(withURL: imageUrl, size: CGSize(width: 150, height: 120))
//                        .cornerRadius(15)
//                }
                Image("test")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 170)
                    .cornerRadius(15)
            }.widgetURL(URL(string: entry.deepLinks.first ?? ""))

            
        case .systemMedium:
//            VStack(alignment: .center, spacing: 10.0) {
//                Text(entry.date, style: .time)
//                if let imageUrl =  entry.imagesURLString.first {
//                    NetworkImage(withURL: imageUrl, size: CGSize(width: 100, height: 100))
//                }
//                if let url = URL(string: "https://room.rakuten.co.jp/room_553edc611c/coordinate/77258da7-a5bd-4562-aa0f-26c2c21471de") {
//                    Link("link 1", destination: url)
//                }
//            }
            VStack(alignment: .center, spacing: 5.0) {
                View() {
                    
                }
            }

        case .systemLarge:
            VStack(alignment: .center, spacing: 10.0) {
                Text(entry.date, style: .time)
                if let imageUrl =  entry.imagesURLString.first {
                    NetworkImage(withURL: imageUrl, size: CGSize(width: 100, height: 100))
                }
                Text("コーディネート")
            }.widgetURL(URL(string: "https://room.rakuten.co.jp/room_553edc611c/coordinate/77258da7-a5bd-4562-aa0f-26c2c21471de"))

        case .systemExtraLarge:
            VStack(alignment: .center, spacing: 10.0) {
                Text(entry.date, style: .time)
                if let imageUrl =  entry.imagesURLString.first {
                    NetworkImage(withURL: imageUrl, size: CGSize(width: 100, height: 100))
                }
                Text("コーディネート")
            }.widgetURL(URL(string: "https://room.rakuten.co.jp/room_553edc611c/coordinate/77258da7-a5bd-4562-aa0f-26c2c21471de"))

        }

    }
    
}

struct CoordinateWidget: Widget {
    
    let kind: String = "coordinateWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            coordinateEntryView(entry: entry)
        }
        .configurationDisplayName("コーディネート")
        .description("コーディネートの最新投稿が表示されます")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
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
    
    static var previews: some View {
//        coordinateEntryView(entry: SimpleEntry(date: Date(), imagesURLString: [String](), deepLinks: [String]()))
//            .preferredColorScheme(.light)
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
        Group {
            coordinateEntryView(entry: SimpleEntry(date: Date(), imagesURLString: [String](), deepLinks: [String]()))
                .padding()
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            coordinateEntryView(entry: SimpleEntry(date: Date(), imagesURLString: [String](), deepLinks: [String]()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            coordinateEntryView(entry: SimpleEntry(date: Date(), imagesURLString: [String](), deepLinks: [String]()))
                .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
        }
    }
}


