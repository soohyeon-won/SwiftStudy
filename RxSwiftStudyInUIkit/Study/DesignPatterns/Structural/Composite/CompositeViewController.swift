//
//  CompositeViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/11.
//

import SwiftUI

struct CompositeView: View {
    
    private let textViewContent: String = """
        [ 컴포짓 패턴 ]
        클라이언트 입장에서는 '전체'나 '부분'이나 모두 동일한 컴포넌트로 인식할 수 있는 계층 구조를 만든다 (Part-Whole Hierachy)
        leef -> primitive(이용가능한 가장 단순한 요소)
        그룹을 표현
        트리구조와 연관.
        
        [장점]
        1. 복잡한 트리 구조를 편리하게 사용할 수 있다.
        2. 다형성과 재귀를 활용할 수 있다.
        3. 클라이언트 코드를 변경하지 않고 새로운 엘리먼트 타입을 추가할 수 있다.
        
        [단점]
        트리를 만들어야 하기 때문에(공통된 인터페이스를 정의해야 하기 때문에) 지나친 일반화를 해야하는 경우도 생길 수 있다.
        공통점을 억지로 찾아서 적용한다거나...
        잘못만들면 런타임시에 타입을 체크해야하는 경우도 생김
        그때는 내가 너무 디자인패턴에 종속된 코드를 작성하는건 아닐까? 하는 의심을 해보면좋음, 다른 시각으로 바라보아야함
        
        UIView를 상속받아서
        Button, tableView 등을 add하고 화면에 나타내주는 (예제의 getPrice()처럼 .visible() 함수를 호출하는 관점으로 바라보면 이해가 쉬움) 부분들도 컴포짓 패턴을 사용했다고 볼 수 있다.
        """
    
    var body: some View {
        VStack {
            ScrollView {
                Text(textViewContent)
                    .font(.system(size: 24))
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(8)
                
                CodeView(code: """
                let rootFolder = Folder(name: "root")
                let documentsFolder = Folder(name: "Documents")
                let picturesFolder = Folder(name: "Pictures")

                let file1 = File(name: "Resume.pdf")
                let file2 = File(name: "Photo.png")
                let file3 = File(name: "Vacation.jpg")

                documentsFolder.add(component: file1)
                picturesFolder.add(component: file2)
                picturesFolder.add(component: file3)

                rootFolder.add(component: documentsFolder)
                rootFolder.add(component: picturesFolder)

                // 전체 파일 시스템 구조 출력
                rootFolder.display(indentation: "")
                
                // 출력
                // + root
                //  + Documents
                //   - Resume.pdf
                //  + Pictures
                //   - Photo.png
                //   - Vacation.jpg
                """)
            }
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .onAppear {
                client()
            }
        }
    }
    
    private func client() {
        // 1
        let item = Item(price: 10)
        let item2 = Item(price: 20)
        
        let bag = Bag()
        bag.add(component: item)
        bag.add(component: item2)
        
        printPrice(component: bag)
        printPrice(component: item)
        
        let bag2 = Bag()
        bag2.add(component: bag)
        bag2.add(component: bag)
        printPrice(component: bag2)
        
        // 2
        let rootFolder = Folder(name: "root")
        let documentsFolder = Folder(name: "Documents")
        let picturesFolder = Folder(name: "Pictures")

        let file1 = File(name: "Resume.pdf")
        let file2 = File(name: "Photo.png")
        let file3 = File(name: "Vacation.jpg")

        documentsFolder.add(component: file1)
        picturesFolder.add(component: file2)
        picturesFolder.add(component: file3)

        rootFolder.add(component: documentsFolder)
        rootFolder.add(component: picturesFolder)

        // 전체 파일 시스템 구조 출력
        rootFolder.display(indentation: "")
    }
    
    // OCP
    func printPrice(component: Component) {
        print("price: \(component.getPrice())")
    }
}

// MARK: - 예시1. 기본 예제 (가격 합)

protocol Component {
    func getPrice() -> Int
}

class Item: Component { // leef
    
    var price: Int
    
    init(price: Int) {
        self.price = price
    }
    
    func getPrice() -> Int {
        return price
    }
}

class Bag: Component {
    
    var list: [Component] = [Component]()
    
    func add(component: Component) {
        list.append(component)
    }
    
    func getPrice() -> Int {
        return list.map { $0.getPrice() }.reduce(0, +)
    }
    
}

// MARK: - 예시2. 파일 시스템

protocol FileSystemComponent {
    var name: String { get }
    func display(indentation: String)
}

class File: FileSystemComponent {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func display(indentation: String) {
        print("\(indentation)- \(name)")
    }
}

class Folder: FileSystemComponent {
    let name: String
    private var components: [FileSystemComponent] = []
    
    init(name: String) {
        self.name = name
    }
    
    func add(component: FileSystemComponent) {
        components.append(component)
    }
    
    func remove(component: FileSystemComponent) {
        components.removeAll { $0.name == component.name }
    }
    
    func display(indentation: String) {
        print("\(indentation)+ \(name)")
        components.forEach { $0.display(indentation: indentation + "  ") }
    }
}
