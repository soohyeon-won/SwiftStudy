//
//  FactoryMethodViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2022/12/10.
//

import UIKit

final class FactoryMethodViewController: UIViewController {
    
    let textView = UITextView().then {
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
        [ 팩토리 메서드 패턴 ]
        구체적으로 어떤 인스턴스를 만들지는 서브 클래스가 정한다.
        """
        
        client()
    }
    
    private func client() {
        let whiteship = WhiteshipFactory().ordershiip(name: "WhiteShip", email: "test@naver.com")
        print(whiteship)
        
        let blackship = BlackshipFactory().ordershiip(name: "BlackShip", email: "test1@naver.com")
        print(blackship)
    }
}
