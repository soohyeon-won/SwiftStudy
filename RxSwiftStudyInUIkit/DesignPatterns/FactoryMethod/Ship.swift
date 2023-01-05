//
//  Ship.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2023/01/04.
//

import Foundation

// MARK: - protocol
protocol Ship {
    var name: String { get set }
    var color: String { get set }
    var anchor: Anchor? { get set }
    var wheel: Wheel? { get set }
    
    mutating func prepareFor(name: String)
    
    mutating func setAnchor(anchor: Anchor)
    mutating func setWheel(wheel: Wheel)
}

extension Ship {
    mutating func prepareFor(name: String) {
        self.name = name
    }
    mutating func setAnchor(anchor: Anchor) {
        self.anchor = anchor
    }
    mutating func setWheel(wheel: Wheel) {
        self.wheel = wheel
    }
}

// MARK: - instance White

final class Whiteship: Ship {
    
    var color: String
    var name: String
    var anchor: Anchor?
    var wheel: Wheel?
    
    init() {
        self.color = "white"
        self.name = ""
        self.anchor = nil
        self.wheel = nil
    }
}

// MARK: - instance Black

final class Blackship: Ship {
    var name: String
    var color: String
    var anchor: Anchor?
    var wheel: Wheel?
    
    init() {
        self.color = "white"
        self.name = ""
        self.anchor = nil
        self.wheel = nil
    }
}
