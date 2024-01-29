//
//  MoyaViewModel.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/06/07.
//

import Foundation

import DataLayer

import RxSwift
import Network
import ComposableArchitecture
import Moya

final class MoyaViewModel {
    
    let provider: MoyaProvider<GithubAPI>
    let disposeBag: DisposeBag = .init()
    
    init(provider: MoyaProvider<GithubAPI> = MoyaProvider<GithubAPI>()) {
        self.provider = provider
        
        let response: Single<GithubModel> = provider.request(api: .emogi)
        
        response
            .subscribe(onSuccess: { response in
                print("respponse: \(response)")
            }, onFailure: { error in
                print("error: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
