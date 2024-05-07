//
//  CombineEx3.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 4/28/24.
//

import SwiftUI

import Combine

struct CombineEx3View: View {
    
    @StateObject var handler: CombineEx3Handler = .init()
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("4. 실전 예제")
                    .frame(height: 44)
                    .padding(.horizontal, 12)
                Spacer()
            }
            .padding(12)
            
            VStack(spacing: 12) {
                VStack {
                    Text("Network")
                        .font(.title)
                        .frame(height: 38)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                    
                    Button {
                        handler.example_network()
                    } label: {
                        Text("fetchData")
                    }
                    
                    Text("api text: \(handler.apiText)")
                    
                    Text("model text: \(handler.model.apiText)")
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
                    // TextField와 model.text의 바인딩
                    TextField("Enter text", text: $handler.text)
                        .padding()
                    
                    // model.text의 값을 Text 뷰에 표시
                    Text("You typed: \(handler.text)")
                        .padding()
                }
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                )
                .padding(.horizontal, 16)
            }
        }
    }
}

final class CombineEx3Handler: ObservableObject {
    
    deinit {
        print("deinit CombineEx3Handler")
    }
    
    @Published var text: String = ""
    @Published var apiText: String = ""
    
    // @ObservedObject는 SwiftUI 뷰에서 ObservableObject를 관찰하고 데이터 바인딩을 통해 뷰를 업데이트합니다.
    // @Published는 Combine에서 데이터 흐름을 관리하고, 구독자들에게 데이터의 변화를 전달합니다.
    // @ObservedObject는 SwiftUI 뷰와 데이터 바인딩을 위한 속성 래퍼이며, @Published는 Combine의 Publisher 역할을 수행하는 속성 래퍼입니다.
    
    // 외부에서 객체를 주입받을 때 @ObservedObject를 사용하고
    // 객체 내부에 데이터 선언시 @Published를 사용해서 View에서 이를 구독하여 바인딩 할 수 있게 사용하면 되겠다.
    @ObservedObject var model: CombineExampleTodoModel = .init()
    private var cancellables: Set<AnyCancellable> = .init()
    
    func example_network() {
        fetchData()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("네트워크 요청이 완료되었습니다.")
                case .failure(let error):
                    print("오류: \(error)")
                }
            } receiveValue: { [weak self] data in
                guard let self else { return }
                print("받은 데이터: \(data)")
                self.apiText = data.title
                self.model.apiText = data.title
            }
            .store(in: &cancellables)
    }
    
    private func fetchData() -> AnyPublisher<CombineExampleTodo, Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data) // 응답 데이터를 추출
            .decode(type: CombineExampleTodo.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

struct CombineExampleTodo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

class CombineExampleTodoModel: ObservableObject {
    @Published var text: String = ""
    @Published var apiText: String = ""
}
