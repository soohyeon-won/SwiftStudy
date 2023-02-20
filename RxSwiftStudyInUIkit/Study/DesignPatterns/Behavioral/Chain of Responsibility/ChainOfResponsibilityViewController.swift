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
        client코드를 변경하지 않고 Chain에 Handler를 추가할 수 있다. // OCP
        각각의 Handler마다 본인이 해야할 일만 하도록 할 수 있다. // SRP
        체인을 다양한 형태로 구성할 수 있다.
        - 순서를 가지고 있는 체인
        - 순차적으로 실행된 후 특정 핸들러에서 해당 요청만 처리하게끔 할 수 있음
        
        [단점]
        체인으로 인해 핸들러가 중첩되면서 디버깅이 어려울 수 있음
        
        [사용 예제]
        """
        
        client()
    }
    
    private func client() {
        let handler = AuthRequestHandler()
        handler.handler()
        
        print("====책임 연쇄 패턴 로그====")
        // COR
        let reqeust = Request()
        // 요청을 하는 쪽과 요청을 처리하는 쪽을 몰라도됨.
        // 체인을 구성해주는 곳에서 앱의 특징에 따라 순서에 의미가 있거나 특정 부분은 바이패쓰하거나 등을 이용할 수 있음.
        // 경우에 따라 다른 체인을 다녀온다음 그 이후에 실행하도록 설계할 수도 있음
        // 요청을 처리, 응답을 처리할 때 많이 사용되는 패턴이다.
        let chain = CheckAuthRequestHandler(
            nextHandler: ContentLoggingRequestHandler(
                nextHandler: PrintRequestHandler(nextHandler: nil)
            )
        )
        chain.handler(request: reqeust)
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

class Request {
    
}

class CORRequestHandler: RequestHandlerProtocol {
    
    var nextHandler: RequestHandlerProtocol?
    
    init(nextHandler: RequestHandlerProtocol?) {
        self.nextHandler = nextHandler
    }
    
    func handler(request: Request) {
        if nextHandler != nil {
            nextHandler?.handler(request: request)
        }
    }
}

final class PrintRequestHandler: CORRequestHandler {
    
    override init(nextHandler: RequestHandlerProtocol?) {
        super.init(nextHandler: nextHandler)
    }
    
    override func handler(request: Request) {
        print("프린트 핸들러")
        super.handler(request: request)
    }
}

final class CheckAuthRequestHandler: CORRequestHandler {
    
    override init(nextHandler: RequestHandlerProtocol?) {
        super.init(nextHandler: nextHandler)
    }
    
    override func handler(request: Request) {
        print("인증여부 체크 핸들러")
        super.handler(request: request)
    }
}

final class ContentLoggingRequestHandler: CORRequestHandler {
    
    override init(nextHandler: RequestHandlerProtocol?) {
        super.init(nextHandler: nextHandler)
    }
    
    override func handler(request: Request) {
        print("로깅 핸들러")
        super.handler(request: request)
    }
}
