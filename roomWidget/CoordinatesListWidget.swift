//
//  CoordinatesListWidget.swift
//  ROOM
//
//  Created by Arai, Kosuke | ECMPD on 2022/04/18.
//

import WidgetKit
import SwiftUI

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

struct CoordinatesListWidget: Widget {
    
    let kind: String = "coordinatesListWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            coordinatesListEntryView(entry: entry)
        }
        .configurationDisplayName("コーディネート")
        .description("コーディネートのリストが表示されます")
        .supportedFamilies([.systemLarge])
    }
}
