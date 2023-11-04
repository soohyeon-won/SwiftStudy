//
//  SwfitUIView.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/09/16.
//

import SwiftUI

struct BaseView: View {
    var body: some View {
        VStack { //VStack => 수직 스택
            Text("Hello, world!")
            
            Image("swiftUI")
                .resizable()
                .aspectRatio(
                    CGSize(width: 1, height: 0.5),
                    contentMode: .fit
                )
                .background(.blue)
                .frame(height: 100)
            
            Image("swiftUI")
                .resizable()
                .background(.yellow)
                .clipShape(Circle())
                .aspectRatio(
                    CGSize(width: 1, height: 1),
                    contentMode: .fit
                )
                .frame(height: 100)
            
            Image(systemName: "arrow.right")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(.black) // 내부의 값으로 적용됨
            
            Text("전체보기") // zIndex -> 전체보기 텍스트는 보이지않는다.
                .overlay(
                    Rectangle().foregroundColor(.yellow)
                )
                .foregroundColor(.red)
            
            Circle()
                .fill(.red)
                .frame(width: 60, height: 60)
                .foregroundColor(.green) // fill에의해 붉은색으로 표시됩니다.
                .overlay(
                    VStack {
                        Text("첫번째라인")
                        Text("두번째라인")
                    }
                )
            
            Text("Goodbye, world!")
            Spacer()
        }
        .background(.cyan)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
