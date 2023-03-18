//
//  Before_VisitorExample.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/03/18.
//

import Foundation

protocol BeforeShapeProtocol {
    
    func printTo(device: BeforeDevice)
}

class BeforeRectangle: BeforeShapeProtocol {
    
    func printTo(device: BeforeDevice) {
        if let _ = device as? BeforeWatch {
            print("print rectangle to watch")
        } else if let _ = device as? BeforePhone {
            print("print rectangle to phone")
        }
    }
}

class BeforeTriangle: BeforeShapeProtocol {
    
    // 새로운 모양이 생길때마다 거대한 if-else문들을 계속 생성해나가야함
    // 디바이스가 추가되면 각 클래별로 if문을 추가해주어야함
    func printTo(device: BeforeDevice) {
        if let _ = device as? BeforeWatch {
            print("print Triangle to watch")
        } else if let _ = device as? BeforePhone {
            print("print Triangle to phone")
        }
    }
}


class BeforeDevice {
    
}

class BeforePhone: BeforeDevice {
    
}

class BeforeWatch: BeforeDevice {
    
}
