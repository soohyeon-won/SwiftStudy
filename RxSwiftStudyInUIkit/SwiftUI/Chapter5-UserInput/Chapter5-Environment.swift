//
//  Chapter5-Environment.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 1/6/24.
//

import SwiftUI

struct Chapter5_EnvironmentSuperview: View {
    var body: some View {
        Chapter5_EnvironmentSubview()
    }
}

struct Chapter5_EnvironmentSubview: View {
    
    @EnvironmentObject var user: User
    
    class User: ObservableObject {
        /// Published 로 선언해주어야 버튼 선택시 Text가 변경됨
        @Published var name: String = "name"
        
        init(name: String) {
            self.name = name
        }
    }
    
    var body: some View {
        Text(user.name.description)
        
        Button(action: {
            user.name = "change~"
        }, label: {
            Text("Button")
        })
    }
}

struct Chapter5_Environment: View {
    var body: some View {
        /// ObservableObject를 준수하는 타입을 전달
        /// Superview의 모든 자식뷰는 User인스턴스에 접근가능
        Chapter5_EnvironmentSuperview()
            .environmentObject(
                Chapter5_EnvironmentSubview.User(
                    name: "environmentName"
                )
            )
    }
}

//#Preview {
//    Chapter5_environment()
//}
