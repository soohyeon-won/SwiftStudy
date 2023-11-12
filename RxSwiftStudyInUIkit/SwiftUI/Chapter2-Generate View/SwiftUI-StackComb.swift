//
//  SwiftUI-StackComb.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 11/12/23.
//

import SwiftUI

struct SwiftUI_StackComb: View {
    var body: some View {
        VStack {
            Text("도형만들기").font(.largeTitle).fontWeight(.heavy)
            Text("둥근 모양").font(.title)
            ZStack {
                Rectangle().frame(height: 10)
                
                HStack {
                    Circle().fill(.yellow) // 원
                    Ellipse().fill(.green) // 타원
                    Capsule().fill(.orange) // 캡슐
                    RoundedRectangle(cornerRadius: 30).fill(.gray) // 둥근 모서리 사각형
                }
            }
            Text("각진 모양").font(.title)
            ZStack {
                Rectangle().frame(height: 10)
                
                HStack {
                    Color.red // SwiftUI에서는 컬러 그 자체도 하나의 뷰에 해당합니다.
                    Rectangle().fill(.blue)
                    RoundedRectangle(cornerRadius: 0).fill(.purple)
                }
            }
            HStack {
                /// 원본의 공간을 기준으로 새로운 뷰를 중첩하여 쌓는 기능을 하는 수식어
                VStack { 
                    Text("Oberlay").font(.title)
                    Rectangle().fill(.orange).frame(width: 150, height: 150)
                        .overlay(
                            Rectangle().fill(.yellow)
                        )
                }
                /// 원본의 공간을 기준으로 새로운 뷰를 중첩
                /// overlay와 반대로 아래 방향으로 쌓아 나간다
                VStack {
                    Text("Background").font(.title)
                    Rectangle().fill(.orange).frame(width: 150, height: 150)
                        .background(
                            Rectangle().fill(.yellow)
                        )
                }
            }
        }
    }
}

#Preview {
    SwiftUI_StackComb()
}
