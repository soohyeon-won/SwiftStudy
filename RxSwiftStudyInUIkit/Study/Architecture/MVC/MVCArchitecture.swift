//
//  MVCArchitecture.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/04/27.
//

import UIKit

final class MVCArchitecture: UIViewController {
    
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
        
        textView.text =
        """
        [ MVC Architecture ]
        Model-View-Controller
        
        Model: 애플리케이션의 데이터와 비즈니스 로직을 처리하는 부분입니다. 데이터를 저장하고 관리하며, 비즈니스 로직을 수행하여 데이터를 가공합니다.

        View: 사용자 인터페이스(UI)를 담당하는 부분입니다. 사용자가 애플리케이션에서 보게 될 화면 요소들을 표현합니다.

        Controller: Model과 View를 연결하는 부분으로, 사용자의 입력과 상호작용을 처리합니다. 사용자의 입력을 받아 Model의 데이터를 갱신하고, 변경된 데이터를 View에 반영합니다.

        Swift의 MVC 패턴에서는 이러한 세 가지 역할을 각각 클래스로 구현합니다.
        예를 들어, Model을 담당하는 클래스는 애플리케이션에서 사용하는 데이터 구조체나 클래스입니다.
        View를 담당하는 클래스는 주로 Storyboard나 XIB 파일에 구현된 뷰 컴포넌트입니다.
        Controller는 주로 UIViewController 클래스를 상속한 클래스입니다.
        
        [ 장점 ]
        1. 다른 패턴에 비해 코드량이 적다
        2. 애플에서 기본적으로 지원하고 있는 패턴이기 때문에 쉽게 접근할 수 있다
        3. 많은 개발자들에게 친숙한 패턴이기 때문에 개발자들이 쉽게 유지보수 할 수 있다.
        4. 개발 속도가 빠르기 때문에 아키텍처가 중요하지 않을 때 사용하거나 규모가 작은 프로젝트에서 사용하기 좋다.
        
        [ 단점 ]
        1. 뷰와 컨트롤러가 너무 밀접하게 연결되어 있다.
        2. View와 Controller가 붙어있으며 Controller가 View의 Lift Cycle까지 관리하기 때문에 View와 Controller를 분리하기 어렵다. 이렇게 되면 재사용성이 떨어지고 유닛 테스트를 진행하기 힘들어진다.
        3. 대부분의 코드가 Controller에 밀집될 수 있다. Life Cycle 관리 뿐만 아니라 delegate나 datasource관리, 네트워크 요청, DB에 데이터 요청 등 많은 코드가 Controller에 작성되면 Controller의 크기는 비대해지고 내부 구조는 복잡해지게 된다.
        4. 이런 상황을 비유해 많은 사람들이 Massive View Contorller라고 부르기도 한다
        5. 이렇게 복잡해진 코드는 프로젝트 규모가 커질수록 유지보수하기 힘들게 만든다.
        """
        
        client()
    }
    
    private func client() {
    }
}
