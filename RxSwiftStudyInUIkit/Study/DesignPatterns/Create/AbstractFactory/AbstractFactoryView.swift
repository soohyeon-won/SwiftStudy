//
//  AbstractFactoryViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/12/26.
//
import SwiftUI

struct AbstractFactoryView: View {
    
    private let textViewContent = """
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
    """
    
    var body: some View {
        ScrollView {
            Text(textViewContent)
                .font(.system(size: 24))
                .padding(24)
                .background(Color.white)
                .cornerRadius(8)
            
            CodeView(code: """
            final class WhiteshipPartsFactory: ShipPartsFactory {
                func createAnchor() -> Anchor {
                    print("white anchor 추가")
                    return WhiteAnchor()
                }
                
                func createWheel() -> Wheel {
                    print("white wheel 추가")
                    return WhiteWheel()
                }
            }
            
            final class WhiteshipAbstractFactory: ShipFactory {
                
                private var shipPartsFactory: ShipPartsFactory
                
                init(shipPartsFactory: ShipPartsFactory) {
                    self.shipPartsFactory = shipPartsFactory
                }
                
                func createShip() -> Ship {
                    var whiteShip = Whiteship()
                    // 직접 객체를 인스턴스화해서 넣는것이 아니라
                    // 추상화된 인스턴스를 받아서 인스턴스를 주입해준다
                    // ShipFactory 는 변형없이 사용가능함.
                    // Open/Closed Principle (OCP) 개방 폐쇄 원칙
                    whiteShip.setAnchor(anchor: shipPartsFactory.createAnchor())
                    whiteShip.setWheel(wheel: shipPartsFactory.createWheel())
                    return whiteShip
                }
            }
            
            private func client() {
                let shipFactory = WhiteshipAbstractFactory(shipPartsFactory: WhiteshipPartsFactory())
                let ship = shipFactory.ordershiip(name: "whiteShip", email: "test@gmail.com")
            }
            """)
        }
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .onAppear {
            client()
        }
    }
    
    private func client() {
        let shipFactory = WhiteshipAbstractFactory(shipPartsFactory: WhiteshipPartsFactory())
        let ship = shipFactory.ordershiip(name: "whiteShip", email: "test@gmail.com")
        print("ship: \(ship)")
    }
}
