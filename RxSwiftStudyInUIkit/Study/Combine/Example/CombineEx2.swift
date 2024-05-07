//
//  CombineEx2View.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 4/28/24.
//

import SwiftUI

import Combine

struct CombineEx2View: View {
    
    @StateObject var handler: CombineEx2Handler = .init()
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("3. Combine 연산자")
                    .frame(height: 44)
                    .padding(.horizontal, 12)
                Spacer()
            }
            .padding(12)
            
            VStack(spacing: 12) {
                VStack {
                    Text("Mapping Operators")
                        .font(.title)
                        .frame(height: 38)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                    
                    Button {
                        handler.example_map()
                    } label: {
                        Text("1. map")
                    }
                    
                    Button {
                        handler.example_compactMap()
                    } label: {
                        Text("2. compactMap")
                    }
                    
                    Button {
                        handler.example_flatMap()
                    } label: {
                        Text("3. flatMap")
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
                    Text("Filtering Operators")
                        .font(.title)
                        .frame(height: 38)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                    
                    Button {
                        handler.example_filter()
                    } label: {
                        Text("1. filter")
                    }
                    
                    Button {
                        handler.example_removeDuplicates()
                    } label: {
                        Text("2. removeDuplicates")
                    }
                    
                    Button {
                        handler.example_first_last()
                    } label: {
                        Text("3. first / last")
                    }
                    
                    Button {
                        handler.example_dropWhile_dropUntilOutput()
                    } label: {
                        Text("3. dropWhile / dropUntilOutput")
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
                    Text("Combining Operators")
                        .font(.title)
                        .frame(height: 38)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                    
                    Button {
                        handler.example_merge()
                    } label: {
                        Text("1. merge")
                    }
                    
                    Button {
                        handler.example_zip()
                    } label: {
                        Text("2. zip")
                    }
                    
                    Button {
                        handler.example_combineLatest()
                    } label: {
                        Text("3. combineLatest")
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
                    Text("Error Handling Operators")
                        .font(.title)
                        .frame(height: 38)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                    
                    Button {
                        handler.example_catch()
                    } label: {
                        Text("1. catch")
                    }
                    
                    Button {
                        handler.example_retry()
                    } label: {
                        Text("2. retry")
                    }
                    
                    Button {
                        handler.example_assertNoFailure()
                    } label: {
                        Text("3. assertNoFailure")
                    }
                    
                    Button {
                        handler.example_replaceError()
                    } label: {
                        Text("3. replaceError")
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

final class CombineEx2Handler: ObservableObject {
    
    deinit {
        print("deinit CombineEx2Handler")
    }
    
    private var cancellables: Set<AnyCancellable> = .init()
    
    init() {
        
    }
    
    func example_map() {
        let publisher = Just(10)
        publisher
            .map { value in
                value * 2
            }
            .sink { value in
                print("Mapped value: \(value)")
            }
            .store(in: &cancellables)
    }
    
    func example_compactMap() {
        let publisher = PassthroughSubject<String, Never>()
        publisher
            .compactMap { value in
                Int(value)
            }
            .sink { value in
                print("CompactMapped value: \(value)")
            }
            .store(in: &cancellables)
        publisher.send("42")
        publisher.send("a")
    }
    
    func example_flatMap() {
        let publisher = PassthroughSubject<String, Never>()
        publisher
            .flatMap { value in
                Just(Int(value))
            }
            .sink { value in
                // 다른 Publisher에서 값을 받아 하나의 Publisher로 합쳐줍니다.
                print("CompactMapped value: \(String(describing: value))")
            }
            .store(in: &cancellables)
        
        publisher.send("42")
        publisher.send("a")
    }
    
    func example_filter() {
        let publisher = [1, 2, 3, 4, 5].publisher
        publisher
            .filter { value in
                value % 2 == 0
            }
            .sink { value in
                print("Filtered value: \(value)")
            }
            .store(in: &cancellables)
    }
    
    func example_removeDuplicates() {
        let publisher = [1, 1, 2, 3, 3, 4, 4, 5, 1].publisher
        publisher
            .removeDuplicates()
            .sink { value in
                print("연속된 중복 데이터를 제거하고 유일한 값만 전달합니다.")
                print("Unique value: \(value)")
            }
            .store(in: &cancellables)
    }
    
    func example_first_last() {
        let publisher = [1, 2, 3, 4, 5].publisher

        publisher
            .first()
            .sink { value in
                print("First value: \(value)")
            }
            .store(in: &cancellables)

        publisher
            .last()
            .sink { value in
                print("Last value: \(value)")
            }
            .store(in: &cancellables)
    }
    
    func example_dropWhile_dropUntilOutput() {
        let publisher = [1, 2, 3, 4, 5].publisher

        publisher
            .drop(while: { $0 < 3 })
            .sink { value in
                print("조건을 만족할 때까지 데이터를 생략합니다")
                print("Dropped while value: \(value)")
            }
            .store(in: &cancellables)

        let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<Void, Never>()

        publisher1
            .drop(untilOutputFrom: publisher2)
            .sink { value in
                print("두 Publisher 중 두 번째가 값을 전달할 때까지 첫 번째 Publisher의 데이터를 생략합니다.")
                print("Drop until output value: \(value)")
            }
            .store(in: &cancellables)

        publisher1.send(1)
        publisher1.send(2)
        publisher2.send(())
        publisher1.send(3) // 출력: Drop until output value: 3
    }
    
    // 여러 Publisher를 하나의 Publisher로 병합합니다.
    func example_merge() {
        let publisher1 = [1, 2, 3].publisher
        let publisher2 = [4, 5, 6].publisher
        
        Publishers.Merge(publisher1, publisher2)
            .sink { value in
                print("Merged value: \(value)")
            }
            .store(in: &cancellables)
    }
    
    // 여러 Publisher에서 동시에 데이터를 수신하여 결합합니다.
    func example_zip() {
        let publisher1 = [1, 2, 3].publisher
        let publisher2 = ["a", "b", "c"].publisher

        Publishers.Zip(publisher1, publisher2)
            .sink { value in
                print("Zipped value: \(value)")
            }
            .store(in: &cancellables)
    }
    
    // 여러 Publisher의 최신 데이터를 결합하여 전달합니다.
    func example_combineLatest() {
        let publisher1 = PassthroughSubject<Int, Never>()
        let publisher2 = PassthroughSubject<String, Never>()

        Publishers.CombineLatest(publisher1, publisher2)
            .sink { value in
                print("CombineLatest value: \(value)")
            }
            .store(in: &cancellables)

        publisher1.send(1)
        publisher2.send("a")
        publisher1.send(2) // 출력: CombineLatest value: (2, "a")
    }
    
    // 오류가 발생했을 때 대체 Publisher를 실행하여 오류를 처리합니다.
    func example_catch() {
        let publisher = Fail<Int, Error>(error: NSError(domain: "ExampleDomain", code: -1, userInfo: nil))
        
        publisher
            .catch { error in
                Just(42)
            }
            .sink { value in
                print("Catch value: \(value)")
            }
            .store(in: &cancellables)
    }
    
    // 오류가 발생했을 때 지정된 횟수만큼 재시도합니다.
    func example_retry() {
        let publisher = PassthroughSubject<String, Error>()

        publisher
            .retry(3)
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { value in
                print("Value: \(value)")
            }
            .store(in: &cancellables)
        
        publisher.send(completion: .failure(NSError(domain: "", code: -1)))
        // 이 예시에서는 오류만 방출하므로 Error만 받게 됨
    }
    
    // 오류 없이 성공적으로 완료되었다는 확신을 가집니다.
    func example_assertNoFailure() {
        let publisher = Just(42).assertNoFailure()
        
        publisher
            .sink { value in
                print("AssertNoFailure value: \(value)")
            }
            .store(in: &cancellables)
    }
    
    // 오류가 발생했을 때 대체 데이터를 사용하여 처리합니다.
    func example_replaceError() {
        let publisher = Fail<Int, Error>(error: NSError(domain: "ExampleDomain", code: -1, userInfo: nil))
        
        publisher
            .replaceError(with: 200)
            .sink { value in
                print("ReplaceError value: \(value)")
            }
            .store(in: &cancellables)
    }
}
