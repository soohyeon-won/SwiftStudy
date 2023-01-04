//
//  AbstractFactoryViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/12/26.
//
import UIKit

final class AbstractFactoryViewController: UIViewController {
    
    private let textView = UITextView().then {
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
        [ 추상 팩토리 패턴 ]
        서로 관련있는 여러 객체를 만들어주는 인터페이스
        - 구체적으로 어떤 클래스의 인스턴스를(concrete product) 사용하는지 감출 수 있다.
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

