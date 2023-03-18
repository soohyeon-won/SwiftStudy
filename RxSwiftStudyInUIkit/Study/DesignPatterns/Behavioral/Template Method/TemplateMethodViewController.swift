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
        
        [단점]
        
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
        
        [템플릿 콜백 패턴]
        콜백으로 상속 대신 위임을 사용하는 템플릿 패턴
        상속 대신 익명 내부 클래스 또는 람다 표현식을 활용할 수 있다.
        """
        
        client()
    }
    
    private func client() {
        PlusCalaculatorProcessor().process(a: 10, b: 10)
        MultiplicationCalaculatorProcessor().process(a: 10, b: 10)
    }
}
