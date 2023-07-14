//
//  SwfitUIView.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/09/16.
//

import SwiftUI

struct GCDView: View {
    
    @StateObject var viewModel: GCDViewModel = GCDViewModel()
    
    var body: some View {
        
        VStack() {
            Text(viewModel.model.title)
            
            Divider()
            
            Text("array count: \(viewModel.model.count)")
            ForEach(viewModel.model.array, id: \.self) { string in
                Text(string)
            }
            
            Button {
                viewModel.processThread()
            } label: {
                Text("스레드 실행")
            }
            Spacer()
        }
    }
}

final class GCDViewModel: ObservableObject {
    
    class Model {
        @Published var title: String = "📚 GCD Study"
        @Published var array: [String] = [String]()
        @Published var count: Int = 0
        
        func append(item: String) {
            array.append(item)
            count += 1
        }
    }
    
    @Published var model: Model = Model()
    
    init() {
        setup()
    }
    
    func setup() {
        
        DispatchQueue.main.async {
            self.model.append(item: "🟢 main thread")
        }
        DispatchQueue.global().async {
            self.model.append(item: "🔵 background thread")
        }
    }
    
    func processThread() {
        self.model.append(item: "Test")
    }
}

