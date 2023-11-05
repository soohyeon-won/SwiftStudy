//
//  SwfitUIGenerateView.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/09/16.
//

import SwiftUI

struct SwfitUIGenerateView: View {
    var body: some View {
        VStack {
            Text("텍스트를\n알아보자\n이건 안보입니다.")
                .font(.title)
                .bold()
                .fontWeight(.black)
                .kerning(-0.5)
                .lineLimit(2)
                .foregroundColor(.black)
                .padding()
                .background(Color.blue)
                .multilineTextAlignment(.trailing)
                .fixedSize() // 주어진 공간의 크기가 작아도 텍스트를 생략하지 않고 표현되도록 설정
        }
    }
}

struct SwfitUIGenerateView_Previews: PreviewProvider {
    static var previews: some View {
        SwfitUIGenerateView()
    }
}
