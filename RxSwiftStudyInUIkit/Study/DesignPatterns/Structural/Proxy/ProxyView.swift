//
//  ProxyViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/11.
//

import SwiftUI

struct ProxyView: View {
    
    private let textViewContent = """
        [ 프록시 패턴 ]
        특정 객체에 대한 접근을 제어하거나 기능을 추가할 수 있는 패턴
        - 초기화 지연, 접근 제어, 로깅, 캐싱 등 다양하게 응용해 사용할 수 있다.
        
        Subject
        ↑
        ↑ ←-------------
        RealSubject ← proxy
        
        대리, 대리인
        security를 적용해서 접근을 제한 할 수 있는 로직을 넣을 수 도 있고
        로깅, 캐싱을 적용할 수 도 있음.
        
        [장점]
        1. 기존 코드를 변경하지 않고 새로운 기능을 추가할 수 있다. // OCP
        2. 기존 코드가 해야하는 일만 유지할 수 있다. // SRP
        3. 기능 추가 및 초기화 지연 등으로 다양하게 활용할 수 있다.
        만드는데 시간이 오래걸리고 메모리가 많이 드는 작업이라면 proxy를 통해서 lazy로 객체를 초기화 해줄 수 있다.
        
        [단점]
        코드의 복잡도가 증가한다.
        
        [사용 예시]
        1. Mirror.init(reflecting subject: Any)
        ex) JAVA - 다이나믹(runtime과 관련) 프록시 (reflect.Proxy)
        Mirror의 기능은 다른 객체의 기능을 제어하거나 대신하는 기능을 제공하기 때문에 프록시 패턴과 관련이 있음
        """
    
    var body: some View {
        ScrollView {
            Text(textViewContent)
                .font(.system(size: 24))
                .padding(24)
                .background(Color.white)
                .cornerRadius(8)
            
            CodeView(code: """
            // before
            //        DefaultGameService().startGame()
            //        GameServiceProxy().startGame()
            
            // after
            GameServiceProxy(gameService: DefaultGameService()).startGame()
            GameServiceProxy2().startGame()
            
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
            
            // Swift에서 reflection을 사용하면
            // struct, class 또는 기타 타입에 관계 없이 타입에 있는 stored property의 값을 읽을 수 있다
            let c = DefaultChampion(championName: "championName", skin: 정복자Skin())
            let mirror = Mirror(reflecting: c)
            mirror.children.forEach {
                print($0)
            }
            """)
        }
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .onAppear {
            client()
        }
    }
    
    private func client() {
        // before
//        DefaultGameService().startGame()
//        GameServiceProxy().startGame()
        
        // after
        GameServiceProxy(gameService: DefaultGameService()).startGame()
        GameServiceProxy2().startGame()
        
        // Swift에서 reflection을 사용하면
        // struct, class 또는 기타 타입에 관계 없이 타입에 있는 stored property의 값을 읽을 수 있다
        let c = DefaultChampion(championName: "아리", skin: 정복자Skin())
        let mirror = Mirror(reflecting: c)
        mirror.children.forEach {
            print($0)
        }
    }
}
