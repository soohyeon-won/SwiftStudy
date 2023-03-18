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
        
        [단점]
        
        [사용 예제]
        1. 디바이스의 모양을 만드는 클래스
        각 디바이스에 모양(Shape)정보가 들어오면, 그에 맞는 디바이스를 리턴해준다.
        
        2.
        """
        
        client()
    }
    
    private func client() {
        let beforeRecctangle: BeforeShapeProtocol = BeforeRectangle()
        beforeRecctangle.printTo(device: BeforePhone())
        
        errorExample() // 아래에서 개선
        
        let rectangle: ShapeProtocol = Rectangle()
        let phone: Device = Phone()
        rectangle.accept(device: phone)
        
        let watch: Device = Watch()
        
        // accept는 인터페이스잖아, rectangle클래스의 accept를 찾는 디스패치1
        // device가 여러개잖아, watch의 printTo메소드를 찾는 디스패치2
        // 따라서 더블 디스패치 라고 얘기함
        // 구체적인 타입을 찾아가는 과정이 두번 일어난다는 얘기
        rectangle.accept(device: watch)
        
        // 지도에 마커그리기
        let map = Map()
        let markers: [Marker] = [
            LocalMarker(name: "Seoul"),
            ComplexMarker(id: "1234"),
            VillaMarker(location: "Jeju")
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
