//
//  OpaqueTypeStudy.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 12/27/23.
//

import Foundation

protocol OpaqueShape {
    func area() -> Double
}

struct OpaqueRectangle: OpaqueShape {
    var width: Double
    var height: Double
    
    func area() -> Double {
        return width * height
    }
}

struct OpaqueCircle: OpaqueShape {
    var radius: Double
    
    func area() -> Double {
        return Double.pi * radius * radius
    }
}

/// Protocol 이용
func randomShape(isCircle: Bool) -> OpaqueShape {
    if isCircle {
        return OpaqueCircle(radius: 5.0)
    } else {
        return OpaqueRectangle(width: 3.0, height: 4.0)
    }
}

/// OpaqueType 이용
/// 동일한 프로토콜을 따르는 구현체를 반환하면서도, 호출자에게는 실제 반환되는 타입을 숨기는 효과를
func opqaueCircleRandomShape(isCircle: Bool) -> some OpaqueShape {
    if isCircle {
        return OpaqueCircle(radius: 5.0) // 실제 구현체를 리턴 (1.실제타입)
    } else {
        return OpaqueCircle(radius: 4.0)
        /// 해당 프로토콜 타입을 반환하면서도 타입에 대한 정체성을 보장! (2. 동일 타입)
//        return OpaqueRectangle(width: 3.0, height: 4.0) // 컴파일 에러
    }
}

/// Useage
let shape: some OpaqueShape = opqaueCircleRandomShape(isCircle: true)
