//
//  AbstractFactory.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/12/26.
//

import Foundation

protocol ShipPartsFactory {
    
    func createAnchor() -> Anchor
    func createWheel() -> Wheel
}

protocol Anchor {
    
}

protocol Wheel {
    
}

// MARK: - Instance

struct WhiteAnchor: Anchor {
    
}

struct WhiteWheel: Wheel {
    
}

struct BlackAnchor: Anchor {
    
}

struct BlackWheel: Wheel {
    
}

final class WhiteshipPartsFactory: ShipPartsFactory {
    func createAnchor() -> Anchor {
        print("white anchor 추가")
        return WhiteAnchor()
    }
    
    func createWheel() -> Wheel {
        print("white wheel 추가")
        return WhiteWheel()
    }
}

final class BlackhipPartsFactory: ShipPartsFactory {
    func createAnchor() -> Anchor {
        BlackAnchor()
    }
    
    func createWheel() -> Wheel {
        BlackWheel()
    }
}
