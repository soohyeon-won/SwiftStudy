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
    public var sampleData: Data {
        switch self {
        case .emogi:
            return "{ }".data(using: .utf8)!
        }
    }
    
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
