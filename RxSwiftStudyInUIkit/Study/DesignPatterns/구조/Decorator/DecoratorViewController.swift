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
        새로운 클래스를 만들지 않고 기존 기능을 조합할 수 있다. // SRP 단일책임을 가지는 Decorator들을 만들 어서 조합할 수 있음.
        
        컴파일 타임이 아닌 런타임에 동적으로 기능을 변경할 수 있다.
        
        [단점]
        데코레이터를 조합해주는 코드가 복잡해질 수 있음.
        
        작은 객체들이 많이 늘어난다는 단점이 있지만 상속을 사용하면 더 많은 서브클래스들이 만들어지기 때문에 큰 단점은 아님(by 백기선)
        알고리즘으로 보자면 데코레이터 패턴으로는 O(1)만큼 늘어남
        상속을 사용해서 확장하면 경우의수에 따라 O(2^n)으로 늘어날 수 있음
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
        
        // 위에 있는 코드는 상속을 이용하여 만들어도 비슷하다고 볼 수 있다.
        // 하지만 Decorator의 조합은 동적으로 이루어지기때문에
        // 아래와 같은 조건에 의해서 생성할 때에도 손쉽게 Service를 생성할 수 있다.
        // DefaultCommentService의 기능을 수정하지 않고 클래스를 추가하여 구현할 수 있다. // OCP
        // CommentService라는 인터페이스를 사용하여 DIP(Dependency Inversion Principle) 의존 역전 원칙을 지킴
        if enabledSpamFilter && enabledTrimming {
            commentService = SpamFilteringCommentDecorator(commentService: commentService)
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
        print("CommentDecorator \(comment)")
        commentService.addComment(comment: comment)
    }
}

class TrimmingCommentDecorator: CommentDecorator {
    
    override init(commentService: CommentService) {
        super.init(commentService: commentService)
    }
    
    override func addComment(comment: String) {
        print("TrimmingCommentDecorator \(comment)")
        let comment = comment.replacingOccurrences(of: "...", with: "")
        super.addComment(comment: comment)
    }
}

class SpamFilteringCommentDecorator: CommentDecorator {
    
    override init(commentService: CommentService) {
        super.init(commentService: commentService)
    }
    
    override func addComment(comment: String) {
        print("SpamFilteringCommentDecorator \(comment)")
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
