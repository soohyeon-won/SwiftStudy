//
//  SweeterChapter3.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 12/27/23.
//

import SwiftUI

struct SweeterChapter3_Navigation: View {
    
    var body: some View {
        NavigationView {
            /// Compact
            mainCompactView
            
            /// Regural
            SweeterChapter2()
        }
        .navigationViewStyle(.stack)
        
        /// .stack을 권장한다고 함
        /// 새롭게 NavigationStack이 생겼음. // 회사 플젝은 iOS 14이상 지원이므로 나는 NavigationView먼저 공부하도록 하겠다
        /// 가로모드 > 세로모드 변경하면 세로모드에서 NavigationLink가 동작되지 않는 이슈가있음
//        .navigationViewStyle(.columns)
    }
    
    private var mainCompactView: some View {
        get {
            VStack { // some View 하나를 리턴하는 형식으로 NavigationView 내부에 제작하면됨
                Text("확인")
                    .padding([.leading, .trailing], 16)
                    .padding([.top, .bottom], 8)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1))
                
                Text("확인")
                    .padding([.leading, .trailing], 16)
                    .padding([.top, .bottom], 8)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1))
                
                
                NavigationLink(destination: SweeterChapter2()) { // PushViewController와 같은 기능
                    
                    VStack {
                        Text("마스터뷰 메뉴 1")
                            .padding([.leading, .trailing], 16)
                            .padding([.top, .bottom], 8)
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1))
                    }
                }
                
                NavigationLink(destination: SwiftUI_Image()) { // PushViewController와 같은 기능
                    
                    VStack {
                        Text("마스터뷰 메뉴 2")
                            .padding([.leading, .trailing], 16)
                            .padding([.top, .bottom], 8)
                            .background(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1))
                    }
                }
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SweeterChapter3_Navigation()
}
