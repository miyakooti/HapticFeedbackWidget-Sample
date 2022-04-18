//
//  roomWidget.swift
//  roomWidget
//
//  Created by Arai, Kosuke | ECMPD on 2022/04/06.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), imagesURLString: [], deepLinks: [String](), content: [String](), avatarImage: [String](), cntLike: [Int](), fullName: [String](), coordinateDetail: CoordinateDetailResponse())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), imagesURLString: [], deepLinks: [String](), content: [String](), avatarImage: [String](), cntLike: [Int](), fullName: [String](), coordinateDetail: CoordinateDetailResponse())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Loader.fetchCoordinate { coordinate in
            
            Loader.fetchCoordinateDetail(uuid: coordinate?.data?[18].uuid ?? "") { coordinateDetail in
                var entries: [SimpleEntry] = []
                let currentDate = Date()
                            
                if let coordinate = coordinate?.data {
                    
                    var urlsString: [String] = []
                    var deepLinks: [String] = []
                    var content: [String] = []
                    var avatarImage: [String] = []
                    var cntLike: [Int] = []
                    var fullname: [String] = []
                    for value in coordinate {
                        let deepLink = value.user.url + "/coordinate/" + value.uuid
                        urlsString.append(value.topImage.url)
                        deepLinks.append(deepLink)
                        content.append(value.content)
                        avatarImage.append(value.user.profile.imageAvatar.url)
                        fullname.append(value.user.fullname)
                        cntLike.append(value.cntLike)
                    }
                    
                    for hourOffset in 0 ..< 5 {
                        let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                        let entry = SimpleEntry(date: entryDate, imagesURLString: urlsString, deepLinks: deepLinks, content: content, avatarImage: avatarImage, cntLike: cntLike, fullName: fullname, coordinateDetail: coordinateDetail ?? CoordinateDetailResponse())
                        entries.append(entry)
                    }
                    
                } else {
                    for hourOffset in 0 ..< 5 {
                        let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                        let entry = SimpleEntry(date: entryDate, imagesURLString: [], deepLinks: [String](), content: [String](), avatarImage: [String](), cntLike: [Int](), fullName: [String](), coordinateDetail: CoordinateDetailResponse())
                        entries.append(entry)
                    }
                }
                // update timeline per 60 minutes
                let refresh = Calendar.current.date(byAdding: .minute, value: 60, to: Date()) ?? Date()
                let timeline = Timeline(entries: entries, policy: .after(refresh))
                completion(timeline)
            }
            

        }
                
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let imagesURLString: [String]
    let deepLinks: [String]
    let content: [String]
    let avatarImage: [String]
    let cntLike: [Int]
    let fullName: [String]
    let coordinateDetail: CoordinateDetailResponse
}

@main
struct ExampleWidgets: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        CoordinateWidget()
        CoordinateDetailWidget()
//        CoordinatesListWidget()
    }
}

struct widgetSample_Previews: PreviewProvider {
        
    static var previews: some View {
        Group {
            coordinateEntryView(entry: SimpleEntry(date: Date(), imagesURLString: [], deepLinks: [String](), content: [String](), avatarImage: [String](), cntLike: [Int](), fullName: [String](), coordinateDetail: CoordinateDetailResponse()))
                .padding()
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            coordinateEntryView(entry: SimpleEntry(date: Date(), imagesURLString: [], deepLinks: [String](), content: [String](), avatarImage: [String](), cntLike: [Int](), fullName: [String](), coordinateDetail: CoordinateDetailResponse()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            coordinateEntryView(entry: SimpleEntry(date: Date(), imagesURLString: [], deepLinks: [String](), content: [String](), avatarImage: [String](), cntLike: [Int](), fullName: [String](), coordinateDetail: CoordinateDetailResponse()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
            
            coordinateDetailEntryView(entry: SimpleEntry(date: Date(), imagesURLString: [], deepLinks: [String](), content: [String](), avatarImage: [String](), cntLike: [Int](), fullName: [String](), coordinateDetail: CoordinateDetailResponse()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}


