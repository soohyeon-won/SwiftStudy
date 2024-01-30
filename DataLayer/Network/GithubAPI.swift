//
//  GithubAPI.swift
//  DataLayer
//
//  Created by won soohyeon on 2023/06/07.
//

import Moya

public enum GithubAPI {
    case emogi
    case errorTest
}

extension GithubAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    public var path: String {
        switch self {
        case .emogi:
            return "/emojis"
        case .errorTest:
            return "error"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var parameters: [String: Any]? {
        return [String: Any]()
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
