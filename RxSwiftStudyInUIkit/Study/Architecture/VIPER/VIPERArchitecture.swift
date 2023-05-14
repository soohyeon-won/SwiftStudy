//
//  VIPERArchitecture.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/05.
//

import UIKit

final class VIPERArchitecture: UIViewController {
    
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
        
        textView.text =
        """
        [ VIPER Architecture ]
        
        [ 장점 ]
        
        [ 단점 ]
        """
        
        client()
    }
    
    private func client() {
    }
}