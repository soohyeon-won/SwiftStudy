//
//  TemplateCallbackSkeleton.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/03/18.
//

import Foundation

class TemplateCallbackSkeleton {
    // Template method
    func execute(completion: () -> Void) {
        step1()
        step2()
        completion()
    }
    
    // Abstract methods to be implemented by subclasses
    func step1() {
        fatalError("Subclasses must implement step1()")
    }
    
    func step2() {
        fatalError("Subclasses must implement step2()")
    }
}

class TemplateCallbackSkeletonA: TemplateCallbackSkeleton {
    override func step1() {
        print("ConcreteAlgorithmA: Step 1")
    }
    
    override func step2() {
        print("ConcreteAlgorithmA: Step 2")
    }
}

class TemplateCallbackSkeletonB: TemplateCallbackSkeleton {
    override func step1() {
        print("ConcreteAlgorithmB: Step 1")
    }
    
    override func step2() {
        print("ConcreteAlgorithmB: Step 2")
    }
}
