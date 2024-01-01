//
//  SweeterChapter3_Section.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 1/1/24.
//

import SwiftUI

struct SweeterChapter3_Section: View {
    var body: some View {
        let titles = ["Animal", "Drinks"]
        let hashLsit = [HashableAnimal(name: "hash cat"), HashableAnimal(name: "hash dog")]
        let idLsit = [HashableAnimal(name: "id cat"), HashableAnimal(name: "id dog")]
        let data = [hashLsit, idLsit]
        
        return List {
            ForEach(0..<data.count, id: \.self) { index in
                Section(
                    header: Text(titles[index]),
                    footer: HStack { Spacer(); Text("\(data[index].count)")}
                ) {
                    ForEach(data[index], id: \.self) {
                        Text($0.name)
                    }
                }
            }
        }
        // 중복으로 있는 경우에 첫번째 것이 채택됨
//        .listStyle(.plain) // 섹션 영역 컬러가 없어짐, 푸터가 명확
//        .listStyle(.inset) // 섹션 영역 컬러가 없어짐, 푸터영역 작아짐
//        .listStyle(.insetGrouped)
        .listStyle(.grouped) // 영역이 확실하게 나뉘는걸 볼 수 있음
        
        /// [책]
        /// iPhone 11 pro > grouped
        /// iPhone 11 pro Max > insetGrouped
        /// 가로모드에서 디폴트로 채택됨
        /// Regular width환경에서 insetGrouped 스타일을 사용하기에 적합하다 라는 문장이 있음
        ///
        /// 실제로 실행해보면 다 insetGrouped로 나옴 (?)
    }
}

#Preview {
    SweeterChapter3_Section()
}
