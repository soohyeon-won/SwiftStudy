//
//  CombineEx4View.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 4/28/24.
//

import SwiftUI

import Combine

struct CombineEx4View: View {
    
    @StateObject var handler: CombineEx4Handler = .init()
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("5. Advanced topics")
                    .frame(height: 44)
                    .padding(.horizontal, 12)
                Spacer()
            }
            .padding(12)
            
            VStack(spacing: 12) {
                VStack {
                    Text("Backpressure")
                        .font(.title)
                        .frame(height: 38)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                    
                    Text(
                         """
                         데이터 흐름의 속도 조절
                         Publisher가 너무 많은 데이터를 빠르게 전달하는 것을 방지
                         Demand를 조절하여 publisher의 데이터 생산 제어
                         """)
                    .padding(.horizontal, 16)
                    
                    Button {
                        handler.example_throttle_debounce()
                    } label: {
                        Text("1. throttle / debounce")
                    }
                }
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                )
                .padding(.horizontal, 16)
            }
            
            VStack(spacing: 12) {
                VStack {
                    Text("Debugging and Performance")
                        .font(.title)
                        .frame(height: 38)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                    
                    Button {
                        handler.example_debug()
                    } label: {
                        Text("1. debug")
                    }
                    
                }
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                )
                .padding(.horizontal, 16)
            }
            Spacer()
        }
    }
}

final class CombineEx4Handler: ObservableObject {
    
    deinit {
        print("deinit CombineEx4Handler")
    }
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    init() {
        
    }
    
    func example_throttle_debounce() {
        // PassthroughSubject를 생성하여 이벤트 생성
        let publisher = PassthroughSubject<String, Never>()

        // throttle 연산자 사용: 1초 간격으로 최신 이벤트 전달
        let throttledPublisher = publisher
            .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)

        // debounce 연산자 사용: 1초 동안 이벤트가 없으면 최신 이벤트 전달
        let debouncedPublisher = publisher
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)

        throttledPublisher
            .sink { value in
                print("Throttle: \(value)")
            }
            .store(in: &cancellables)

        debouncedPublisher
            .sink { value in
                print("Debounce: \(value)")
            }
            .store(in: &cancellables)

        // 이벤트를 게시
        publisher.send("Event 1")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            publisher.send("Event 2")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            publisher.send("Event 3")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            publisher.send("Event 4")
        }
        
//        출력
//    Throttle: Event 1
//    Throttle: Event 3
//    Debounce: Event 3
//    Throttle: Event 4
//    Debounce: Event 4
    }
    
    func example_debug() {
        let numbers = [1, 2, 3, 4, 5].publisher

        numbers
            .print() // print - default
            .print("debug") // print - debug: default
            .sink { completion in
//                print("Completion: \(completion)")
            } receiveValue: { value in
//                print("Received value: \(value)")
            }
            .store(in: &cancellables)
    }
}
