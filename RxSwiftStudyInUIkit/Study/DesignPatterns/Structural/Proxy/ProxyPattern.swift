//
//  ProxyPattern.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 7/13/24.
//

import Foundation

protocol GameService {
    func startGame()
}

class DefaultGameService: GameService {
    
    func startGame() {
        print("이 자리에 오신 여러분을 진심으로 환영합니다.")
    }
}

class GameServiceProxy: GameService {
    
    private let gameService: GameService
    
    init(gameService: GameService) {
        self.gameService = gameService
    }
    
    func startGame() {
        let log = Date() //부가적인 일들은 프록시에서 제공
        gameService.startGame()
        print("log", log)
    }
}

class GameServiceProxy2: GameService {
    
    var gameService: GameService? = nil
    
    func startGame() {
        let log = Date() //부가적인 일들은 프록시에서 제공
        if gameService == nil {
            gameService = DefaultGameService() // lazy init제공 가능
        }
        gameService?.startGame()
        print("log", log)
    }
}
