//
//  MoyaViewModel.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/06/07.
//

import Foundation

import DataLayer

import RxSwift

final class MoyaViewModel {
    
    let provider: APIProvider<GithubAPI>
    
    init(provider: APIProvider<GithubAPI> = .init()) {
        self.provider = provider
    }
    
    func fetch() {
        provider.request(.emogi) { result in
            print("result: \(result)")
        }
    }
}
