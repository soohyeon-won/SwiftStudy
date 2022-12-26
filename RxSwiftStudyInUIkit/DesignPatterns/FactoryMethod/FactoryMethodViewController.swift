//
//  FactoryMethodViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2022/12/10.
//

import UIKit

final class FactoryMethodViewController: UIViewController {
    
    let textView = UITextView().then {
        $0.isUserInteractionEnabled = false
        $0.font = .systemFont(ofSize: 24)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(textView)
        
        textView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(24)
        }
        
        textView.text = """
        [ 팩토리 메서드 패턴 ]
        구체적으로 어떤 인스턴스를 만들지는 서브 클래스가 정한다.
        - 다양한 구현체(Product)가 있고 , 그 중에서 특정한 구현체를 만들 수 있는 다양한 팩토리(Creator)를 제공할 수 있다.
        
        Q1. 팩토리 메소드 패턴을 적용했을 때 장점, 단점은?
        A1.
        장점: 기존 코드를 변경하지 않고 새로운 인스턴스를 생성(확장)할 수 있다. Product와 Creator의 느슨한 결합(Loose Coupling) 덕분.
        단점: 클래스가 늘어남
        Q2. 확장에 열려있고 변경에 닫혀있는 객체 지향 원칙
        A2. 개방-폐쇄 원칙(OCP, Open-Closed Principle)
        변경에 닫혀있다 == 기존코드 변경X 확장이 가능하다.
        """
        
        client()
    }
    
    private func client() {
        // 1. Factory 클라이언트에서 직접 호출
        let whiteship = WhiteshipFactory().ordershiip(name: "WhiteShip", email: "test@naver.com")
        print(whiteship)
        
        let blackship = BlackshipFactory().ordershiip(name: "BlackShip", email: "test1@naver.com")
        print(blackship)
        
        // 2. 의존성 주입을 통한 FactoryMethod 인터페이스 호출
        // 클라이언트 변경 최소화
        printShip(shipFactory: WhiteshipFactory(), name: "WhiteShip", email: "test@naver.com")
        printShip(shipFactory: BlackshipFactory(), name: "BlackShip", email: "test1@naver.com")
    }
    
    private func printShip(shipFactory: ShipFactory, name: String, email: String) {
        print(shipFactory.ordershiip(name: name, email: email))
    }
}
