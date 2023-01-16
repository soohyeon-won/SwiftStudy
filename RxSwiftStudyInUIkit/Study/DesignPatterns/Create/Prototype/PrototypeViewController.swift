//
//  PrototypeViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2023/01/16.
//

import UIKit

final class PrototypeViewController: UIViewController {
    
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
        [ 프로토타입 패턴 ]
        기존 인스턴스를 복제하여 새로운 인스턴스를 만드는 방법
        
        복제 기능을 갖추고 있는 기존 인스턴스를 프로토타입으로 사용해 새 인스턴스를 만들 수 있다.
        """
        
        client()
    }
    
    private func client() {
        
    }
}

