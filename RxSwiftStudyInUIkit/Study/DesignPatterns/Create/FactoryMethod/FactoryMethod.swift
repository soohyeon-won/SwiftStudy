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

protocol ShipFactory {
    func ordershiip(name: String, email: String) -> Ship
    
    func createShip() -> Ship
    func validate(name: String, email: String)
    func sendEmailTo(email: String, ship: Ship)
}

extension ShipFactory {
    
    func ordershiip(name: String, email: String) -> Ship {
        validate(name: name, email: email)
        var ship = createShip()
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
    
    func sendEmailTo(email: String, ship: Ship) {
        print("ship: \(ship.name) 생성이 완료되었습니다. To: \(email)")
    }
}


final class WhiteshipFactory: ShipFactory {
    
    func createShip() -> Ship {
        return Whiteship()
    }
}

final class WhiteshipFactory2: ShipFactory {
    
    private var shipPartsFactory: ShipPartsFactory
    
    init(shipPartsFactory: ShipPartsFactory) {
        self.shipPartsFactory = shipPartsFactory
    }
    
    func createShip() -> Ship {
        var whiteShip = Whiteship()
        // 직접 객체를 인스턴스화해서 넣는것이 아니라
        // 추상화된 인스턴스를 받아서 인스턴스를 주입해준다
        // ShipFactory 는 변형없이 사용가능함.
        // Open/Closed Principle (OCP) 개방 폐쇄 원칙 
        whiteShip.setAnchor(anchor: shipPartsFactory.createAnchor())
        whiteShip.setWheel(wheel: shipPartsFactory.createWheel())
        return whiteShip
    }
}


final class BlackshipFactory: ShipFactory {
    
    func createShip() -> Ship {
        return Blackship()
    }
}

