//
//  FacadeViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/11.
//

import UIKit

final class FacadeViewController: UIViewController {
    
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
        [ 퍼사드 패턴 ]
        건물의 외관, 입구쪽을 바라본 전경
        건물 안에 뭐가 있는지는 알 수 없음
        유연한 개발을 위해 약결합 시스템(Loosely Coupled System) 에 대해 생각해보아야 함
        
        클라이언트가 사용해야 하는 복잡한 서브 시스템 의존성을 간단한 인터페이스로 추상화 할 수 있다.
        복잡한 기능은 퍼사드 뒤로 숨김
        
        [장점]
        서브 시스템에 대한 의존성을 한 곳으로 모을 수 있다.
        
        [단점]
        퍼사드 클래스가 서브 시스템에 대한 모든 의존성을 가지게 된다.
        코드가 읽기 편해지면 리팩토링을 했다라고 생각한다(by 백기선)
        내부구조를 디테일하게 알지 않아도됨
        
        """
        
        client()
    }
    
    private func client() {
        // email을 보내는 기능을 여러곳에서 쓴다고 했을때 유용하게 쓸 수 있다.
        // 각각 interface를 두고 개발하면 다른 Sender들을 적용시킬 수 있음
        let emailSettings = EmailSettings(host: "127.0.0.1")
        let emailSender = EmailSender(emailSetngs: emailSettings)
        let emailMessage = EmailMessage(title: "오징어게임", text: "밖은 더 지옥이더라고..", to: "나", from: "너")
        
        emailSender.sendEmail(emailMessage: emailMessage)
    }
}

class EmailSender {
    
    let emailSetngs: EmailSettings
    
    init(emailSetngs: EmailSettings) {
        self.emailSetngs = emailSetngs
    }
    
    func sendEmail(emailMessage: EmailMessage) {
        print("send email use this settings - host: \(emailSetngs.host)")
        print("send email - from: \(emailMessage.from) title: \(emailMessage.title)")
    }
}

class EmailSettings {
    var host: String
    
    init(host: String) {
        self.host = host
    }
}

class EmailMessage {
    let title: String
    let text: String
    let to: String
    let from: String
    
    init(title: String, text: String, to: String, from: String) {
        self.title = title
        self.text = text
        self.to = to
        self.from = from
    }
}
