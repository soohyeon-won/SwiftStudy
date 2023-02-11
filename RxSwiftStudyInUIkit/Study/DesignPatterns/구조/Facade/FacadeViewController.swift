//
//  FacadeViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/11.
//

import UIKit

final class FacadeViewController: UIViewController {
    
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
        [ 퍼사드 패턴 ]
        건물의 외관, 입구쪽을 바라본 전경
        건물 안에 뭐가 있는지는 알 수 없음
        유연한 개발을 위해 약결합 시스템(Loosely Coupled System) 에 대해 생각해보아야 함
        
        클라이언트가 사용해야 하는 복잡한 서브 시스템 의존성을 간단한 인터페이스로 추상화 할 수 있다.
        복잡한 기능은 퍼사드 뒤로 숨김
        
        [장점]
        
        [단점]
        
        """
        
        client()
    }
    
    private func client() {
    }
}
