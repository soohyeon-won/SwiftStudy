//
//  SwfitUIView.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/09/16.
//

import SwiftUI

struct SwuftStydyView: View {
    var body: some View {
        VStack {
            Text("📚 Swift Study")
        }.onAppear {
            Person().test()
        }
    }
}
