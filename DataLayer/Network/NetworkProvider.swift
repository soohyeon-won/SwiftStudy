//
//  NetworkProvider.swift
//  DataLayer
//
//  Created by won soohyeon on 2023/01/31.
//

import Moya
import RxSwift

public enum GithubAPI {
    case emogi
}

extension GithubAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    public var path: String {
        return "/emojis"
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        return params
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var task: Task {
        switch self {
        default:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: parameterEncoding)
            }
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        let authorization = "localTestId:!QAZ@WSX3e" //.toBase64()
        return ["Content-Type": "application/x-www-form-urlencoded",
                 "Authorization": "Basic " + authorization]
    }
}

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

import RxSwift

public enum FilterMap<Result> {
    case ignore
    case map(Result)
}

extension ObservableType {

    /**
     Filters or Maps values from the source.
     - The returned Observable will complete with the source.  It will error with the source or with error thrown by transform callback.
     - `next` values will be output according to the `transform` callback result:
        - returning `.ignore` will filter the value out of the returned Observable
        - returning `.map(newValue)` will propagate newValue through the returned Observable.
     */
    public func filterMap<Result>(_ transform: @escaping (Element) throws -> FilterMap<Result>) -> Observable<Result> {
        return compactMap { element in
            switch try transform(element) {
            case .ignore:
                return nil
            case let .map(result):
                return result
            }
        }
    }
}
