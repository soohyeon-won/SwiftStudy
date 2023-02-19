//
//  AbstractFactoryViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/12/26.
//
import UIKit

final class AbstractFactoryViewController: UIViewController {
    
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
        [ 추상 팩토리 패턴 ]
        서로 관련있는 여러 객체를 만들어주는 인터페이스
        - 구체적으로 어떤 클래스의 인스턴스를(concrete product) 사용하는지 감출 수 있다.
        
        팩토리 메소드 패턴과 굉장히 흡사한데 무엇이 다른건가.
        둘 다 구체적인 객체 생성 과정을 추상화한 인터페이스를 제공
        
        [ 차이점 ]
        - 팩토리 메소드 패턴은 팩토리를 구현하는 방법 (inheritance)에 초점을 둔다.
        팩토리 메소드 패턴은 구체적인 객체 생성과정을 하위 또는 구체적인 클래스로 옮기는 것이 목적
        
        - 추상 팩토리 패턴은 팩토리를 사용하는 방법 (composition)에 초점을 둔다.
        추상 팩토리 패턴은 관련있는 여러 객체를 구체적인 클래스에 의존하지 않고 만들 수 있게 해준다.
        
        [나의 정리]
        ==> 추상팩토리 패턴은 관련있는 객체를 만들어준다고 할수 있는데,
        객체를 인스턴스화하는 프로토콜을 두고 이를 상속받아서 인스턴스를 생성한다.
        예를들어 배를 생성하는 인스턴스를 팩토리 메서드 패턴을 이용하여 구현했다고 하면,
        배에 바퀴, 닻을 추가하는 코드를 추가할 때 추상팩토리 패턴을 이용하여
        이미 만들어진 인스턴스에 의존적이지 않도록 바퀴와 닻을 생성하는 코드를 구현할 수 있는것이다.
        
        기존에 사용하던 FactoryMethod 클래스에 추상팩토리 protocol을 주입하여 사용할 수 있다.
        
        실무에선 어떻게 쓰이나?
        Java
        DocumentBuilderActory
        FactoryBean<T>
        """
        
        client()
    }
    
    private func client() {
        printShip(shipFactory: WhiteshipFactory2(shipPartsFactory: WhiteshipPartsFactory()), name: "WhiteShip", email: "test@naver.com")
    }
    
    private func printShip(shipFactory: ShipFactory, name: String, email: String) {
        print(shipFactory.ordershiip(name: name, email: email))
    }
}

