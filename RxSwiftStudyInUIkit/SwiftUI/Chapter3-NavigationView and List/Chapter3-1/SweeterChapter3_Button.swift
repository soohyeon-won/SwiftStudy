//
//  SweeterChapter3.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 12/27/23.
//

import SwiftUI

struct SweeterChapter3_Button: View {
    
    private func extractedFunc() -> some View {
        return HStack {
            Button {
                print("확인")
            } label: {
                Text("확인")
                    .padding([.leading, .trailing], 16)
                    .padding([.top, .bottom], 8)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1))
                
            }
            Button {
                print("취소")
            } label: {
                Text("취소")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1))
                
            }
            Button (action: {
                print("Image+Circle")
            }) {
                Circle()
                    .stroke(lineWidth: 1)
                //                    .fill(.red) // 순서에 따라 달라짐
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image("apple")
                            .resizable()
                            .clipShape(Circle())
                    )
            }
            Button (action: {
                print("systemImage")
            }) {
                Image(systemName: "play.circle")
                    .imageScale(.large)
                    .font(.largeTitle)
            }
            Button (action: {
                print("Image+Frame")
            }) {
                Image("swiftUI")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 80, height: 80)
            }
        }
    }
    
    var body: some View {
        Text("[버튼UI]")
        extractedFunc()
        
        Text("View를 버튼으로 이용하기 - 하이라이트 애니메이션, 커스텀 버튼 스타일 사용 못함")
        Image(systemName: "play.circle")
            .imageScale(.large)
            .font(.largeTitle)
            .onTapGesture {
                print("onTapGesture")
            }
    }
}

#Preview {
    SweeterChapter3_Button()
}
