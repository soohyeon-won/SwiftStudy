//
//  Chapter2-2.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 11/26/23.
//

import SwiftUI

struct SweeterChapter2: View {
    
    var productImage: some View {
        Image("apple")
            .resizable()
            .scaledToFill()
            .frame(width: 140, height: 100)
            .clipped()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ExtractedView() // cmd+left click => extract Subview
            productImage
        }
//        .navigationTitle("title") // ""안에 어떤내용이든 hidden처리됨
//        .navigationBarHidden(true)
    }
}

struct SweeterChapter2_Previews: PreviewProvider {
    static var previews: some View {
        SweeterChapter2()
    }
}

struct ExtractedView: View {
    var body: some View {
        HStack {
            Image("apple")
                .resizable()
                .scaledToFill()
                .frame(width: 140)
                .clipped()
        }
    }
}
