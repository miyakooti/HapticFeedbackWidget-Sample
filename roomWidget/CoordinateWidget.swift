//
//  CoordinateWidget.swift
//  ROOM
//
//  Created by Arai, Kosuke | ECMPD on 2022/04/18.
//

import WidgetKit
import SwiftUI

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
                
                let itemSize = CGSize(width: 80, height: 100)
                HStack(alignment: .center, spacing: 5) {
                    Spacer()
                    VStack(alignment: .center, spacing: 0) {
                        Spacer()
                        if entry.imagesURLString.count != 0 {
                            Link(destination: URL(string: entry.deepLinks[1])!) {
                                NetworkImage(withURL: entry.imagesURLString[1], size: itemSize)
                                    .cornerRadius(10)
                                    .scaledToFill()
                            }
                        } else {
                            Image("test")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 100)
                                .cornerRadius(10)
                        }
                    }
                    
                    VStack(alignment: .center, spacing: 0) {
                        if entry.imagesURLString.count != 0 {
                            Link(destination: URL(string: entry.deepLinks[2])!) {
                                NetworkImage(withURL: entry.imagesURLString[2], size: itemSize)
                                    .cornerRadius(10)
                                    .scaledToFill()
                            }
                        } else {
                            Image("test2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 100)
                                .cornerRadius(10)
                        }
                        Spacer()

                    }
                    
                    
                    VStack(alignment: .center, spacing: 0) {
                        Spacer()
                        if entry.imagesURLString.count != 0 {
                            Link(destination: URL(string: entry.deepLinks[3])!) {
                                NetworkImage(withURL: entry.imagesURLString[3], size: itemSize)
                                    .cornerRadius(10)
                                    .scaledToFill()
                            }
                        } else {
                            Image("test3")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 100)
                                .cornerRadius(10)
                        }
                    }
                    

                    VStack(alignment: .center, spacing: 0) {
                        if entry.imagesURLString.count != 0 {
                            Link(destination: URL(string: entry.deepLinks[4])!) {
                                NetworkImage(withURL: entry.imagesURLString[4], size: itemSize)
                                    .cornerRadius(10)
                                    .scaledToFill()
                            }
                        } else {
                            Image("test4")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 100)
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
                                    .font(.caption2)
                                    .fontWeight(.regular)
                                    .frame(height: 75.0)
                                    .fixedSize(horizontal: false, vertical: true)
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
            Text(".systemExtraLargeは未対応です。")
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
        .description("新着のコーディネートが表示されます")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
