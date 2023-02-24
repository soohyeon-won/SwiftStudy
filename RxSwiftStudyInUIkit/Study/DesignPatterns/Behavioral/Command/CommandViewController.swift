//
//  CommandViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class CommandViewController: UIViewController {
    
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
        [ 커맨드 패턴 ]
        요청을 캡슐화 하여 호출자(invoker)와 수신자(receiver)를 분리하는 패턴.
        - 요청을 처리하는 방법이 바뀌더라도 호출자의 코드는 변경되지 않는다.
        
        Invoker -> Command(interface) + excute()
                     ⬆️
        receiver <- ConcreateCommand + excute
        
        아래 예제에서는
        invoker / receiver
        Button / Light
        
        [장점]
        
        [단점]
        
        [사용 예제]
        """
        
        client()
    }
    
    private func client() {
        
    }
}

final class Button {
    private let light: Light
    
    public init(light: Light) {
        self.light = light
    }
    
    func press() {
        light.off()
    }
    
}

struct Light {
    func on() {
        
    }
    
    func off() {
        
    }
}
