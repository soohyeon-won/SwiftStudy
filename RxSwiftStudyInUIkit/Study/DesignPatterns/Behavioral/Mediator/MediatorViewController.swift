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
        
        [단점]
        
        [사용 예제]
        before예제 코드에서는 Guest가 cleaningService를 직접 호출하고 있음
        
        """
        
        client()
    }
    
    private func client() {
        
    }
}

final class CleaningService {
    
    let frontDesk = FrontDesk()
    
    func clean(gym: Gym) {
        print("clean up gym: \(gym)")
    }
    
//    func getTower(guest: Guest, numberOfTower: Int) {
//        print("numberOfTower: \(numberOfTower) towers to \(guest)")
//    }
    // Guest => Int Guest에 대한 의존성이 사라짐
    func getTower(guestID: Int, numberOfTower: Int) {
        let roomNumber = frontDesk.getRoomNumberFor(guestID: guestID)
        print("numberOfTower: \(numberOfTower) towers to \(guestID) provider roomNumber: \(roomNumber)")
    }
    
    func clean(restaurant: Restaurant) {
        print("clean up restaurant: \(restaurant)")
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
final class Gym {
    
}

// Colleague
class Restaurant {
    func dinner(guestID: Int, date: Date) {
        print("restaurant dinner")
    }
}

//MARK: - before
/**
 class Gym {
     
 }

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
