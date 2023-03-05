//
//  MediatorViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class MediatorViewController: UIViewController {
    
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
        [ 중재자 패턴 ]
        여러 객체들이 소통하는 방법을 캡슐화하는 패턴
        - 여러 컴포넌트간의 결합도를 중재자를 통해 낮출 수 있다.
        
        [구조도]
        Mediator(interface) <- Colleague
        ↑                       ↑    ↑
        ConcreateMediator ColleagueA ColleagueB
        
        Colleague가 Colleagu를 참조하지는 않는다.
        무조건 구조도를 맞추어서 사용하라는 법칙은 없음
        모든 Colleague가 공통의 Interface를 상속받지 않을 수 있고 기타 등등
        다른 방식으로 만들 수 있음.
        
        - 실생활 예시
        아파트 민원 > 관리실 > 주민들에게 공지
        A비행기 > 관제탑 > B비행기
        
        [장점]
        1. 컴포넌트 코드를 변경하지않고 새로운 중재자를 만들어 사용할 수 있다. // Mediator Interface를 생성하여 쓰면됨
        2. 각각의 Colleague(컴포넌트) 코드가 간단해진다.
        의존성이 중재자에 모여있기 때문에 중재자에서 제공하는 함수만 신경쓰면 됨
        
        [단점]
        1. 의존성이 한 곳으로 집중됨
        중재자 역할을 하는 클래스의 복잡도와 결합도가 증가한다.
        
        [사용 예제]
        before예제 코드에서는 Guest가 cleaningService를 직접 호출하고 있음
        frontDesk(중재자)에 의존을 모아서 사용
        
        1. Java - ExcutorService, Executor
        2. Spring - DispatcherServlet
        DispatcherServlet(중재자) 클래스가 여러 컴포넌트들의 인터페이스를 갖고 있음
        
        [추가 의견]
        Delegate패턴은 OOP에서 자주 사용하는 방법중 하나로 객체 간의 상호작용을 구현하는 데 사용
        Delegate 패턴은 하나의 객체가 다른 객체를 대신해서 일부 기능을 수행하는 방식
        
        중재자 패턴은 객체들 사이의 복잡한 상호작용을 처리
        중재자는 객체들 사이에서 상호작용을 조정하고 중개하는 역할을 수행
        """
        
        client()
    }
    
    private func client() {
        let mediator = ConcreteMediator()

        let colleague1 = ConcreteColleague(mediator: mediator, name: "Colleague 1")
        let colleague2 = ConcreteColleague(mediator: mediator, name: "Colleague 2")

        mediator.addColleague(colleague: colleague1)
        mediator.addColleague(colleague: colleague2)

        colleague1.send(message: "Hello, colleague 2!")
        colleague2.send(message: "Hi, colleague 1!")
    }
}

final class CleaningService {
    
    let frontDesk = FrontDesk()
    
//    func getTower(guest: Guest, numberOfTower: Int) {
//        print("numberOfTower: \(numberOfTower) towers to \(guest)")
//    }
    // Guest => Int Guest에 대한 의존성이 사라짐
    func getTower(guestID: Int, numberOfTower: Int) {
        let roomNumber = frontDesk.getRoomNumberFor(guestID: guestID)
        print("numberOfTower: \(numberOfTower) towers to \(guestID) provider roomNumber: \(roomNumber)")
    }
}


// Mediator 역할 : 각 객체들의 의존성을 모아놓음
class FrontDesk {
    
    let cleanService = CleaningService()
    let restaurant = Restaurant()
    
    func getTower(guest: Guest, numberOfTower: Int) {
        cleanService.getTower(guestID: guest.getID(), numberOfTower: numberOfTower)
    }
    
    func getRoomNumberFor(guestID: Int) -> String {
        return "111"
    }
    
    func dinner(guest: Guest, date: Date) {
        restaurant.dinner(guestID: guest.getID(), date: date)
    }
}

// Colleague
final class Guest {
    
    let frontDesk = FrontDesk()
    private var id: Int = 0
    
    func geTower(numberOfTower: Int) {
        frontDesk.getTower(guest: self, numberOfTower: numberOfTower)
    }
    
    func getID() -> Int {
        return id
    }
}

// Colleague
class Restaurant {
    func dinner(guestID: Int, date: Date) {
        print("restaurant dinner")
    }
}

//MARK: - before
/**

 class Guest {
     let cleanService = CleaningService()
     let restaurant = Restaurant()
     
     func dinner() {
         restaurant.dinner()
     }
     
     func geTower(numberOfTower: Int) {
         cleanService.getTower(guest: self, numberOfTower: numberOfTower)
     }
 }

 */


// 중재자 프로토콜
protocol Mediator {
    func sendMessage(message: String, sender: Colleague)
}

// 동료 프로토콜
protocol Colleague {
    var mediator: Mediator? { get set }
    func send(message: String)
    func receive(message: String)
}

// 실제 동료 클래스
class ConcreteColleague: Colleague {

    var mediator: Mediator?
    var name: String
    
    init(mediator: Mediator, name: String) {
        self.mediator = mediator
        self.name = name
    }
    
    func send(message: String) {
        mediator?.sendMessage(message: message, sender: self)
    }
    
    func receive(message: String) {
        print("\(name) received: \(message)")
    }
}

// 중재자 클래스
class ConcreteMediator: Mediator {
    var colleagues: [Colleague] = []
    
    func addColleague(colleague: Colleague) {
        colleagues.append(colleague)
    }
    
    func sendMessage(message: String, sender: Colleague) {
        for colleague in colleagues {
            if let colleague = colleague as? ConcreteColleague, colleague !== sender as? ConcreteColleague {
                colleague.receive(message: message)
            }
        }
    }
}
