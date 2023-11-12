//
//  SwfitUIGenerateView.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/09/16.
//

import SwiftUI

struct SwiftUI_Text: View {
    var body: some View {
        SafeArea {
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
                Spacer()
                
                Text("SwiftUI")
                    .font(.title) // Text 반환
                    .bold() // Text
                    .padding() // View 반환 위에있는 수식어와 순서를 바꾸면 컴파일 에러
                
                Text("background 우선적용")
                    .font(.largeTitle)
                    .background(.yellow)
                    .padding()
                
                Text("padding 우선적용")
                    .font(.largeTitle)
                    .padding()
                    .background(.yellow)
                
                Spacer()
            }
        }
    }
}

struct SwfitUIGenerateView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Text()
    }
}
