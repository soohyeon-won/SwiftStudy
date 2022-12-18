//
//  FactoryMethod.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2022/12/10.
//

import Foundation

/**
 팩토리 메소드 패턴
 구체적으로 어떤 인스턴스를 만들지는 서브 클래스가 정한다.
 - 다양한 구현체(Product)가 있고 , 그 중에서 특정한 구현체를 만들 수 있는 다양한 팩토리(Creator)를 제공할 수 있다.
 */

// MARK: - protocol
protocol Ship {
    var name: String { get set }
    var color: String { get set }
    
    func prepareFor(name: String)
}

protocol ShipFactory {
    func ordershiip(name: String, email: String) -> Ship
    
    func createShip() -> Ship
    func validate(name: String, email: String)
    func sendEmailTo(email: String, ship: Ship)
}

extension ShipFactory {
    
    func ordershiip(name: String, email: String) -> Ship {
        validate(name: name, email: email)
        let ship = createShip()
        ship.prepareFor(name: name)
        sendEmailTo(email: email, ship: ship)
        return ship
    }
    
    func validate(name: String, email: String) {
        if name.isEmpty {
            fatalError("배 이름 지어주세요.")
        }
        if email.isEmpty {
            fatalError("연락처를 남겨주세요.")
        }
    }
}

// MARK: - instance

final class Whiteship: Ship {
    var color: String
    var name: String
    
    init() {
        self.color = "white"
        self.name = ""
    }
    
    func prepareFor(name: String) {
        self.name = name
    }
}

final class WhiteshipFactory: ShipFactory {
    
    func sendEmailTo(email: String, ship: Ship) {
        print("ship: \(ship.name) 생성이 완료되었습니다. To: \(email)")
    }
    
    func createShip() -> Ship {
        return Whiteship()
    }
}
