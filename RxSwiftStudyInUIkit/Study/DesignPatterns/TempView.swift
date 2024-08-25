//
//  Builder.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 8/25/24.
//

import SwiftUI

struct TempView: View {
    
    private let textViewContent: String = """
        """
    
    var body: some View {
        VStack {
            ScrollView {
                Text(textViewContent)
                    .font(.system(size: 24))
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(8)
                
                CodeView(code: """
                """)
            }
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .onAppear {
                
            }
        }
    }
    
    private func client() {
    }
}
