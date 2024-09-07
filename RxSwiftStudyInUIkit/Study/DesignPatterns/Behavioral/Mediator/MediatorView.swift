//
//  MediatorViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import SwiftUI

struct MediatorView: View {
    
    private let textViewContent: String = """
        [ 중재자 패턴 ]
        여러 객체들이 소통하는 방법을 캡슐화하는 패턴
        - 여러 컴포넌트간의 결합도를 중재자를 통해 낮출 수 있다.
        
        [언제 사용하는게 좋을까?]
        1. 다수의 객체가 서로 의존성을 가지며 상호작용해야 할 때.
        2. 복잡한 의사소통이 필요한 여러 컴포넌트가 있을 때.
        3. 상호작용을 관리하고, 의존성을 줄여야 하는 경우: 모든 객체가 서로 직접 통신하는 대신, 중재자를 통해 통신하면 객체 간의 결합도를 줄이고, 유지 보수성을 높일 수 있습니다.
        
        [구조도]
        Mediator(interface) <- Colleague
        ↑                       ↑    ↑
        ConcreateMediator ColleagueA ColleagueB
        
        Colleague가 Colleague를 참조하지는 않는다.
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
    
    var body: some View {
        VStack {
            ScrollView {
                Text(textViewContent)
                    .font(.system(size: 24))
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(8)
                
                CodeView(code: """
                // 중재자 프로토콜 정의
                protocol LandMediator {
                    func notify(sender: AnyObject, event: String)
                }

                // 중재자 클래스 구현
                class RealEstateMediator: LandMediator {
                    private var agents: [RealEstateAgent] = []
                    private var customers: [Customer] = []
                    
                    // 중개인 등록
                    func registerAgent(_ agent: RealEstateAgent) {
                        agents.append(agent)
                    }
                    
                    // 고객 등록
                    func registerCustomer(_ customer: Customer) {
                        customers.append(customer)
                    }
                    
                    // 특정 이벤트에 대한 알림 처리
                    func notify(sender: AnyObject, event: String) {
                        if let agent = sender as? RealEstateAgent {
                            print("중재자: 중개인 \\(agent.name)이 이벤트 '\\(event)'를 보냈습니다.")
                            for customer in customers {
                                customer.receiveNotification(event: event)
                            }
                        } else if let customer = sender as? Customer {
                            print("중재자: 고객 \\(customer.name)이 이벤트 '\\(event)'를 보냈습니다.")
                            for agent in agents {
                                agent.receiveInquiry(event: event)
                            }
                        }
                    }
                }

                // 중개인 클래스 정의
                class RealEstateAgent {
                    let name: String
                    private var mediator: LandMediator
                    
                    init(name: String, mediator: LandMediator) {
                        self.name = name
                        self.mediator = mediator
                    }
                    
                    func sendNotification(property: String) {
                        print("중개인 \\(name): 새로운 부동산 등록: \\(property)")
                        mediator.notify(sender: self, event: "새로운 부동산: \\(property)")
                    }
                    
                    func receiveInquiry(event: String) {
                        print("중개인 \\(name): 고객의 문의를 받았습니다 - \\(event)")
                    }
                }

                // 고객 클래스 정의
                class Customer {
                    let name: String
                    private var mediator: LandMediator
                    
                    init(name: String, mediator: LandMediator) {
                        self.name = name
                        self.mediator = mediator
                    }
                    
                    func sendInquiry(property: String) {
                        print("고객 \\(name): 부동산에 문의를 보냅니다: \\(property)")
                        mediator.notify(sender: self, event: "문의: \\(property)")
                    }
                    
                    func receiveNotification(event: String) {
                        print("고객 \\(name): 알림을 받았습니다 - \\(event)")
                    }
                }
                
                // 실제 사용 예시
                let mediator = RealEstateMediator()

                let agent1 = RealEstateAgent(name: "John", mediator: mediator)
                let agent2 = RealEstateAgent(name: "Emily", mediator: mediator)

                let customer1 = Customer(name: "Alice", mediator: mediator)
                let customer2 = Customer(name: "Bob", mediator: mediator)

