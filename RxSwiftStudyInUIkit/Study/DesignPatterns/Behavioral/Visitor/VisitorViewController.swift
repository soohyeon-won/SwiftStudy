//
//  VisitorViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class VisitorViewController: UIViewController {
    
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
        [ 비지터 패턴 ]
        - 기존코드를 변경하지 않고 새로운 기능을 추가하는 방법
        - 더블 디스패치(Double Dispatch)를 활용할 수 있다.
        - 비지터는 추가하고싶은 로직을 담고있는곳
        - element는 accept함수가 있음 element는 변하지 않는, 본연의 기능만을 가진 클래스
        - 딱 하나만 추가해야함 > accept(Visitor) // method overloading: 이름은 같지만 파라미터가 다름
        
        [장점]
        
        [단점]
        
        [사용 예제]
        """
        
        client()
    }
    
    private func client() {
        let recctangle: ShapeProtocol = Rectangle()
        recctangle.printTo(device: Phone())
    }
}
