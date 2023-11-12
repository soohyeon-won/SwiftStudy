//
//  SwiftUI-Stack.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 11/12/23.
//

import SwiftUI

struct SwiftUI_Stack: View {
    var body: some View {
        VStack {
            Text("HStack")
            HStack(alignment: .top, spacing: 16) {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 100, height: 100)
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: 100, height: 150)
            }
            
            HStack {
                Text("HStack은 뷰를").foregroundColor(.red)
                Text("가로로 배열합니다")
            }
            .padding() // 여백을 확보하고
            .border(Color.black) // 검은색 테두리 그리기
            
            HStack {
                Text("HStack에 font 일괄로 적용이 가능!")
                Text("하지만 내부에서 적용된 수식어를 우선으로 합니다").font(.title).foregroundColor(.red)
            }
            .font(.largeTitle)
            
            HStack {
                Spacer()
                Text("Spacer최대확장").font(.title).background(.blue)
            }
            .background(.green)
            HStack {
                Spacer().frame(width: 100)
                Text("Spacer frame 100").font(.title).background(.blue)
            }
            .background(.green)
            HStack {
                Text("Spacer minLength 100").font(.title).background(.blue)
                Spacer(minLength: 100)
                Text("Spacer").font(.title).background(.blue)
            }
            .background(.green)
            HStack {
                Text("Spacer minLength 100").font(.title).background(.blue)
                Spacer()
                Text("Spacer").font(.title).background(.blue)
            }
            .background(.green)
            
            Spacer()
            
            Text("ZStack")
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 150, height: 150)
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: 150, height: 150)
                    .offset(x: 40, y: 40)
                
            }
        }
    }
}

#Preview {
    SwiftUI_Stack()
}
