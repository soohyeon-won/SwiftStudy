//
//  ProxyViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/11.
//

import UIKit

final class ProxyViewController: UIViewController {
    
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
        [ 프록시 패턴 ]
        특정 객체에 대한 접근을 제어하거나 기능을 추가할 수 있는 패턴
        - 초기화 지연, 접근 제어, 로깅, 캐싱 등 다양하게 응용해 사용할 수 있다.
        
        Subject
        ↑
        ↑ ←-------------
        RealSubject ← proxy
        
        대리, 대리인
        security를 적용해서 접근을 제한 할 수 있는 로직을 넣을 수 도 있고
        로깅, 캐싱을 적용할 수 도 있음.
        
        
        [장점]
        
        [단점]
        
        """
        
        client()
    }
    
    private func client() {
        GameService().startGame()
    }
}

class GameService {
    
    func startGame() {
        print("이 자리에 오신 여러분을 진심으로 환영합니다.")
    }
}
