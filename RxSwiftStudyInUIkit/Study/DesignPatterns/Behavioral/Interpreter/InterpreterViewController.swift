//
//  InterpreterViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import SwiftUI

struct InterpreterView: View {
    
    private let textViewContent: String = """
        [ 인터프리터 패턴 ]
        - 컴퓨터 사이언스 내에서는 사람이 작성한 코드를 기계가 읽을 수 있도록 작동시켜주는 컴파일러 같은 것들 / 현실서는 통역자, 연주자 같은 경우를 예시로 볼 수 있다.
        - 정규표현식도 예제로 볼 수 있다.
        - 자주 등장하는 문제를 간단한 언어로 정의하고 재사용하는 패턴
        - 반복되는 문제 패턴을 언어 또는 문법으로 정의하고 확장할 수 있다.
        - 요청을 캡슐화 하여 호출자와 수신자를 분리하는 패턴
        
        [구조도]
        Context
        ↑
        Expression(Interface) <- TerminalExpression
                              <- NonTerminalExpression
        
        추상 구문 트리(abstract syntax tree, AST)
        
        [장점]
        - 자주 등장하는 문제 패턴을 언어와 문법으로 정의할 수 있다.
        - 기존 코드를 변경하지 않고 새로운 Expression을 추가할 수 있다.
        
        [단점]
        - 복잡한 문법을 표현하려면 Expression과 Parser가 복잡해진다.
        """
    
    var body: some View {
        VStack {
            ScrollView {
                Text(textViewContent)
                    .font(.system(size: 24))
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(8)
                
                CodeView(code: """
                // 예제 샘플 부동산 조건 생성
                let sizeCondition = SizeExpression(minSize: 50, maxSize: 100)
                let priceCondition = PriceExpression(minPrice: 200, maxPrice: 1000)
                let locationCondition = LocationExpression(location: "Seoul")

                // 복합 조건 생성: (size > 50 AND price >= 200 AND price <= 1000) OR location == 'Seoul'
                let searchCondition = OrExpression(
                    AndExpression(sizeCondition, priceCondition),
                    locationCondition
                )

                // 서버 요청에 필요한 쿼리 파라미터 생성
                let queryParams = searchCondition.interpret()

                // (가격시작값='50.0',가격종료값='100.0'&price>=200.0&price<=1000.0)|(location='Seoul')
                print("Query Parameters: \\(queryParams)")
                """)
            }
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .onAppear {
                client()
            }
        }
    }
    
    private func client() {
        // 예제1 수식
        // 1 + 2 - 5 <- Infix
        // 1 2 5 + - <- postfix == 1-(2+5)
        
        // 예제2 샘플 부동산 조건 생성
        let sizeCondition = SizeExpression(minSize: 50, maxSize: 100)
        let priceCondition = PriceExpression(minPrice: 200, maxPrice: 1000)
        let locationCondition = LocationExpression(location: "Seoul")

        // 복합 조건 생성: (size > 50 AND price >= 200 AND price <= 1000) OR location == 'Seoul'
        let searchCondition = OrExpression(
            AndExpression(sizeCondition, priceCondition),
            locationCondition
        )

        // 서버 요청에 필요한 쿼리 파라미터 생성
        let queryParams = searchCondition.interpret()

        print("Query Parameters: \(queryParams)")
    }
}

// Expression 프로토콜이 이제 서버 요청 파라미터를 반환
protocol Expression {
    func interpret() -> String
}

// Context: 부동산 검색에 필요한 데이터
struct RealEstateContext {
    let price: Double
    let location: String
    let size: Double
}

// 가격 조건 Expression
class PriceExpression: Expression {
    private let minPrice: Double
    private let maxPrice: Double

    init(minPrice: Double, maxPrice: Double) {
        self.minPrice = minPrice
        self.maxPrice = maxPrice
    }

    func interpret() -> String {
        return "price>=\(minPrice)&price<=\(maxPrice)"
    }
}

// 크기 조건을 위한 Expression
class SizeExpression: Expression {
    private let minSize: Double
    private let maxSize: Double

    init(minSize: Double, maxSize: Double) {
        self.minSize = minSize
        self.maxSize = maxSize
    }

    func interpret() -> String {
        return "가격시작값='\(minSize)',가격종료값='\(maxSize)'"
    }
}

// 위치 조건 Expression
class LocationExpression: Expression {
    private let location: String

    init(location: String) {
        self.location = location
    }

    func interpret() -> String {
        return "location='\(location)'"
    }
}

// AND 표현식
class AndExpression: Expression {
    private let expr1: Expression
    private let expr2: Expression

    init(_ expr1: Expression, _ expr2: Expression) {
        self.expr1 = expr1
        self.expr2 = expr2
    }

    func interpret() -> String {
        return "\(expr1.interpret())&\(expr2.interpret())"
    }
}

// OR 표현식
class OrExpression: Expression {
    private let expr1: Expression
    private let expr2: Expression

    init(_ expr1: Expression, _ expr2: Expression) {
        self.expr1 = expr1
        self.expr2 = expr2
    }

    func interpret() -> String {
        return "(\(expr1.interpret()))|(\(expr2.interpret()))"
    }
}
