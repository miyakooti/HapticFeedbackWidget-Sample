//
//  CoordinateDetailWidget.swift
//  ROOM
//
//  Created by Arai, Kosuke | ECMPD on 2022/04/18.
//

import WidgetKit
import SwiftUI

struct coordinateDetailEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        
        let scale = 90.0
        let itemSize = CGSize(width: scale, height: scale)
        let index = 18
        
        Spacer()
        VStack(alignment: .center, spacing: 5) {
            Spacer()
            Link(destination: URL(string: entry.deepLinks.count != 0 ? entry.deepLinks[index] : "https://room.rakuten.co.jp")!) {
                HStack(alignment: .center, spacing: 5) {

                    Spacer()

                    if entry.imagesURLString.count != 0 {
                        NetworkImage(withURL: entry.imagesURLString[index], size: CGSize(width: 118, height: 160))
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
                                
                                NetworkImage(withURL: entry.avatarImage[index], size: CGSize(width: 30, height: 30))
                                    .cornerRadius(15)
                                Text(verbatim: entry.fullName[index])
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
                                .frame(width: 13, height: 13)
                            if entry.cntLike.count != 0 {
                                Text(verbatim: String(entry.cntLike[index]))
                                    .font(.subheadline)
                                    .fontWeight(.light)
                            } else {
                                Text("0")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                
                            }


                        }

                        if entry.content.count != 0 {
                            Text(verbatim: entry.content[index])
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
            
            VStack(alignment: .center, spacing: 3) {
                Spacer()
                HStack(alignment: .center, spacing: 3) {
                    Text("着用商品")
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 30.0)
                    Spacer()

                }
                
                Spacer()
                HStack(alignment: .center, spacing: 3) {
                    Spacer()

                    if entry.coordinateDetail.data?.coordinateItem?.count ?? 0 >= 1 {
                        NetworkImage(withURL: entry.coordinateDetail.data?.coordinateItem![0].image?[0].url ?? "", size: itemSize)
                            .cornerRadius(10)
                        Spacer()
                    } else {
                        Image("test3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: scale, height: scale)
                            .cornerRadius(10)
                    }

                    Spacer()

                    if entry.coordinateDetail.data?.coordinateItem?.count ?? 0 >= 2 {
                        NetworkImage(withURL: entry.coordinateDetail.data?.coordinateItem![1].image?[0].url ?? "", size: itemSize)
                            .cornerRadius(10)
                        Spacer()
                    }


                    if entry.coordinateDetail.data?.coordinateItem?.count ?? 0 >= 3 {
                        NetworkImage(withURL: entry.coordinateDetail.data?.coordinateItem![2].image?[0].url ?? "", size: itemSize)
                            .cornerRadius(10)
                        Spacer()

                    }
                    
                }
                Spacer()
            }
            

            Spacer()
        }
        Spacer()
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
