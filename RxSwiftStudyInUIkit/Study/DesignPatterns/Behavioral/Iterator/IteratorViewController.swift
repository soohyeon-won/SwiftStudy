//
//  IteratorViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class IteratorViewController: UIViewController {
    
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
        [ 이터레이터(반복자) 패턴 ]
        - 집합객체를 순회하는 패턴, 내부 구조를 노출하지 않고 순회하는 방법을 제공
        
        [구조도]
        Iterator(interface) <- client -> Aggregate(interface)
                ↑                                 ↑
        ConcreteIterator    <- ------- -> ConcreateAggregate
        
        [장점]
        - 집합 객체를 순회하는 클라이언트 코드를 변경하지 않고 다양한 순회 방법을 제공할 수 있다.
        - 집합 객체가 가지고 있는 객체들에 손쉽게 접근할 수 있다.
        - 일관된 인터페이스를 사용해 여러 형태의 집합 구조를 순회할 수 있다.
        - 클래스 내부에 어떻게 선언되어있는지(Set? Array? dic?) 상관없이 next함수만을 가지고 순회를 할 수 있음 // SRP
        - 내부 구조(list)가 변경이 될 수 있는 가능성이 있으면 Iterator를 사용하면 client코드의 변경없이 수정할 수 있음.
        
        [단점]
        - 클래스가 늘어나고 복잡도가 증가한다.
        
        [사용 예제]
        """
        
        client()
    }
    
    private func client() {
//        let board = Board()
//        var iterator = board.list.makeIterator()
//
//        while iterator.next() == nil {
//            let _ = iterator.next()
//        }
        
        let board = Board()
        board.list.append(Post(title: "test1"))
        board.list.append(Post(title: "test2"))
        board.list.append(Post(title: "test3"))
        
        let itorator = BoardIterator(posts: board.list.makeIterator())
        while let value = itorator.next() {
            print("value: \(value)")
        }
    }
}

class Board {
    
    var list = [Post]()
}

struct Post {
    let title: String
}

class BoardIterator: IteratorProtocol {
    
    typealias Element = Post
    
    private var posts: IndexingIterator<[Post]>
    
    init(posts: IndexingIterator<[Post]>) {
        self.posts = posts
    }
    
    func next() -> Post? {
        return posts.next()
    }
}
