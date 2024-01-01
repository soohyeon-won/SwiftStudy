//
//  SweeterChapter3_Frame.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 1/1/24.
//

import SwiftUI

struct SweeterChapter3_Frame: View {
    var body: some View {
        
        /// 1번과 2번의 차이를 명확히 이해해야한다.
        /// SwiftUI의 .frame은 단순히 frame을 지정하는게 아닌, 해당 뷰를 리턴하는 녀석이라는 것을 잊지말자.
        /// 1번
        Text("Frame")
            .background(Color.yellow)
            .frame(width: 50, height: 50)
        
        /// 2번
        Text("Frame")
            .frame(width: 50, height: 50)
            .background(Color.yellow)
        
        Rectangle()
            .fill(Color.yellow)
            .frame(width: 50, height: 50, alignment: .leading)
        
        /// alignment를 줄 수 있음
        HStack {
            Text("Frame")
                .frame(width: 100, height: 100, alignment: .leading)
                .background(Color.yellow)
            Text("Frame")
                .frame(width: 100, height: 100)
                .background(Color.yellow)
            Text("Frame")
                .frame(width: 100, height: 100, alignment: .trailing)
                .background(Color.yellow)
        }
        
        /// max, min
        HStack {
            Rectangle().fill(Color.red).frame(maxWidth: 100, maxHeight: 100)
            Rectangle().fill(Color.orange).frame(maxWidth: 15, maxHeight: .infinity)
            Rectangle().fill(Color.purple) // 양방향 Infinity와 동일
        }
        
        /// 이상적인 크기(Ideal Size)와 fixedSize 수식어
        /// Ideal size는 Intrinsic Content Size와 비슷한 개념
        VStack {
            Text("Frame modifier")
                .font(.title)
                .bold()
                .frame(width: 80, height: 30)
            Image("home")
                .resizable()
        }
        VStack {
            Text("Frame modifier")
                .font(.title)
                .bold()
                .fixedSize() // 글자가 생략되지 않는다.
//                .fixedSize(horizontal: false, vertical: true) // 이런식으로도 사용가능
            Image("home")
                .resizable()
                .fixedSize()
            Image("home")
                .resizable()
                .frame(idealWidth: 200)
                .fixedSize()
        }
        
        /// Layout Priority
        /// 뷰 그룹 내에서 우선권 할당시 부모 뷰의 공간이 늘어날때 형제 뷰와 비교해 더 빨리 늘어나고 줄어든다.
        /// layoutPriority의 기본값은 1
        HStack {
            Color.red.frame(width: 100)
            Color.green.frame(width: 100) // 우선순위와 상관없이 frame을 설정하면 고정크기를 가짐
            Color.blue.frame(maxWidth: 50).layoutPriority(1)
        }
        HStack {
            Color.red.layoutPriority(1)
            Color.green // 아무것도 안 설정하고 우선순위도 낮기때문에 사라짐
            Color.blue.frame(maxWidth: 50).layoutPriority(1)
        }
        HStack {
            Color.red.layoutPriority(1)
            Color.green.frame(minWidth: 50)
            Color.blue.frame(minWidth: 50).layoutPriority(1) // min을 설정했지만 blue의 우선순위가 더 높기때문에 영역이 더 커진다
        }
    }
}

#Preview {
    SweeterChapter3_Frame()
}
