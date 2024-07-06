//
//  CombineEx1.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 4/28/24.
//

import SwiftUI

import Combine

struct CombineEx1View: View {
    
    @StateObject var handler: CombineEx1Handler = .init()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top) {
                    Text("1. 기본 개념 이해")
                        .frame(height: 44)
                        .padding(.horizontal, 12)
                    Spacer()
                }
                .padding(12)
                
                VStack(spacing: 12) {
                    VStack {
                        Text("Reactive Programming")
                            .font(.title)
                            .frame(height: 38)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                        
                        Text("""
                            반응형 프로그래밍: 이벤트와 데이터 흐름으로 동작하는 패러다임
                            변화에 따라 시스템이 반응하며 동작
                            Publisher(배포 주체) -> Subscriber(구독자)
                            """)
                    }
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                    )
                    .padding(.horizontal, 16)
                }
                HStack(alignment: .top) {
                    Text("2. Combine의 핵심 구성 요소")
                        .frame(height: 44)
                        .padding(.horizontal, 12)
                    Spacer()
                }
                .padding(12)
                
                VStack(spacing: 12) {
                    VStack {
                        Text("Publishers")
                            .font(.title)
                            .frame(height: 38)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                        
                        Button {
                            handler.example_just()
                        } label: {
                            VStack {
                                Text("1. just")
                                CodeView(code: "let justPublisher = Just(42)")
                            }
                        }
                        
                        Button {
                            handler.example_future()
                        } label: {
                            VStack {
                                Text("2. future")
                                CodeView(
                                    code: """
                                    // 단일 비동기 작업의 결과 즉, 한 번의 완료 또는 실패 이벤트만 발생 (Network 작업에 유용)
                                    func fetchData(from url: URL) -> Future<Data, Error> {
                                        return Future { promise in
                                            URLSession.shared.dataTask(with: url) { data, response, error in
                                                if let error = error {
                                                    promise(.failure(error))
                                                } else if let data = data {
                                                    promise(.success(data))
                                                }
                                            }.resume()
                                        }
                                    }
                                    """
                                )
                            }
                        }
                        
                        Button {
                            handler.example_passthroughSubject()
                        } label: {
                            VStack {
                                Text("3. passthroughSubject")
                                CodeView(
                                    code: """
                                // 여러 Subscriber에 전달할 때 유용합니다.
                                // 데이터를 직접 보내거나 완료 신호를 보내는 등의 제어가 가능합니다.
                                // PublishSubject와 유사하다
                                let subject = PassthroughSubject<String, Never>()
                                """
                                )
                            }
                        }
                        
                        Button {
                            handler.example_currentValueSubject()
                        } label: {
                            VStack {
                                Text("4. currentValueSubject")
                                CodeView(code: """
                                // 지정된 초기값을 구독자가 알 수 있는 형태
                                // CurrentValueSubject 는 BehaviorSubject와 유사
                                CurrentValueSubject<String, Error>(Initial value)
                                """)
                            }
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
                        Text("Subscribers")
                            .font(.title)
                            .frame(height: 38)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                        
                        Button {
                            handler.example_just()
                        } label: {
                            Text("1. sink")
                        }
                        
                        Button {
                            handler.example_assign()
                        } label: {
                            Text("2. assign \(handler.value)")
                        }
                    }
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                    )
                    .padding(.horizontal, 16)
                }
                
                CombineEx2View()
                
                CombineEx3View()
                
                CombineEx4View()
                
                CombineEx5View()
                
                Spacer()
            }
        }.onDisappear {
            handler.disappear()
        }
    }
}

final class CombineEx1Handler: ObservableObject {
    
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
//        오류 없이 성공적으로 완료된다는 확신이 있을 때 Error대신 Never를 사용
        let futurePublisher = Future<String, Error> { promise in
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

#Preview {
    CombineEx1View(handler: CombineEx1Handler())
}
