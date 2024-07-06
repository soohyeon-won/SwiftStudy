//
//  FutureVsAnyPublisherView.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 7/6/24.
//

import Combine
import SwiftUI

struct FutureVsAnyPublisherView: View {
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Future")) {
                    Text("Future는 단일 비동기 작업의 결과를 나타내는 퍼블리셔입니다.\n비동기 작업이 완료되면 한 번의 성공 또는 실패 이벤트를 발생시킵니다.")
                    
                    CodeView(code: """
                    let futurePublisher = Future<String, Error> { promise in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            promise(.success("Hello, Future!"))
                        }
                    }
                    """)
                    
                    Text("장점:간단 작업에 적합")
                    Text("단점:추가적인 연산자 체인을 사용하기 어려움 > 네트워크 요청 후 결과를 처리하기 위해 추가적인 작업이 필요할 경우 코드가 복잡해질 수 있음")
                }
                
                Section(header: Text("AnyPublisher")) {
                    Text("AnyPublisher는 여러 연산자를 연결하여 데이터 흐름을 쉽게 구성할 수 있는 퍼블리셔입니다.\n네트워크 요청 결과를 바로 디코딩하고, 다른 연산자를 사용하여 데이터 처리를 간결하게 할 수 있습니다.")
                    
                    CodeView(code: """
                    func fetchData() -> AnyPublisher<CombineExampleTodo, Error> {
                        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
                        return URLSession.shared.dataTaskPublisher(for: url)
                            .map(\\.data)
                            .decode(type: CombineExampleTodo.self, decoder: JSONDecoder())
                            .eraseToAnyPublisher()
                    }
                    """)
                    
                    Text("장점:연산자 체인 사용 가능")
                    Text("단점:간단한 비동기 작업에 비해 초기 설정이 약간 복잡할 수 있음")
                }
                
                Section(header: Text("결론")) {
                    Text("일반적으로 네트워크 요청을 처리할 때는 AnyPublisher를 사용하는 것이 더 좋습니다.\n 이는 코드가 더 간결하고 유지보수가 용이하며, 연산자 체인을 사용하여 데이터 처리를 쉽게 확장할 수 있기 때문입니다.")
                }
            }
            .navigationBarTitle("Future vs AnyPublisher")
            .listStyle(GroupedListStyle())
        }
    }
}
