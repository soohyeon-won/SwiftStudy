//
//  ChainOfResponsibilityViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class ChainOfResponsibilityViewController: UIViewController {
    
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
        [ 책임 연쇄 패턴 ]
        각각의 책임이 연결되어있는 패턴
        SRP(단일 책임 원칙)에서 얘기하는 책임과 동일
        
        요청을 보내는 쪽(Sender)과 요청을 처리하는 쪽(receiver)을 분리하는 패턴
        핸들러 체인을 사용해서 요청을 처리한다.
        클라이언트가 구체적인 핸들러 타입을 알지 않아도 된다.
        
        [장점]
        
        [단점]
        
        [사용 예제]
        """
        
        client()
    }
    
    private func client() {
        let handler = AuthRequestHandler()
//        let handler = LoggingRequestHandler()
        handler.handler()
    }
}

class RequestHandler {
    
    func handler() {
        
    }
}

// 장점:  SRP 를 지킬 수 있음
// 문제: client가 AuthRequestHandler를 선택해야해서 클라이언트 코드가 변경됨.
// 로깅 등을 해야한다고 했을때 handler를 추가해야함
final class AuthRequestHandler: RequestHandler {
    
    override func handler() {
        print("유저 인증정보 확인")
        
        super.handler()
    }
}

// 로깅도하고 인증도 해야한다고 했을때 어떻게 해야할지 고민이 필요함
// 책임연쇄를 적용
final class LoggingRequestHandler: RequestHandler {
    
    override func handler() {
        print("로깅")
        
        super.handler()
    }
}

/** 아래는 책임연쇄 패턴을 이용하여 개선된 코드 **/

protocol RequestHandlerProtocol {
    var nextHandler: RequestHandlerProtocol? { get set }
    
    func handler(request: Request)
}

extension RequestHandlerProtocol {
    
    func handler(request: Request) {
        if nextHandler != nil {
            nextHandler?.handler(request: request)
        }
    }
}

class Request {
    
}
