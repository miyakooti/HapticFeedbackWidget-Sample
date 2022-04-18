//
//  NetworkImage.swift
//  ROOM
//
//  Created by Arai, Kosuke | ECMPD on 2022/04/06.
//

import Foundation
import SwiftUI

struct NetworkImage: View {

    private let url: URL?
    private var size = CGSize(width: 50, height: 50)

    init(withURL url:String) {
        self.url = URL(string: url)
    }
    
    init(withURL url:String, size:CGSize) {
        self.url = URL(string: url)
        self.size = size
    }

    var body: some View {
        Group {
            if let url = url, let imageData = try? Data(contentsOf: url),
                let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage).resizable().scaledToFill().frame(width: size.width, height: size.height, alignment: .center).clipShape(ContainerRelativeShape())
            } else {
                Image("noimage").resizable().scaledToFill().frame(width: size.width, height: size.height, alignment: .center).clipShape(ContainerRelativeShape())
            }
        }
    }
}
