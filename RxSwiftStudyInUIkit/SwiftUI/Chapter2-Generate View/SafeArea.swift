//
//  SafeArea.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 11/7/23.
//

import SwiftUI

struct SafeArea<Content>: View where Content: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
    }
}
