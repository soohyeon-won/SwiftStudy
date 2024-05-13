//
//  CacheExample1.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 4/28/24.
//

import SwiftUI

import Combine

import SwiftUI

struct CacheEx1View: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("캐시의 개념 이해")
                    .font(.title)
                    .fontWeight(.bold)
                
                // LRU 전략
                Text("1. LRU (Least Recently Used)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text("최근에 사용하지 않은 데이터를 우선적으로 제거하는 전략입니다. 메모리나 저장 공간을 효율적으로 관리할 수 있습니다. 사용 사례로는 이미지 캐싱, 데이터베이스 쿼리 결과 캐싱 등이 있습니다.")
                
                // FIFO 전략
                Text("2. FIFO (First In, First Out)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text("데이터가 입력된 순서대로 제거하는 전략입니다. 단순하지만 특정 경우에 효과적일 수 있습니다. 예를 들어, 로그 데이터의 캐싱에 사용할 수 있습니다.")
                
                // LFU 전략
                Text("3. LFU (Least Frequently Used)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text("사용 빈도가 낮은 데이터를 우선적으로 제거하는 전략입니다. 자주 사용되는 데이터에 우선순위를 두어 캐싱 효율을 높입니다. 예를 들어, 자주 액세스되는 데이터의 캐싱에 사용할 수 있습니다.")
                
                // MRU 전략
                Text("4. MRU (Most Recently Used)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text("최근에 사용된 데이터를 우선적으로 유지하는 전략입니다. 최신 데이터를 유지함으로써 최신 정보의 빠른 액세스를 보장합니다.")
                
                // ARC 전략
                Text("5. ARC (Adaptive Replacement Cache)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text("LRU와 LFU를 혼합한 전략으로, 시스템의 동작 패턴에 따라 적응적으로 캐싱 전략을 조절합니다.")
            }
            .padding()
        }
    }
}

struct CacheEx1View_Previews: PreviewProvider {
    static var previews: some View {
        CacheEx1View()
    }
}


final class CacheEx1ViewHandler: ObservableObject {
    
    deinit {
        print("deinit CombineEx1Handler")
    }
    
    @Published var value: Int = 0
    private let currentValueSubject = CurrentValueSubject<String, Error>("Initial value")
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    init() {
        subscribeCurrentValueSubject()
    }
    
    func disappear() {
        
    }
    
    // Just는 단일 값을 즉시 생성하여 전달하는 Publisher입니다. 데이터가 한 번만 발생하며 완료됩니다.
    func example_just() {
        let justPublisher = Just(42) // 42라는 값을 가진 Just Publisher 생성

        justPublisher
            .sink { completion in
                print("Completion: \(completion)")
                switch completion {
                case .finished:
                    print("Completion: finished")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { value in
                print("Received value: \(value)")
            }
            .store(in: &cancellables)
    }
    
    // Future는 비동기 작업의 결과를 전달하는 Publisher입니다. 예를 들어 네트워크 요청을 수행하고 결과를 반환할 때 사용합니다.
    // 네트워크 작업에 유용
    // Future는 Error 타입을 Failure로 지정할 수 있어 오류 처리에 유용합니다.
    func example_future() {
//        오류 없이 성공적으로 완료된다는 확신이 있을 때 Never를 사용
        let futurePublisher = Future<String, Never> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
            .store(in: &cancellables)
        
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
    
    // 여러 Subscriber에 전달할 때 유용합니다.
    // 데이터를 직접 보내거나 완료 신호를 보내는 등의 제어가 가능합니다.
    // PublishSubject와 유사하다
    func example_passthroughSubject() {
        let subject = PassthroughSubject<String, Never>()

        subject
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { value in
                print("Received value: \(value)")
            }
            .store(in: &cancellables)

        subject.send("Hello, PassthroughSubject!")
        subject.send("Another value")
        subject.send(completion: .finished)
    }
    
    // CurrentValueSubject 는 BehaviorSubject와 유사
    // 지정된 초기값을 구독자가 알 수 있는 형태
    private func subscribeCurrentValueSubject() {
        currentValueSubject
            .receive(on: DispatchQueue.main) // UI 작업을 실행해야 하는 경우
            .sink { completion in
                // 완료 또는 오류 처리
                print("Completion: \(completion)")
            } receiveValue: { value in
                // 값 수신
                print("Received value: \(value)")
            }
            .store(in: &cancellables)
    }
    
    func example_currentValueSubject() {
        currentValueSubject.send("changed")
    
        // currentValueSubject를 Naver로 지정한 경우 failure를 받지 않는다.
        let error = NSError(domain: "ExampleDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "An example error occurred"])
        
        // completion 방출시 send로 새로운 값을 보내도 구독하지 않음
        currentValueSubject.send(completion: .failure(error))
        
        // 위에서 completion 이 방출 되었으므로 구독이 끊김
        currentValueSubject.send(completion: .finished)
    }
    
    func example_assign() {
        let justPublisher = Just(42)
        justPublisher
            .assign(to: \.value, on: self)
            .store(in: &cancellables)
    }
}
