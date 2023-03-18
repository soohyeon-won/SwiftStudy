//
//  CalaculatorProcessor.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/03/18.
//

import Foundation

class CalaculatorProcessor {
    
    final func process(a: Int, b: Int) {
        print("공통 이전 작업")
        
        let result = getResult(a: a, b: b)
        
        print("result: \(result)")
        print("공통 이후 작업")
    }
    
    func getResult(a: Int, b: Int) -> Int {
        return 0
    }
}

final class PlusCalaculatorProcessor: CalaculatorProcessor {
    
    override func getResult(a: Int, b: Int) -> Int {
        return a+b
    }
}

final class MultiplicationCalaculatorProcessor: CalaculatorProcessor {
    
    override func getResult(a: Int, b: Int) -> Int {
        return a*b
    }
}
