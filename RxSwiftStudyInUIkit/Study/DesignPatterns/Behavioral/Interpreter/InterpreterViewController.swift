//
//  InterpreterViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class InterpreterViewController: UIViewController {
    
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
        [ 인터프리터 패턴 ]
        - 컴퓨터 사이언스 내에서는 사람이 작성한 코드를 기계가 읽을 수 있도록 작동시켜주는 컴파일러 같은 것들 / 현실서는 통역자, 연주자 같은 경우를 예시로 볼 수 있다.
        - 정규표현식도 예제로 볼 수 있다.
        - 자주 등장하는 문제를 간다한 언어로 정의하고 재사용하는 패턴
        - 반복되는 문제 패턴을 언어 또는 문법으로 정의하고 확장할 수 있다.
        - 요청을 캡슐화 하여 호출자와 수신자를 분리하는 패턴
        
        [구조도]
        Context
        ↑
        Expression(Interface) <- TerminalExpression
                              <- NonTerminalExpression
        
        추상 구문 트리(abstract syntax tree, AST)
        
        [장점]
        - 자주 등장하는 문제 패턴을 언어와 문법으로 정의할 수 있다.
        - 기존 코드를 변경하지 않고 새로운 Expression을 추가할 수 있다.
        
        [단점]
        - 복잡한 문법을 표현하려면 Expression과 Parser가 복잡해진다.
        
        [사용 예제]
        """
        
        client()
    }
    
    private func client() {
        // 1 + 2 - 5 <- Infix
        // 1 2 5 + - <- postfix == 1-(2+5)
    }
}

final class PostfixNotation {
    
}
