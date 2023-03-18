//
//  After_VisitorExample.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/03/18.
//

import Foundation

// errorExample에서 사용
//protocol ShapeProtocol {
//
//    func printTo(device: Phone)
//    func printTo(device: Watch)
//}

// MARK: - Element
protocol ShapeProtocol {
    
    func accept(device: Device)
}

// Concrete Element1
class Rectangle: ShapeProtocol {
    
    func accept(device: Device) {
        device.printTo(device: self)
    }
}

// Concrete Element2
class Triangle: ShapeProtocol {
    
    func accept(device: Device) {
        device.printTo(device: self)
    }
}

// MARK: - Visitor
protocol Device {
    
    func printTo(device: Rectangle)
    func printTo(device: Triangle)
}

// Concrete Visitor1
class Phone: Device {
    
    func printTo(device: Rectangle) {
        print("Rectangle device Phone")
    }
    func printTo(device: Triangle) {
        print("Triangle device Phone")
    }
}

// Concrete Visitor2
class Watch: Device {
    
    func printTo(device: Rectangle) {
        print("Rectangle device Watch")
    }
    func printTo(device: Triangle) {
        print("Triangle device Watch")
    }
}
