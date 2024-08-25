//
//  Config.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 4/27/24.
//

import SwiftUI
import Combine

let githubPath: String = "https://github.com/soohyeon-won/SwiftStudy/blob/master/RxSwiftStudyInUIkit"

//final class Config: ObservableObject {
//    
//    @ObservedObject static var shared: Config = .init()
//    
//    private init() { }
//    
//    @Published var codeViewFontSize: CGFloat = 9
//}
final class Config: ObservableObject {
    static let shared: Config = .init()
    
    private init() { }

    @Published var codeViewFontSize: CGFloat = 12
}
