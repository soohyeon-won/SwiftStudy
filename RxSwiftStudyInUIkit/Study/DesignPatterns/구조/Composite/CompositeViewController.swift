//
//  CompositeViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/11.
//

import UIKit

final class CompositeViewController: UIViewController {
    
    private let textView = UITextView().then {
        $0.isEditable = false
        $0.font = .systemFont(ofSize: 24)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(textView)
        
        textView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(24)
        }
        
        textView.text = """
        [ 컴포짓 패턴 ]
        클라이언트 입장에서는 '전체'나 '부분'이나 모두 동일한 컴포넌트로 인식할 수 있는 계층 구조를 만든다 (Part-Whole Hierachy)
        leef -> primitive(이용가능한 가장 단순한 요소)
        그룹을 표현
        트리구조와 연관.
        
        [장점]
        
        [단점]
        
        """
        
        client()
    }
    
    private func client() {
        let item = Item(price: 10)
        let item2 = Item(price: 20)
        
        let bag = Bag()
        
        bag.add(component: item)
        bag.add(component: item2)
        print("bag price: ", bag.getPrice())
        print("item price: ", item.getPrice())
        
        let bag2 = Bag()
        bag2.add(component: bag)
        bag2.add(component: bag)
        print("bag price: ", bag2.getPrice())
    }
}

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
