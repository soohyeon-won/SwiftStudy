//
//  StateViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class StateViewController: UIViewController {
    
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
        [ 상태 (State) 패턴 ]
        - 객체 내부 상태 변경에 따라 객체의 행동이 달라지는 패턴.
        • 상태에 특화된 행동들을 분리해 낼 수 있으며, 새로운 행동을 추가하더라도 다른 행동에 영향을 주지 않는다.
        
        [장점]
        
        [단점]
        
        [사용 예제]
        """
        
        client()
    }
    
    private func client() {
        
    }
}
