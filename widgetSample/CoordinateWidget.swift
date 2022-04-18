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

struct coordinateEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family: WidgetFamily

    var body: some View {
        
        switch family {
            
        case .systemSmall:
            VStack(alignment: .center, spacing: 5.0) {
                if entry.imagesURLString.count != 0 {
                    NetworkImage(withURL: entry.imagesURLString[0], size: CGSize(width: 170, height: 170))
                        .cornerRadius(15)
                } else {
                    NetworkImage(withURL: "https://room.r10s.jp/d/strg/ctrl/22/c0b9856a62d9ec65c6d3ed9d7a891100e76e8fe2.79.9.22.3.jpg", size: CGSize(width: 170, height: 170))
                        .cornerRadius(15)
                }
            }.widgetURL(URL(string: entry.deepLinks.first ?? ""))

        case .systemMedium:

            VStack(alignment: .center, spacing: 0) {
                Spacer()

                HStack(alignment: .center, spacing: 15) {
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 24)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("新着コーディネート")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                    Spacer()

                }

                Spacer()

                HStack(alignment: .center, spacing: 5) {
                    Spacer()
                    

                    VStack(alignment: .center, spacing: 0) {
                        Spacer()
                        if entry.imagesURLString.count != 0 {
                            Link(destination: URL(string: entry.deepLinks[1])!) {
                                NetworkImage(withURL: entry.imagesURLString[1], size: CGSize(width: 80, height: 100))
                                    .cornerRadius(10)
                                    .scaledToFill()
                            }
                        } else {
                            Image("test")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 90)
                                .cornerRadius(10)
                        }
                    }
                    

                    VStack(alignment: .center, spacing: 0) {
                        if entry.imagesURLString.count != 0 {
                            Link(destination: URL(string: entry.deepLinks[2])!) {
                                NetworkImage(withURL: entry.imagesURLString[2], size: CGSize(width: 80, height: 100))
                                    .cornerRadius(10)
                                    .scaledToFill()
                            }
                        } else {
                            Image("test2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 90)
                                .cornerRadius(10)
                        }
                        Spacer()

                    }
                    
                    
                    VStack(alignment: .center, spacing: 0) {
                        Spacer()
                        if entry.imagesURLString.count != 0 {
                            Link(destination: URL(string: entry.deepLinks[3])!) {
                                NetworkImage(withURL: entry.imagesURLString[3], size: CGSize(width: 80, height: 100))
                                    .cornerRadius(10)
                                    .scaledToFill()
                            }
                        } else {
                            Image("test3")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 90)
                                .cornerRadius(10)
                        }
                    }
                    

                    VStack(alignment: .center, spacing: 0) {
                        if entry.imagesURLString.count != 0 {
                            Link(destination: URL(string: entry.deepLinks[4])!) {
                                NetworkImage(withURL: entry.imagesURLString[4], size: CGSize(width: 80, height: 100))
                                    .cornerRadius(10)
                                    .scaledToFill()
                            }
                        } else {
                            Image("test4")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 90)
                                .cornerRadius(10)
                        }
                        Spacer()

                    }

                    Spacer()
                }
                Spacer()

            }


        case .systemLarge:
            Spacer()
            VStack(alignment: .center, spacing: 5) {
                Spacer()
                Link(destination: URL(string: entry.deepLinks.count != 0 ? entry.deepLinks[10] : "https://room.rakuten.co.jp")!) {
                    HStack(alignment: .center, spacing: 5) {

                        Spacer()

                        if entry.imagesURLString.count != 0 {
                            NetworkImage(withURL: entry.imagesURLString[10], size: CGSize(width: 113, height: 150))
                                .scaledToFill()
                                .cornerRadius(10)
                        } else {
                            Image("test")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 113, height: 150)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Spacer()

                            HStack(alignment: .center, spacing: 3) {
                                if entry.imagesURLString.count != 0 {
                                    NetworkImage(withURL: entry.avatarImage[10], size: CGSize(width: 30, height: 30))
                                        .cornerRadius(15)
                                    Text(verbatim: entry.fullName[10])
                                        .font(.caption)
                                        .fontWeight(.light)
                                } else {
                                    Image("test2")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(15)
                                    Text("ユーザーネームが入ります")
                                        .font(.caption)
                                        .fontWeight(.light)
                                }
                                
                                
                            }

                            HStack(alignment: .center, spacing: 3) {
                                Image("heart")
                                    .resizable()
                                    .frame(width: 11, height: 11)
                                if entry.cntLike.count != 0 {
                                    Text(verbatim: String(entry.cntLike[10]))
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                } else {
                                    Text("0")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                    
                                }


                            }

                            if entry.content.count != 0 {
                                Text(verbatim: entry.content[10])
                                    .font(.caption)
                                    .fontWeight(.regular)
                            } else {
                                Text("コーディネートの説明が入力されます")
                                    .font(.caption)
                                    .fontWeight(.regular)
                            }
                            
                            Spacer()

                        }
                        Spacer()
                    }

                }

                Divider()
                
                Link(destination: URL(string: entry.deepLinks.count != 0 ? entry.deepLinks[11] : "https://room.rakuten.co.jp")!) {
                    HStack(alignment: .center, spacing: 5) {
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Spacer()

                            HStack(alignment: .center, spacing: 3) {
                                if entry.imagesURLString.count != 0 {
                                    NetworkImage(withURL: entry.avatarImage[11], size: CGSize(width: 30, height: 30))
                                        .cornerRadius(15)
                                    Text(verbatim: entry.fullName[11])
                                        .font(.caption)
                                        .fontWeight(.light)
                                } else {
                                    Image("test2")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .cornerRadius(15)
                                    Text("ユーザーネームが入ります")
                                        .font(.caption)
                                        .fontWeight(.light)
                                }
                                
                                
                            }

                            HStack(alignment: .center, spacing: 3) {
                                Image("heart")
                                    .resizable()
                                    .frame(width: 11, height: 11)
                                if entry.cntLike.count != 0 {
                                    Text(verbatim: String(entry.cntLike[11]))
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                } else {
                                    Text("0")
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                    
                                }


                            }

                            if entry.content.count != 0 {
                                Text(verbatim: entry.content[11])
                                    .font(.caption)
                                    .fontWeight(.regular)
                            } else {
                                Text("コーディネートの説明が入力されます")
                                    .font(.caption)
                                    .fontWeight(.regular)
                            }
                            
                            Spacer()

                        }
                        
                        Spacer()

                        if entry.imagesURLString.count != 0 {
                            NetworkImage(withURL: entry.imagesURLString[11], size: CGSize(width: 113, height: 150))
                                .scaledToFill()
                                .cornerRadius(10)
                        } else {
                            Image("test")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 113, height: 150)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                    }
                }

                Spacer()
            }
            Spacer()

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

