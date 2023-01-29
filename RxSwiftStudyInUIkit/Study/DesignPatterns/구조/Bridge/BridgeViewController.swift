//
//  BridgeViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/01/29.
//

import UIKit

final class BridgeViewController: UIViewController {
    
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
        [ 브릿지 패턴 ]
        추상적인 것과 구체적인 것을 분리하여 연결하는 패턴
        하나의 계층 구조일 때보다 각기 나누었을때 독립적인 계층 구조로 발전시킬 수 있다.
        나누어져 있는 것을 연결해서 사용해준다.
        
        추상적인 부분 / 구체적인 부분
        동작... / 상태...
        FE / BE
        성격이 상이한 것들을 연결해주는 부분
        
        
        """
        
        client()
    }
    
    private func client() {
        
    }
}

