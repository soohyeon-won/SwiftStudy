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
        상속이 아닌 composition
        나누어져 있는 것을 연결해서 사용해준다.
        
        추상적인 부분 / 구체적인 부분
        동작... / 상태...
        FE / BE
        성격이 상이한 것들을 연결해주는 부분
        
        [장점]
        추상적인 코드를 구체적인 코드 변경 없이도 독립적으로 확장할 수 있다.
        추상적인 코드와 구체적인 코드를 분리할 수 있다.
        
        [단점]
        계층 구조가 늘어나 복잡도가 증가할 수 있다.
        
        OCP : Open-Closed principle
        SRP : Single Responsibility principle
        
        """
        
        client()
    }
    
    private func client() {
        정복자아리().skillQ()
        
        아리(skin: 정복자Skin()).skillQ()
    }
}

protocol KDA {
    
}

protocol PoolParty {
    
}

protocol Champion {
    func move()
    func skillQ()
}

class 정복자아리: Champion {
    // 챔피언의 다른 구성을 넣기에는 KDA스킨으로 한정되어있음
    func move() {
        print("정복자아리 move")
    }
    
    func skillQ() {
        print("정복자아리 Q")
    }
}

/// 브릿지 패턴을 이용하여 변경
protocol Skin {
    var name: String { get set }
}

class 정복자Skin: Skin {
    var name: String = "정복자"
}

class DefaultChampion: Champion {
    
    private let championName: String
    private let skin: Skin
    
    init(championName: String, skin: Skin) {
        self.championName = championName
        self.skin = skin
    }
    
    func move() {
        print("\(skin.name)\(championName) move")
    }
    
    func skillQ() {
        print("\(skin.name)\(championName) Q")
    }
}

class 아리: DefaultChampion {
    
    init(skin: Skin) {
        super.init(championName: "아리", skin: skin)
    }
}