struct coordinateDetailEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        
        Spacer()
        Spacer()

    }
    
}

struct coordinatesListEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family: WidgetFamily

    var body: some View {
        
            Spacer()
        VStack(alignment: .leading, spacing: 10) {
            Spacer()
            HStack(alignment: .center, spacing: 3) {
                if entry.imagesURLString.count != 0 {
                    NetworkImage(withURL: entry.imagesURLString[19], size: CGSize(width: 80, height: 80))
                        .scaledToFill()
                        .cornerRadius(10)
                } else {
                    Image("test")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .cornerRadius(10)
                }
                Spacer()
                Text("あああさああああああああああああああああああああああああああああああああああああああああああ")
                    .lineLimit(3)
                Spacer()
            }
            
            Divider()
            
            HStack(alignment: .center, spacing: 3) {
                if entry.imagesURLString.count != 0 {
                    NetworkImage(withURL: entry.imagesURLString[19], size: CGSize(width: 60, height: 60))
                        .scaledToFill()
                        .cornerRadius(10)
                } else {
                    Image("test")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .cornerRadius(10)
                }
                Spacer()
                Text("あああさああああああああああああああああああああああああああああああああああああああああああ")
                Spacer()
            }
            
            Divider()

            
            HStack(alignment: .center, spacing: 3) {
                if entry.imagesURLString.count != 0 {
                    NetworkImage(withURL: entry.imagesURLString[19], size: CGSize(width: 60, height: 60))
                        .scaledToFill()
                        .cornerRadius(10)
                } else {
                    Image("test")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .cornerRadius(10)
                }
                Spacer()
                Text("あああさああああああああああああああああああああああああああああああああああああああああああ")
                    .lineLimit(3)
                Spacer()
            }
            
            Divider()

            
            HStack(alignment: .center, spacing: 3) {
                if entry.imagesURLString.count != 0 {
                    NetworkImage(withURL: entry.imagesURLString[19], size: CGSize(width: 60, height: 60))
                        .scaledToFill()
                        .cornerRadius(10)
                } else {
                    Image("test")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .cornerRadius(10)
                }
                Spacer()
                Text("あああさああああああああああああああああああああああああああああああああああああああああああ")
                    .lineLimit(3)
                Spacer()
            }
            Spacer()
        }.padding()
        
        Spacer()


//        Spacer()
//        VStack(alignment: .center, spacing: 5) {
//            Spacer()
//            Link(destination: URL(string: entry.deepLinks.count != 0 ? entry.deepLinks[10] : "https://room.rakuten.co.jp")!) {
//                HStack(alignment: .center, spacing: 5) {
//
//                    Spacer()
//
//                    if entry.imagesURLString.count != 0 {
//                        NetworkImage(withURL: entry.imagesURLString[10], size: CGSize(width: 113, height: 150))
//                            .scaledToFill()
//                            .cornerRadius(10)
//                    } else {
//                        Image("test")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 113, height: 150)
//                            .cornerRadius(10)
//                    }
//
//                    Spacer()
//
//                    VStack(alignment: .leading, spacing: 5) {
//                        Spacer()
//
//                        HStack(alignment: .center, spacing: 3) {
//                            if entry.imagesURLString.count != 0 {
//                                NetworkImage(withURL: entry.avatarImage[10], size: CGSize(width: 30, height: 30))
//                                    .cornerRadius(15)
//                                Text(verbatim: entry.fullName[10])
//                                    .font(.caption)
//                                    .fontWeight(.light)
//                            } else {
//                                Image("test2")
//                                    .resizable()
//                                    .frame(width: 30, height: 30)
//                                    .cornerRadius(15)
//                                Text("ユーザーネームが入ります")
//                                    .font(.caption)
//                                    .fontWeight(.light)
//                            }
//
//
//                        }
//
//                        HStack(alignment: .center, spacing: 3) {
//                            Image("heart")
//                                .resizable()
//                                .frame(width: 11, height: 11)
//                            if entry.cntLike.count != 0 {
//                                Text(verbatim: String(entry.cntLike[10]))
//                                    .font(.subheadline)
//                                    .fontWeight(.light)
//                            } else {
//                                Text("0")
//                                    .font(.subheadline)
//                                    .fontWeight(.light)
//
//                            }
//
//
//                        }
//
//                        if entry.content.count != 0 {
//                            Text(verbatim: entry.content[10])
//                                .font(.caption)
//                                .fontWeight(.regular)
//                        } else {
//                            Text("コーディネートの説明が入力されます")
//                                .font(.caption)
//                                .fontWeight(.regular)
//                        }
//
//                        Spacer()
//
//                    }
//                    Spacer()
//                }
//
//            }
//
//            Divider()
//
//            Link(destination: URL(string: entry.deepLinks.count != 0 ? entry.deepLinks[11] : "https://room.rakuten.co.jp")!) {
//                HStack(alignment: .center, spacing: 5) {
//
//                    Spacer()
//
//                    VStack(alignment: .leading, spacing: 5) {
//                        Spacer()
//
//                        HStack(alignment: .center, spacing: 3) {
//                            if entry.imagesURLString.count != 0 {
//                                NetworkImage(withURL: entry.avatarImage[11], size: CGSize(width: 30, height: 30))
//                                    .cornerRadius(15)
//                                Text(verbatim: entry.fullName[11])
//                                    .font(.caption)
//                                    .fontWeight(.light)
//                            } else {
//                                Image("test2")
//                                    .resizable()
//                                    .frame(width: 30, height: 30)
//                                    .cornerRadius(15)
//                                Text("ユーザーネームが入ります")
//                                    .font(.caption)
//                                    .fontWeight(.light)
//                            }
//
//
//                        }
//
//                        HStack(alignment: .center, spacing: 3) {
//                            Image("heart")
//                                .resizable()
//                                .frame(width: 11, height: 11)
//                            if entry.cntLike.count != 0 {
//                                Text(verbatim: String(entry.cntLike[11]))
//                                    .font(.subheadline)
//                                    .fontWeight(.light)
//                            } else {
//                                Text("0")
//                                    .font(.subheadline)
//                                    .fontWeight(.light)
//
//                            }
//
//
//                        }
//
//                        if entry.content.count != 0 {
//                            Text(verbatim: entry.content[11])
//                                .font(.caption)
//                                .fontWeight(.regular)
//                        } else {
//                            Text("コーディネートの説明が入力されます")
//                                .font(.caption)
//                                .fontWeight(.regular)
//                        }
//
//                        Spacer()
//
//                    }
//
//                    Spacer()
//
//                    if entry.imagesURLString.count != 0 {
//                        NetworkImage(withURL: entry.imagesURLString[11], size: CGSize(width: 113, height: 150))
//                            .scaledToFill()
//                            .cornerRadius(10)
//                    } else {
//                        Image("test")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 113, height: 150)
//                            .cornerRadius(10)
//                    }
//
//                    Spacer()
//                }
//            }
//
//            Spacer()
//        }
//        Spacer()



    }
    
}


struct CoordinateWidget: Widget {
    
    let kind: String = "coordinateWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            coordinateEntryView(entry: entry)
        }
        .configurationDisplayName("コーディネート")
        .description("新着のコーディネートが表示されます")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct CoordinateDetailWidget: Widget {
    
    let kind: String = "coordinateDetailWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            coordinateDetailEntryView(entry: entry)
        }
        .configurationDisplayName("コーディネート")
        .description("コーディネートの詳細が表示されます")
        .supportedFamilies([.systemLarge])
    }
}

struct CoordinatesListWidget: Widget {
    
    let kind: String = "coordinatesListWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            coordinatesListEntryView(entry: entry)
        }
        .configurationDisplayName("コーディネート")
        .description("コーディネートの詳細が表示されます")
        .supportedFamilies([.systemLarge])
    }
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
    
    var imageURL = "https://room.rakuten.co.jp/room_553edc611c/coordinate/77258da7-a5bd-4562-aa0f-26c2c21471de"
    
    static var previews: some View {
//        coordinateEntryView(entry: SimpleEntry(date: Date(), imagesURLString: [String](), deepLinks: [String]()))
//            .preferredColorScheme(.light)
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
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


