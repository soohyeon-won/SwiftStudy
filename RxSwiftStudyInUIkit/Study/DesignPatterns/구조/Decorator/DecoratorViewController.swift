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
        
        상속이 아닌 위임을 사용해서 보다 유연하게(런타임에) 부가 기능을 추가하는 것도 가능하다.
        
        컴포짓 패턴처럼 여러개가 아니라 딱 한개의 wrappee라는 컴포넌트를 갖고 있음
        concreateComponent - Decorator // wrapper 라고도 부름
        단 하나의 Decorator가 wrappee를 감쌈
        [장점]
        
        [단점]
        
        """
        
        client()
    }
    
    private func client() {
        
        let enabledSpamFilter = true
        let enabledTrimming = true
        
        var commentService: CommentService = DefaultComentService()
        
        if enabledSpamFilter {
            commentService = SpamFilteringCommentDecorator(commentService: commentService)
        }
        
        if enabledTrimming {
            commentService = TrimmingCommentDecorator(commentService: commentService)
        }
        
        let client = CommentClient(commentService: commentService)
        client.writeComment(comment: "오징어게임...")
        client.writeComment(comment: "http://whiteship.me")
    }
}

protocol CommentService { // Component
    func addComment(comment: String)
}

class DefaultComentService: CommentService { // ConcreateComponent
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

class CommentDecorator: CommentService {
    
    let commentService: CommentService
    
    init(commentService: CommentService) {
        self.commentService = commentService
    }
    
    func addComment(comment: String) {
        commentService.addComment(comment: comment)
    }
}

class TrimmingCommentDecorator: CommentDecorator {
    
    override init(commentService: CommentService) {
        super.init(commentService: commentService)
    }
    
    override func addComment(comment: String) {
        let comment = comment.replacingOccurrences(of: "...", with: "")
        super.addComment(comment: comment)
    }
}

class SpamFilteringCommentDecorator: CommentDecorator {
    
    override init(commentService: CommentService) {
        super.init(commentService: commentService)
    }
    
    override func addComment(comment: String) {
        if isNotSpam(comment: comment) {
            super.addComment(comment: comment)
            return
        }
    }
    
    func isNotSpam(comment: String) -> Bool {
        return !comment.contains("http")
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
