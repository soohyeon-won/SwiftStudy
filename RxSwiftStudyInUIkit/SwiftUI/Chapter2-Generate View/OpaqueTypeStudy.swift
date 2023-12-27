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
/// some 키워드는 프로퍼티와 첨자, 함수 반환타입에 적용 가능
/// some 다음에 올 수 있는 타입은 protocol, class, Any, AnyObject로 한정
func randomShape(isCircle: Bool) -> some OpaqueShape {
    if isCircle {
        return OpaqueCircle(radius: 5.0)
    } else {
        return OpaqueCircle(radius: 4.0)
        /// 해당 프로토콜 타입을 반환하면서도 탙입에 대한 정체성을 보장!
//        return OpaqueRectangle(width: 3.0, height: 4.0) // 컴파일 에러
    }
}
