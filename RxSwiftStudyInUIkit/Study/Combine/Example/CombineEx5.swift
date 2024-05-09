//
//  CombineEx5View.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 4/28/24.
//

import SwiftUI

import Combine

struct CombineEx5View: View {
    
    @ObservedObject var observedModel: CombineEx5Handler = .init()
    var plainModel: CombineEx5Handler = .init()
    
    // 아래는 성립 안됨
    // @Published 는 class에서만 선언될 수 있음
    // class 타입의 객체에서 @Published 속성을 사용할 때, 이 객체가 해제될 때 모든 구독자를 자동으로 해제할 수 있습니다. 반면에 struct는 값 타입이기 때문에 복사될 때 @Published와 연결된 구독 관계를 계속 유지할 수 없습니다. 이는 값 타입의 특성상 각 복사본이 구독 관계를 유지할 수 없기 때문입니다.
//    @Published var publishedModel: CombineEx5Handler = .init()
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("6. QnA")
                    .frame(height: 44)
                    .padding(.horizontal, 12)
                Spacer()
            }
            .padding(12)
            
            VStack(spacing: 12) {
                VStack {
                    Text("@Published vs ObservedObject")
                        .font(.title3)
                        .frame(height: 38)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                    
                    Text("""
                        [ @Published ]
                        ObservableObject를 구현한 클래스나 actor의 프로퍼티에 적용
                        프로퍼티 변경 시 이벤트를 구독자들에게 전파
                        
                        [ ObservedObject ]
                        SwiftUI에서 사용되는 속성 래퍼
                        ObservableObject를 구현한 객체를 관찰하고 객체의 변화에 따라 UI를 업데이트
                        """)
                    
                    Button {
                        observedModel.myValue = 20
                    } label: {
                        Text("myValue 변경")
                    }
                    
                    Text("observedModel: \(observedModel.myValue)")
                    
                    Button {
                        plainModel.myValue = 30
                    } label: {
                        Text("myValue 변경")
                    }
                    
                    Text("plainModel: \(plainModel.myValue)")
                }
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                )
                .padding(.horizontal, 16)
                
                VStack {
                    Text("@Published로 객체 선언 테스트")
                        .font(.title3)
                        .frame(height: 38)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                    
                    Text("""
                        @Published로 선언된 model 객체의 프로퍼티(myValue)가 변경되어도 이벤트 전파X (changeValue)
                        
                        객체 자체가 교체 될 때 변경 이벤트가 전파 (changeInstance)
                        
                        그렇기 때문에 @ObservedObject로 선언 후 내부에 @Publised로 프로퍼티를 선언 후 구독자에게 변경을 알리는 방법을 사용함
                        """)
                    .padding(.horizontal, 16)
                    
                    Button {
                        observedModel.changeValue()
                    } label: {
                        Text("myValue 값 변경")
                    }
                    Text("변경 안됨: \(observedModel.testModel.myValue)")
                    
                    Button {
                        observedModel.changeInstance()
                    } label: {
                        Text("객체 자체 변경")
                    }
                    Text("\(observedModel.testModel.myValue)")
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

final class CombineEx5Handler: ObservableObject {
    
    deinit {
        print("deinit CombineEx5Handler")
    }
    
    @Published var myValue: Int = 0
    @Published var testModel: ObservedObjectModel = .init()
    
    func changeInstance() {
        testModel = .init(myValue: 9999)
    }
    
    func changeValue() {
        testModel.myValue = 1000
    }
}

// MARK: - @Publised vs ObservedObject

class ObservedObjectModel: ObservableObject {
    @Published var myValue: Int = 0
    
    init(myValue: Int = 0) {
        self.myValue = myValue
    }
}
