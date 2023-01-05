//
//  BuilderPattern.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2023/01/05.
//

import UIKit

final class BuilderViewController: UIViewController {
    
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
        [ 빌더 패턴 ]
        
        """
        
        client()
    }
    
    private func client() {
        
    }
}

