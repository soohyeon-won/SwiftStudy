#  SwiftUI Chapter1. Hello, SwiftUI

## SwiftUI의 4가지 원칙

1. 선언형
    * How 보다는 What이 중요
    * 코드량이 줄고 읽기 쉬움
2. 자동화
    * 생산성 증대
    * 단순화된 코드로 원하는 동작을 이끌어 낼 수 있도록 변경됨
3. 조합
    * 뷰의 조합과 분리를 간단히 할 수 있도록 제공
    * 컴포넌트화 하여 재사용하기 편리
    * 뷰 프로토콜에 다양한 공용 수식어 제공
4. 일관성
    * 데이터와 동기화
    
### Tip
```
Text("선언형") // 뷰
    .font(.title) // 수식어
```

## 프로젝트 생성하기
* macOS Catalina 10.15 이상 지원
* Xcode 11.0 버전 이상

## 캔버스 이용하기
[ 단축키 ]

* 프리뷰 실행 : Command + Option + P
* 프리뷰 보기 : Command + Option + Enter

PreviewProvider 프로토콜을 준수하는 타입이 구현되어있는 뷰에서 나타남

## ContentView 살펴보기
* protocol View 
    * 기존 UIview와 달리 프로토콜로 선언됨

```
protocol View {
    associatedtype Body: View
    var body: Self.Body { get }
}
```
* 읽기전용의 body 연산 프로퍼티를 필수로 구현
* body프로퍼티에서 반환해야 하는 타입이 또 뷰 프로토콜을 준수하는 타입
* SwiftUI의 Text, Image, Color처럼 실제 콘텐츠를 표현하는 기본 뷰(Primitive Views)와 Stack, Group, GeometryReader 같은 컨테이너 뷰는 아래와 같은 Never타입 사용

```
typealias Body = Never
```

## UIHostingController
* UIViewController를 상속받는 제내릭 클래스
* swiftUI를 이용해 만들어진 뷰를 UIkit의 개발 환경에서 사용해야 할 때 사용
* SceneDelegate.swift

```
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    let contentView = ContentView()
    window.rootViewController = UIHostingView(rootView: contentView)
}
```

## 코드 수정하기
* 메서드 체이닝
* 라이브러리 오픈 단축키 : Command + Shift + L
* Inspector 오픈 단축키 : control + option + 클릭

# Swift 문법 이야기
* Omit Return(SE-0255)
    * 리턴 생략(Omit Return) : 단일 표현식이 사용된 함수에 대해 클로저와 동일하게 리턴 키워드 생략가능
    
