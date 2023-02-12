//
//  FlyweightViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/11.
//

import UIKit

final class FlyweightViewController: UIViewController {
    
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
        [ 플라이웨이트 패턴 ]
        자주 변하는 속성(또는 외적인 속성 extrinsic)과 변하지 않는 속성(또는 내적인 속성, intrinsic)을 분리하고 재사용하여 메모리 사용을 줄일 수 있다.
        다른 객체들이 공통으로 사용하는 데이터를 캐싱하여 RAM을 절약합니다.
        
        성능을 개선하는 패턴
        자주 변하지 않는 속성을 재사용하여 사용
        extrinsic(외적, 자주변하는것, 본질적이지 않은것) <-> intrinsic(내적, 변하지않는것, 본질적인 것)
        FliweightFactory
        Fliyweight
        
        [장점]
        
        [단점]
        
        """
        
        client()
    }
    
    private func client() {
    }
}
