//
//  VisitorViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class VisitorViewController: UIViewController {
    
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
        [ 비지터 패턴 ]
        - 기존코드를 변경하지 않고 새로운 기능을 추가하는 방법
        - 더블 디스패치(Double Dispatch)를 활용할 수 있다.
        - 비지터는 추가하고싶은 로직을 담고있는곳
        - element는 accept함수가 있음 element는 변하지 않는, 본연의 기능만을 가진 클래스
        - 딱 하나만 추가해야함 > accept(Visitor) // method overloading: 이름은 같지만 파라미터가 다름
        
        [장점]
        - accept 코드 하나만 추가하면 기존코드의 변경없이 새로운 기능을 추가할 수 있다.
        
        [단점]
        - 더블 디스패치를 이해하는 것 자체에대한 허들이 높다.
        - 메소드 오버로딩은 컴파일 타임에 스태틱하게 매핑이 되어서 Element 타입마다 비지터 함수가 늘어난다.
        - element가 추가되거나 삭제될때 상당한 변경이 일어난다. // SRP, OCP 이 깨질 우려가 있음
        - 비지터는 복잡하고 적용 범위가 좁기 때문에 매우 일반적인 패턴이 아닙니다.
        
        [사용 예제]
        1. 디바이스의 모양을 만드는 클래스
        각 디바이스에 모양(Shape)정보가 들어오면, 그에 맞는 디바이스를 리턴해준다.
        
        2. 마커찍기
        """
        
        client()
    }
    
    private func client() {
        let beforeRecctangle: BeforeShapeProtocol = BeforeRectangle()
        beforeRecctangle.printTo(device: BeforePhone())
        
        errorExample() // 아래에서 개선
        
        let rectangle: ShapeProtocol = RectangleImpl()
        let phone: Device = Phone()
        rectangle.accept(device: phone)
        
        let watch: Device = Watch()
        
        // accept는 인터페이스잖아, rectangle클래스의 accept를 찾는 디스패치1
        // device가 여러개잖아, watch의 printTo메소드를 찾는 디스패치2
        // 따라서 더블 디스패치 라고 얘기함
        // 구체적인 타입을 찾아가는 과정이 두번 일어난다는 얘기
        rectangle.accept(device: watch)
        
        // 지도에 마커그리기
        let map = Map() // concrete visitor
        let markers: [Marker] = [
            LocalMarker(name: "Seoul"), // element
            ComplexMarker(id: "1234"), // element
            VillaMarker(location: "Jeju") // element
        ]
        
        let mapDrawer = MapDrawer()
        mapDrawer.drawMarkers(on: map, markers: markers)
    }
    
    private func errorExample() {
        // 아래는 에러가 나는 코드
//        let rectangle: ShapeProtocol = Rectangle()
//        let device: Device = Phone()
//        rectangle.printTo(device: device) // No exact matches in call to instance method 'printTo'
    }
}
