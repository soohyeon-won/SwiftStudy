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
    }
}

