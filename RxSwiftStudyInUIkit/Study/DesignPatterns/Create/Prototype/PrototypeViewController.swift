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
        
        JAVA에서 cloneable을 제공
        shallow copy(얕은 복사) <-> deep copy
        
        장점
        복잡한 객체를 만드는 과정을 숨길 수 있다.
        기존 객체를 복제하는 과정이 새 인스턴스를 만드는것보다 비용(시간 or 메모리)적인 면에서 효율적일 수도있다.
        추상적인 타입을 리턴할 수 있다.
        
        단점
        복제한 객체를 만드는 과정 자체가 복잡할 수 있다.(특히, 순환 참조가 있는 경우)
        """
        
        client()
    }
    
    private func client() {
        let repository = GithubRepository()
        
        let githubIssue = GithubIssue(repository: repository)
        
        let clone = githubIssue
        
        // shallow copy의 경우
        print(clone.repository === githubIssue.repository)
        
        // java에서는 clonable을 제공하지만 swift X
    }
}

final class GithubRepository {
    
}

final class GithubIssue {
    let repository: GithubRepository
    
    init(repository: GithubRepository) {
        self.repository = repository
    }
}

