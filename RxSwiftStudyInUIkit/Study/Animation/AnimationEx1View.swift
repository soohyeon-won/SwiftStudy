//
//  AnimationEx1View.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 6/9/24.
//

import SwiftUI

struct AnimationEx1View: View {
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 20) {
            Text("애니메이션의 기본 원리")
                .font(.title)
                .fontWeight(.bold)
            
            Text("애니메이션은 시간에 따라 뷰의 속성을 변경하여 시각적인 효과를 제공하는 것입니다.")
                .multilineTextAlignment(.center)
                .padding()

            Text("iOS에서 애니메이션의 역할")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("애니메이션은 사용자가 앱과 상호 작용할 때의 경험을 향상시키며, 전환, 상태 변경, 피드백 등을 시각적으로 제공하여 앱의 사용성을 높입니다.")
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Circle()
                .fill(isAnimating ? Color.blue : Color.red)
                .frame(width: 100, height: 100)
                .scaleEffect(isAnimating ? 1.5 : 1.0)
                .animation(.easeInOut(duration: 1.0), value: isAnimating)
                .onTapGesture {
                    isAnimating.toggle()
                }

            Spacer()
            
            Text("위의 예제는 클릭할 때마다 색상과 크기가 변경되는 간단한 애니메이션입니다.")
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }
}
