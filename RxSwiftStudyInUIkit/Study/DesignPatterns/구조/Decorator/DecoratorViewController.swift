//
//  DecoratorViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/11.
//

import UIKit

final class DecoratorViewController: UIViewController {
    
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
        [ 데코레이터 패턴 ]
        다이나믹하게 런타임에(유연하게, 동적이게) 기존 코드를 확장하는 디자인 패턴
        (<-> 컴파일타임에(고정적이고, 스태틱하게))
        
        
        [장점]
        
        [단점]
        
        """
        
        client()
    }
    
    private func client() {
        CommentClient(commentService: TrimmingCommentService()).writeComment(comment: "오징어게임...")
    }
}

protocol CommentService {
    func addComment(comment: String)
}

class DefaultComentService: CommentService {
    func addComment(comment: String) {
        print("comment: \(comment)")
    }
}

// 상속을 이용해 구현했기 때문에 확장이 쉽지 않은 단점이 있다.
// 스팸 필터링(http) 기능을 제공하려면 어떻게 할것인가..?
class TrimmingCommentService: DefaultComentService {
    override func addComment(comment: String) {
        let comment = comment.replacingOccurrences(of: "...", with: "")
        super.addComment(comment: comment)
    }
}

class CommentClient {
    
    let commentService: CommentService
    
    init(commentService: CommentService) {
        self.commentService = commentService
    }
    
    func writeComment(comment: String) {
        commentService.addComment(comment: comment)
    }
}
