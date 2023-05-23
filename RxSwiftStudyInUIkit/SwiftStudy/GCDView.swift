//
//  SwfitUIView.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/09/16.
//

import SwiftUI

import Combine

struct GCDView: View {
    
    @StateObject private var viewModel = GCDViewModel()
    
    var body: some View {
        VStack {
            Text("📚 Swift Study")
            TextEditor(text: $viewModel.text)
                .allowsHitTesting(false)
        }
        .padding(16)
        .onAppear {
            Person().test()
        }
    }
}

class GCDViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var list = [Model]()
    
    struct Model {
        let isHidden: Bool
        let title: String
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // TextEditor의 텍스트가 변경될 때마다 ViewModel의 text 속성을 업데이트합니다.
        text = "test"
    }
}
