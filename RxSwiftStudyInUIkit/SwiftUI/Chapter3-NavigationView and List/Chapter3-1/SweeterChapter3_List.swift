//
//  SweeterChapter3_List.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 1/1/24.
//

import SwiftUI

struct SweeterChapter3_List: View {
    var body: some View {
        /// 1. Range<Int>
        List(0..<3) {
            Text("\($0)")
        }
        
        /// 2. RandomAccessCollection
        // 2-1. id 식별자 지정
        List(["A", "B", "C"], id: \.self) {
            Text("\($0)")
        }
        
        // 2-2. Hashable protocol 채택
        let hashLsit = [HashableAnimal(name: "hash cat"), HashableAnimal(name: "hash dog")]
        List(hashLsit, id: \.self) {
            Text("\($0.name)")
        }
        
        // 2-2. identifiable protocol 채택
        let idLsit = [IdentifiableAnimal(name: "id cat"), IdentifiableAnimal(name: "id dog")]
        List(idLsit) {
            Text("\($0.name)")
        }
        
        /// 정적 콘텐츠와 동적 콘텐츠 조합
        List {
            Text("Hashable 사용").font(.largeTitle) // 하나의 로우를 차지하는 정적 뷰
            ForEach(hashLsit, id: \.self) { // 동적 뷰 생성
                Text("\($0.name)")
            }
            
            Text("identifiable 사용").font(.largeTitle)
            ForEach(idLsit) {
                Text("\($0.name)")
            }
        }
    }
}

struct HashableAnimal: Hashable {
//    var id: ObjectIdentifier
    let id = UUID()
    let name: String
}

struct IdentifiableAnimal: Identifiable {
//    var id: ObjectIdentifier
    let id = UUID()
    let name: String
}

#Preview {
    SweeterChapter3_List()
}
