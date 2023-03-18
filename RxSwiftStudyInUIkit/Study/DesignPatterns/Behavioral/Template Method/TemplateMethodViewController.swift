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
        - 중간중간 조금만 다른경우 사용하기 좋은 패턴
        
        [장점]
        - 템플릿 코드를 재사용 > 중복 코드를 줄일 수 있다.
        - 템플릿 코드를 변경하지않고 상속을 받아서 구체적인 알고리즘만 변경할 수 있다.
        
        [단점]
        - 리스코프 치환 원칙을 위반할 수도 있다.
        // final로 막을 수 있지만, abstract func같은 경우는 상속받아 사용하기 때문에 리스코프 치환 원칙이 깨질 수 있음
        // 그러니까.. 상속이란것은 LSP를 어길 수 있다는 가능성이 항상 존재함
        - 알고리즘 구조가 복잡할 수록 템플릿을 유지하기 어려워진다.
        
        [사용 예제]
        1. 문서 생성기(Document Generator)
        문서 생성기는 다양한 형식의 문서를 생성할 수 있습니다.
        예를 들어, PDF, HTML, RTF 등의 형식으로 문서를 생성할 수 있습니다.
        이 때, 문서의 생성 과정은 대부분 동일하지만, 문서 형식에 따라 일부 단계가 달라집니다.
        이를 템플릿 메소드 패턴으로 구현할 수 있습니다.
        
        2. 데이터베이스 연결(Database Connection)
        데이터베이스 연결은 대부분 비슷한 방식으로 이루어집니다.
        예를 들어, 데이터베이스 연결을 시작하고, 쿼리를 실행하고, 결과를 처리하는 방식은 모든 데이터베이스에서 비슷합니다.
        이 때, 템플릿 메소드 패턴을 사용하면 데이터베이스 종류에 상관없이 동일한 방식으로 데이터베이스를 다룰 수 있습니다.
        
        [추가 개념]
        · 제어의 역전(Inversion of Control, IoC)
        프로그램의 "제어 흐름을 직접 제어하는 것"이 아니라, 외부에서 관리하는 것을 제어의 역전(IoC)라고 한다.
        
        · Dependency Inversion Principle (DIP)
        고차원 모듈은 저차원 모듈에 의존하면 안된다. 이 모듈 모두 다른 추상화된 것에 의존해야 한다.
        추상화 된 것은 구체적인 것에 의존하면 안 된다. 구체적인 것이 추상화된 것에 의존해야 한다.'
        
        · 리스코프 치환 원칙
        LSP(Liskov Substitution Principle)
        프로그램의 정확성에 영향을 미치지 않고 상위 클래스의 개체를 해당 하위 클래스의 개체로 대체할 수 있어야 한다는 개체 지향 프로그래밍의 원칙입니다.
        즉, 슈퍼클래스의 개체와 함께 작동하는 메서드는 추가 로직이나 유형 검사 없이도 하위 클래스의 개체와 함께 작동해야 합니다.
        
        도형이라는 부모 클래스가 있어 > 회전하는 rotation Operatoion이 있다고 가정
        상위클래스를 상속을 받는 하위클래스에서 의도를 그대로 유지하지않고 다른 행동을 하면 안된다.
        
        [템플릿 콜백 패턴]
        콜백으로 상속 대신 위임을 사용하는 템플릿 패턴
        상속 대신 익명 내부 클래스 또는 람다 표현식을 활용할 수 있다.
        """
        
        client()
    }
    
    private func client() {
        ConcreteAlgorithmA().execute()
        
        PlusCalaculatorProcessor().process(a: 10, b: 10)
        MultiplicationCalaculatorProcessor().process(a: 10, b: 10)
    }
}
