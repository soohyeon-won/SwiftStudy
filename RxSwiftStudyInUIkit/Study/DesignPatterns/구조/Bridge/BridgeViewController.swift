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
        
        """
        
        client()
    }
    
    private func client() {
        
    }
}

