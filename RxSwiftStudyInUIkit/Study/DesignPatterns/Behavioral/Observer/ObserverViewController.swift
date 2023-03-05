//
//  ObserverViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class ObserverViewController: UIViewController {
    
    private let textView = UITextView().then {
        $0.isEditable = false
        $0.font = .systemFont(ofSize: 24)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(textView)
        
        textView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(24)
        }
        
        textView.text = """
        [ 옵저버 패턴 ]
        - 다수의 객체가 특정 객체 상태 변화를 감지하고 알림을 받는 패턴
        - 발행(Publish) - 구독(subscribe) 패턴을 구현할 수 있다.
        
        - 감지하고 상태의 변경을 지켜보는 패턴
        - 여러개의 객체들이 특정 상태 변화에 따라 반응하는 경우에 적용
        - Publish Subscribe 패턴을 쉽게 구현할 수 있음
        - 주기적으로 무언가를 요청해서 가져오는 것 : 폴링 매커니즘
        
        [장점]
        
        [단점]
        
        [사용 예제]
        """
        
        client()
    }
    
    private func client() {
        let server = ChatServer()
        
        let user1 = User(chatServer: server)
        user1.sendMessage(subject: "디자인패턴", message: "옵저버 패턴")
        user1.sendMessage(subject: "롤드컵", message: "LCK화이팅")
        
        let user2 = User(chatServer: server)
        print("text: ", user2.getMessage(subject: "디자인패턴"))
        
        user1.sendMessage(subject: "디자인패턴", message: "메멘토 패턴")
    }
}

class User {
    
    let chatServer: ChatServer
    
    init(chatServer: ChatServer) {
        self.chatServer = chatServer
    }
    
    func sendMessage(subject: String, message: String) {
        chatServer.sendMessage()
    }
    
    func getMessage(subject: String) -> String {
        return subject
    }
}

class ChatServer {
    
    func sendMessage() {
        
    }
}
