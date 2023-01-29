//
//  AdapterViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/01/24.
//

import UIKit

final class AdapterViewController: UIViewController {
    
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
        [ 어댑터 패턴 ]
        일상생활에서 찾아볼 수 있는 어댑터의 형태 : 110v -> 220v 콘센트 변환해주는 어댑터
        
        [ 소프트웨어적인 접근 ]
        클라이언트에서 사용하는 인터페이스가 전혀 다른 경우
        기존 코드를 클라이언트가 사용하는 인터페이스의 구현체로 바꿔주는 패턴
        
        [ 구현방법 ]
        1. 기존 코드를 수정할 수 없는 경우 -> 별도의 어댑터 코드를 만들어 사용
        2. 기존 코드 수정 O -> 클래스 내부에서 필요한 인스턴스를 리턴해주는 방법 사용
        - 별도의 클래스를 사용X, 복잡도를 줄일 수 있다.
        - SPA(단일 책임 원칙)에서 보면 1번의 기법이 더 가까워질 수 있다.
        - 조금 더 실용적인 선택이라고 볼 수 있다.
        
        [장점]
        기존 코드를 변경하지 않고 원하는 인터페이스의 구현체를 만들어 재사용할 수 있다. // OCP(개방-폐쇄 원칙)
        기존 코드가 하던 일과 특정 인터페이스 구현체로 변환하는 작업을 각기 다른 클래스로 분리하여 관리할 수 있다. // SPA(단일 책임 원칙)
        
        [단점]
        새 클래스가 생겨 복잡도가 증가할 수 있다. 경우에 따라서는 기존코드가 해당 인터페이스를(target)구현하도록 수정하는 것이 좋은 선택일 수 있다.
        
        client - target(interface) - Adapter - Adaptee
        
        [ 실제 코드 사용사례 ]
        1. enumerated()
        2. "file.txt" -> file reader
        3. spring HandlerAdapter // network API -> return model&view
        """
        
        client()
    }
    
    private func client() {
        
    }
}

