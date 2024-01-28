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
        
        let response: Single<GithubModel> = fetch(api: .emogi)
        response
            .subscribe(onSuccess: { model in
                print("model: \(model)")
            }, onFailure: { error in
                print("error: \(error)")
            })
            .disposed(by: disposeBag)
        
        let errorResponse: Single<GithubModel> = fetch(api: .errorTest)
        errorResponse
            .subscribe(onSuccess: { model in
                print("model: \(model)")
            }, onFailure: { error in
                print("error: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func fetch<T: Decodable>(api: GithubAPI) -> Single<T> {
        return provider.rx.request(.emogi)
            .flatMap { response -> Single<T> in
                do {
                    let model = try JSONDecoder().decode(T.self, from: response.data)
                    return Single.just(model)
                } catch {
                    return Single.error(error)
                }
            }
    }
}
