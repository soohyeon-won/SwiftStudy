//
//  StrategyViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class StrategyViewController: UIViewController {
    
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
        [ 전략 (Strategy) 패턴 ]
        - 여러 알고리듬을 캡슐화하고 상호 교환 가능하게 만드는 패턴.
        • 컨텍스트에서 사용할 알고리듬을 클라이언트 선택한다.
        - 객체가 특정 동작을 수행하는 데 있어 다양한 전략을 가질 수 있을 때, 동적으로 전략을 선택하여 사용하는 디자인 패턴
        
        [장점]
        • 새로운 전략을 추가하더라도 기존 코드를 변경하지 않는다.
        • 상속 대신 위임을 사용할 수 있다.
        • 런타임에 전략을 변경할 수 있다.
        
        [단점]
        • 복잡도가 증가한다.
        • 클라이언트 코드가 구체적인 전략을 알아야 한다.
        
        [사용 예제]
        - 신호등 시스템
        - 결제 시스템
        """
        
        client()
    }
    
    private func client() {
        let creditCardPayment = CreditCardPaymentStrategy(cardNumber: "1234-5678-9101-1121", expirationDate: "05/25", cvv: "123")
        let payPalPayment = PayPalPaymentStrategy(email: "example@gmail.com", password: "password")

        let productPurchaseWithCreditCard = ProductPurchase(paymentStrategy: creditCardPayment)
        productPurchaseWithCreditCard.processPayment(amount: 50.0) // "50.0 달러를 신용카드로 결제했습니다."

        let productPurchaseWithPayPal = ProductPurchase(paymentStrategy: payPalPayment)
        productPurchaseWithPayPal.processPayment(amount: 100.0) // "100.0 달러를 페이팔로 결제했습니다."
    }
}

// 전략 프로토콜
protocol PaymentStrategy {
    func pay(amount: Double)
}

// 신용카드 결제 전략
class CreditCardPaymentStrategy: PaymentStrategy {
    private let cardNumber: String
    private let expirationDate: String
    private let cvv: String
    
    init(cardNumber: String, expirationDate: String, cvv: String) {
        self.cardNumber = cardNumber
        self.expirationDate = expirationDate
        self.cvv = cvv
    }
    
    func pay(amount: Double) {
        print("\(amount) 달러를 신용카드로 결제했습니다.")
    }
}

// 페이팔 결제 전략
class PayPalPaymentStrategy: PaymentStrategy {
    private let email: String
    private let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func pay(amount: Double) {
        print("\(amount) 달러를 페이팔로 결제했습니다.")
    }
}

// 상품 구매 클래스
class ProductPurchase {
    private let paymentStrategy: PaymentStrategy
    
    init(paymentStrategy: PaymentStrategy) {
        self.paymentStrategy = paymentStrategy
    }
    
    func processPayment(amount: Double) {
        paymentStrategy.pay(amount: amount)
    }
}
