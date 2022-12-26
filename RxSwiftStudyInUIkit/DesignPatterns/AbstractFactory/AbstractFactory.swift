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
        WhiteAnchor()
    }
    
    func createWheel() -> Wheel {
        WhiteWheel()
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