                // 중개인과 고객을 중재자에 등록
                mediator.registerAgent(agent1)
                mediator.registerAgent(agent2)
                mediator.registerCustomer(customer1)
                mediator.registerCustomer(customer2)

                // 중개인이 부동산을 등록하면, 고객에게 알림을 보냄
                agent1.sendNotification(property: "서울 아파트")

                // 고객이 부동산에 문의하면, 중개인에게 전달
                customer1.sendInquiry(property: "서울 아파트")
                """)
            }
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .onAppear {
                client()
            }
        }
    }
    
    private func client() {
        let mediator = ConcreteMediator()

        let colleague1 = ConcreteColleague(mediator: mediator, name: "Colleague 1")
        let colleague2 = ConcreteColleague(mediator: mediator, name: "Colleague 2")

        mediator.addColleague(colleague: colleague1)
        mediator.addColleague(colleague: colleague2)

        colleague1.send(message: "Hello, colleague 2!")
        colleague2.send(message: "Hi, colleague 1!")
        
        // 실제 사용 예시
        let landMediator = RealEstateMediator()

        let agent1 = RealEstateAgent(name: "John", mediator: landMediator)
        let agent2 = RealEstateAgent(name: "Emily", mediator: landMediator)

        let customer1 = Customer(name: "Alice", mediator: landMediator)
        let customer2 = Customer(name: "Bob", mediator: landMediator)

        // 중개인과 고객을 중재자에 등록
        landMediator.registerAgent(agent1)
        landMediator.registerAgent(agent2)
        landMediator.registerCustomer(customer1)
        landMediator.registerCustomer(customer2)

        // 중개인이 부동산을 등록하면, 고객에게 알림을 보냄
        agent1.sendNotification(property: "서울 아파트")

        // 고객이 부동산에 문의하면, 중개인에게 전달
        customer1.sendInquiry(property: "서울 아파트")
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

// 중재자 프로토콜 정의
protocol LandMediator {
    func notify(sender: AnyObject, event: String)
}

// 중재자 클래스 구현
class RealEstateMediator: LandMediator {
    private var agents: [RealEstateAgent] = []
    private var customers: [Customer] = []
    
    // 중개인 등록
    func registerAgent(_ agent: RealEstateAgent) {
        agents.append(agent)
    }
    
    // 고객 등록
    func registerCustomer(_ customer: Customer) {
        customers.append(customer)
    }
    
    // 특정 이벤트에 대한 알림 처리
    func notify(sender: AnyObject, event: String) {
        if let agent = sender as? RealEstateAgent {
            print("중재자: 중개인 \(agent.name)이 이벤트 '\(event)'를 보냈습니다.")
            for customer in customers {
                customer.receiveNotification(event: event)
            }
        } else if let customer = sender as? Customer {
            print("중재자: 고객 \(customer.name)이 이벤트 '\(event)'를 보냈습니다.")
            for agent in agents {
                agent.receiveInquiry(event: event)
            }
        }
    }
}

// 중개인 클래스 정의
class RealEstateAgent {
    let name: String
    private var mediator: LandMediator
    
    init(name: String, mediator: LandMediator) {
        self.name = name
        self.mediator = mediator
    }
    
    func sendNotification(property: String) {
        print("중개인 \(name): 새로운 부동산 등록: \(property)")
        mediator.notify(sender: self, event: "새로운 부동산: \(property)")
    }
    
    func receiveInquiry(event: String) {
        print("중개인 \(name): 고객의 문의를 받았습니다 - \(event)")
    }
}

// 고객 클래스 정의
class Customer {
    let name: String
    private var mediator: LandMediator
    
    init(name: String, mediator: LandMediator) {
        self.name = name
        self.mediator = mediator
    }
    
    func sendInquiry(property: String) {
        print("고객 \(name): 부동산에 문의를 보냅니다: \(property)")
        mediator.notify(sender: self, event: "문의: \(property)")
    }
    
    func receiveNotification(event: String) {
        print("고객 \(name): 알림을 받았습니다 - \(event)")
    }
}
