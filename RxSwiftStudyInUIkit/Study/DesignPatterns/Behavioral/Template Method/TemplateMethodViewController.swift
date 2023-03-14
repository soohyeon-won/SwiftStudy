//
//  TemplateMethodViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class TemplateMethodViewController: UIViewController {
    
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
        [ 템플릿 메소드 패턴 ]
        - 알고리듬의 구조를 템플릿으로 제공
        - 그 중 구체적인 방법 - 처리, 출력 subClass가 이를 상속받아 구체적으로 구현할 수 있게끔 만든다.
        처음에 파일에서 데이터를 읽고 > 처리 > 출력 : 알고리듬
        - 해당 패턴은 상속을 사용한다.
        · 알고리듬 구조를 서브 클래스가 확장할 수 있도록 템플릿으로 제공하는 방법.
        · 추상 클래스는 템플릿을 제공하고 하위 클래스는 구체적인 알고리듬을 제공한다.
        
        [장점]
        
        [단점]
        
        [사용 예제]
        
        [기타 의견]
        
        [추가 개념]
        · 제어의 역전(Inversion of Control, IoC)
        프로그램의 "제어 흐름을 직접 제어하는 것"이 아니라, 외부에서 관리하는 것을 제어의 역전(IoC)라고 한다.
        
        · Dependency Inversion Principle (DIP)
        고차원 모듈은 저차원 모듈에 의존하면 안된다. 이 모듈 모두 다른 추상화된 것에 의존해야 한다.
        추상화 된 것은 구체적인 것에 의존하면 안 된다. 구체적인 것이 추상화된 것에 의존해야 한다.'
        """
        
        client()
    }
    
    private func client() {
        
    }
}
