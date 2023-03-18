//
//  TemplateMethodSkeleton.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/03/18.
//

class TemplateMethodSkeleton {
    // Template method
    func execute() {
        step1()
        step2()
        step3()
    }
    
    // Abstract methods to be implemented by subclasses
    func step1() {
        fatalError("Subclasses must implement step1()")
    }
    
    func step2() {
        fatalError("Subclasses must implement step2()")
    }
    
    func step3() {
        fatalError("Subclasses must implement step3()")
    }
}

class ConcreteAlgorithmA: TemplateMethodSkeleton {
    override func step1() {
        print("ConcreteAlgorithmA: Step 1")
    }
    
    override func step2() {
        print("ConcreteAlgorithmA: Step 2")
    }
    
    override func step3() {
        print("ConcreteAlgorithmA: Step 3")
    }
}

class ConcreteAlgorithmB: TemplateMethodSkeleton {
    override func step1() {
        print("ConcreteAlgorithmB: Step 1")
    }
    
    override func step2() {
        print("ConcreteAlgorithmB: Step 2")
    }
    
    override func step3() {
        print("ConcreteAlgorithmB: Step 3")
    }
}
