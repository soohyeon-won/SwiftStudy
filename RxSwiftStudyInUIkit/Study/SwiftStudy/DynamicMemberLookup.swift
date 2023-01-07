//
//  DynamicMemberLookup.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/01/07.
//

import Foundation

@dynamicMemberLookup
struct Person {
    var dic = [String:String]()
    
    subscript(dynamicMember key: String) -> String? {
        return self.dic[key]
    }
    
    func test() {
        var person = Person()
        person.dic = ["test": "a"]
        print(person.test)
    }
}
