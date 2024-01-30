//
//  NetworkProvider.swift
//  DataLayer
//
//  Created by won soohyeon on 2023/01/31.
//
import Foundation

import RxSwift
import Moya

public extension MoyaProvider where Target: TargetType {
    
    func request<M: Codable>(api: Target) -> Single<M> {
        rx.request(api)
            .flatMap { response in
                do {
                    let model = try JSONDecoder().decode(M.self, from: response.data)
                    print(String(data: response.data, encoding: .utf8) ?? "can not response")
                    return Single.just(model)
                } catch {
                    return Single.error(error)
                }
            }
            .catch { error in
                return Single.error(error)
            }
    }
}

public struct GithubModel: Codable {
    
}
