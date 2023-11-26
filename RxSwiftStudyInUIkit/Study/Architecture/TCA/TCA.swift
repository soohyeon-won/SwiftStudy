//
//  TCA.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/09/16.
//

import SwiftUI
import Combine
import ComposableArchitecture

struct TCAView: View {
    typealias CounterStore = Store<CounterState, CounterAction>
    
    @ObservedObject var store: CounterStore // TCA Store
    
    var body: some View {
        VStack {
            Text("\(store.state.count)") // 상태를 뷰에 표시

            HStack {
                Button("Increment") {
                    self.store.send(.increment) // 액션 전달
                }

                Button("Decrement") {
                    self.store.send(.decrement) // 액션 전달
                }
            }
        }
    }
}

struct CounterState {
    var count: Int
}

enum CounterAction {
    case increment
    case decrement
}

struct CounterEnvironment {
    // 환경 변수나 외부 종속성이 있다면 이 곳에 정의할 수 있습니다.
}
