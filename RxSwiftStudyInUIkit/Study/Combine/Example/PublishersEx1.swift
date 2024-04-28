//
//  PublishersEx1.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 4/28/24.
//

import SwiftUI

import Combine

struct PublishersEx1View: View {
    
    let handler: PublishersEx1Handler = .init()
    
    var body: some View {
        VStack {
            Button {
                handler.example_just()
            } label: {
                Text("just")
            }
            
            Button {
                handler.example_future()
            } label: {
                Text("future")
            }
            
            Button {
                handler.example_passthroughSubject()
            } label: {
                Text("passthroughSubject")
            }
        }
    }
}

struct PublishersEx1Handler {
    
    // Just는 단일 값을 즉시 생성하여 전달하는 Publisher입니다. 데이터가 한 번만 발생하며 완료됩니다.
    func example_just() {
        let justPublisher = Just(42) // 42라는 값을 가진 Just Publisher 생성

        justPublisher
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { value in
                print("Received value: \(value)")
            }
    }
    
    // Future는 비동기 작업의 결과를 전달하는 Publisher입니다. 예를 들어 네트워크 요청을 수행하고 결과를 반환할 때 사용합니다.
    func example_future() {
//        오류 없이 성공적으로 완료된다는 확신이 있을 때 Never를 사용
        let futurePublisher = Future<String, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                // 1초 후에 비동기 작업을 완료하고 값을 전달
                promise(.success("Hello, Future!"))
            }
        }

        futurePublisher
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { value in
                print("Received value: \(value)")
            }
        
        // 에러가 있는 경우
//        let futurePublisher2 = Future<String, Error> { promise in
//            // 비동기 작업 수행
//            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//                // 작업 중 오류가 발생했을 때
//                let error = NSError(domain: "ExampleDomain", code: -1, userInfo: nil)
//                promise(.failure(error))
//            }
//        }
    }
    
    func example_passthroughSubject() {
        let subject = PassthroughSubject<String, Never>()

        let subscriber = subject
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { value in
                print("Received value: \(value)")
            }

        subject.send("Hello, PassthroughSubject!")
        subject.send("Another value")
        subject.send(completion: .finished)
    }
}
