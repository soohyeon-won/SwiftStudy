//
//  NetworkProvider.swift
//  DataLayer
//
//  Created by won soohyeon on 2023/01/31.
//

import RxSwift

import Moya

public class APIProvider<T: TargetType>: MoyaProvider<T> {
    private let tokenProvider = MoyaProvider<GithubAPI>()
    private let disposebag = DisposeBag()

    private func reqRefreshToken() {
        tokenProvider.rx.request(.emogi)
    }
    
    func request(target: T) {
        rx.request(target).map { response in
            
        }
    }
}
