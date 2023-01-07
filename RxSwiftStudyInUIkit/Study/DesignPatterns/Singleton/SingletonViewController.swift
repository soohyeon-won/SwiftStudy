//
//  SingletonViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2022/12/10.
//

import UIKit

final class SingletonViewController: UIViewController {
    
    let textView = UITextView().then {
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
        [ 싱글톤 패턴 ]
        
        thread safety하게 구현하는 것이 중요
        - synchronized
        - double check locking
        - Immutable
        
        swift는 전역, 정적 변수 / 싱글톤 객체 lazy하게 생성, atomic함 보장
        let 선언 Immutable 하도록 설정 가능
        thread safety = Immutable + atomic함 보장
        
        + atomic함: 공유자원에 변경이 일어나고 있을 때는 다른 스레드가 접근X
        
        싱글톤 패턴은 객체지향적 관점에서 의존성을 주입할 수 없어(DIP 위반) 테스트가 어렵고,
        구체타입에 의존해야 하므로 유연성이 떨어진다(OCP 위반 가능성 높음)는 단점이 있음
        """
        
        SettingsNive.getInstance()
        
        SettingsNive.getInstance2()
        
        Settings.settings
    }
}
