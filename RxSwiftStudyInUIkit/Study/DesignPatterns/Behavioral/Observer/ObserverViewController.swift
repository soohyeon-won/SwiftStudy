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
    
    // for KVO
    let objectToObserve = MyClass()
    var observation: NSKeyValueObservation?
    
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
        옵저버 (Observer) 패턴
        다수의 객체가 특정 객체 상태 변화를 감지하고 알림을 받는 패턴.
        • 상태를 변경하는 객체(publisher)와 변경을 감지하는 객체(subsriber)의 관계를 느슨하게 유지할 수 있다.
        • Subject의 상태 변경을 주기적으로 조회하지 않고 자동으로 감지할 수 있다.
        • 런타임에 옵저버를 추가하거나 제거할 수 있다.

        [단점]
        • 복잡도가 증가한다.
        • 다수의 Observer 객체를 등록 이후 해지 않는다면 memory leak이 발생할 수도 있다.
          적절하게 메모리 참조를 해제해주어야 한다.
          자동으로 reference를 해지하도록 할 수 도 있음.
          Java에서는 HashMap 에 WeakReference를 적용하여 사용하기도 함
        
        [사용 예제]
        1. 대화방 메시지 get
        2. 주식 가격 알림
        
        [사용 예시]
        1. NotificationCenter
        2. KVO
        """
        
        clientChat()
        clientStock()
        exampleKVO()
    }
    
    private func clientChat() {
        let server = ChatServer()
        
        let user1 = User(chatServer: server)
        user1.sendMessage(subject: "디자인패턴", message: "옵저버 패턴")
        user1.sendMessage(subject: "롤드컵", message: "LCK화이팅")
        
        let user2 = User(chatServer: server)
        print("text: ", user2.getMessage(subject: "디자인패턴"))
        
        user1.sendMessage(subject: "디자인패턴", message: "메멘토 패턴")
        print("text: ", user2.getMessage(subject: "디자인패턴"))
        
        let observerUser1 = ObserverUser(name: "observerUser1")
        let observerUser2 = ObserverUser(name: "observerUser2")
        
        let observerChatServer = ObserverChatServer()
        observerChatServer.register(subject: "오징어게임", subscriber: observerUser1)
        observerChatServer.register(subject: "오징어게임", subscriber: observerUser2)
        
        observerChatServer.register(subject: "디자인패턴", subscriber: observerUser1)
        
        observerChatServer.sendMessage(user: observerUser1, subject: "오징어게임", message: "이름이 기억났어")
        observerChatServer.sendMessage(user: observerUser2, subject: "디자인패턴", message: "옵저버 패턴으로 만든 채팅")
        
        observerChatServer.unregister(subject: "디자인패턴", subscriber: observerUser1) // • 런타임에 옵저버를 추가하거나 제거할 수 있다.
        observerChatServer.sendMessage(user: observerUser2, subject: "디자인패턴", message: "디자인패턴 장, 단점 듣는중")
    }
    
    func clientStock() {
        // 주식 시장 시뮬레이션
        let stockPrice = StockPrice()
        let investor1 = Investor(name: "John")
        let investor2 = Investor(name: "Sarah")

        stockPrice.addObserver(observer: investor1)
        stockPrice.addObserver(observer: investor2)

        stockPrice.price = 100.0 // "John received a notification: the stock price is now 100.0" "Sarah received a notification: the stock price is now 100.0"

        stockPrice.removeObserver(observer: investor2)

        stockPrice.price = 110.0 // "John received a notification: the stock price is now 110.0"
    }
    
    func exampleKVO() {
        observation = objectToObserve.observe(\.myProperty) { object, change in
            print("myProperty changed to \(object.myProperty)")
        }
        
        objectToObserve.myProperty = 10
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

protocol Subscriber {
    func handleMessage(message: String)
}

class ObserverUser: Subscriber {
    
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getName() -> String {
        return name
    }
    
    func handleMessage(message: String) {
        print("handleName\(name): message: \(message)")
    }
}

class ObserverChatServer {
    
    private var subscribers = [String: [Subscriber]]()
    
    func register(subject: String, subscriber: Subscriber) {
        if subscribers.keys.filter({ $0 == subject }).first != nil {
            subscribers[subject]?.append(subscriber)
        } else {
            subscribers[subject] = [subscriber]
        }
    }
    
    func unregister(subject: String, subscriber: Subscriber) {
        if subscribers.keys.filter({ $0 == subject }).first != nil {
            subscribers.removeValue(forKey: subject)
        }
    }
    
    func sendMessage(user: ObserverUser, subject: String, message: String) {
        if subscribers.keys.filter({ $0 == subject }).first != nil {
            let userMessage = "\(user.getName()): \(message)"
            self.subscribers[subject]?.forEach {
                $0.handleMessage(message: userMessage)
            }
        }
    }
}

//MARK: - 주식 가격 알림
// 주식 가격을 표현하는 클래스
class StockPrice {
    var price: Double = 0.0 {
        didSet {
            // 가격이 변동되면 알림을 보냅니다.
            notifyObservers()
        }
    }
    
    // 옵저버들을 저장할 배열
    private var observers = [Investor]()
    
    // 옵저버를 추가하는 메서드
    func addObserver(observer: Investor) {
        observers.append(observer)
    }
    
    // 옵저버를 제거하는 메서드
    func removeObserver(observer: Investor) {
        observers = observers.filter { $0 !== observer }
    }
    
    // 옵저버들에게 알림을 보내는 메서드
    private func notifyObservers() {
        for observer in observers {
            observer.update(price: price)
        }
    }
}

// 주식 가격 변동에 대한 알림을 받는 클래스
class Investor {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func update(price: Double) {
        print("\(name) received a notification: the stock price is now \(price)")
    }
}

// MARK: - KVO

class MyClass: NSObject {
    @objc dynamic var myProperty: Int = 0
}


