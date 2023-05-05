//
//  ReactorKit.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/01.
//

import UIKit

final class ReactorKit: UIViewController {
    
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
        [ ReactorKit ]
        MVVM 패턴을 기반으로 하며 RxSwift를 사용하여 구현된 라이브러리입니다. 이 패턴에서는 상태를 중심으로 앱을 설계합니다. 앱의 모든 상태는 하나의 상태 스트림으로 관리되고, 상태 변화는 반응형으로 처리됩니다.
        
        [ 장점 ]
        
        [ 단점 ]
        """
        
        client()
    }
    
    private func client() {
    }
}
