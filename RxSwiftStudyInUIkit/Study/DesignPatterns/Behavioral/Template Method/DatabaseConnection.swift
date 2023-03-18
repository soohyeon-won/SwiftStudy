//
//  DatabaseConnection.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/03/18.
//

import Foundation

protocol DatabaseConnection {
    func connect()
    func executeQuery(_ query: String) -> [String]
    func disconnect()
    func execute(_ query: String) -> [String]
}

extension DatabaseConnection {
    // 템플릿 메소드
    func execute(_ query: String) -> [String] {
        connect()
        let result = executeQuery(query)
        disconnect()
        return result
    }
}

class MySQLConnection: DatabaseConnection {
    func connect() {
        // MySQL 연결 로직
    }
    
    func executeQuery(_ query: String) -> [String] {
        return [String]()
    }
    
    func disconnect() {
        
    }
}
