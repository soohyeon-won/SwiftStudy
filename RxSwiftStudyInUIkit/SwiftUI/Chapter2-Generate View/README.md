#  SwiftUI Chapter2. 뷰 구성하기

## 1) UIKit과 SwiftUI 비교

[ Views and controls ]

| UIKit | SwiftUI |
|:---:| :--- |
|UILabel | Text |
|UITextFiled | TextField |
|UIButton|Button|
|UISwitch|Toggle|
|UITextView|동일 요소 없음|

[ ViewController ]

| UIKit | SwiftUI |
|:---:| :--- |
|UIViewController | View |
|UINavigationCotroller | NavigationView |
|UITabbarViewController |TabView|
|UISplitViewController| NavigationView |
|UITableViewController|List|
|UICollectionViewController|동일 요소 없음|
|UIAlertController(actionSheet스타일)|ActionSheet|
|UIAlertController(alert스타일)|Alert|

## 2) 텍스트(Text)
* Button, Picker, Toggle 등 다양한 뷰에서 UI를 구성할때 사용하는 경우가 많아 UILabel보다 활용범위가 넓다.

## 3) Opaque Type (= 리버스 제네릭)

 불투명 결과 타입(Opaque Result Types)
 불투명 반환 타입(Opaque Return Type)
 
 var body: some View { ... }
 
 여기서 some이란 뭘까?
 some을 제거해보자
 
 오류가 두개 발생할것이다
 1. 타입 유추 실패
 2. 뷰 프로토콜의 조건을 만족하지 않는다는 오류
 
 이 때, 이를 
 
  ```
 var body: Text {
    Text("Hello SwiftUI!")
 }
  ```
 로 수정하면 오류가 사라진다
 
  ```
 var body: Text {
    Text("Hello SwiftUI!")
     .forgroundColor(.white)
     .background(Color.black)
 }
  ```
 
 하지만 이렇게 하면!?
 
 ```
 var body: ModifiedContent<Text, _BackgroundModifier<Color>> {
 ```
 
 이렇게 바꿔줘야함
 + 이를 실제 타입(concrete type)을 반환했다 라고함
 
 수식어에 따라 반환타입이 길어진다 (맙소사!)
 
 SwiftUI의 경우 제네릭을 적극적으로 활용하고 있기 때문에 뷰를 추가하거나 변경할때 '새로운 타입'이 만들어지고 있는것임
 
 타입 정보를 숨기고 프로토콜에 대한 정보만 남긴 채 API를 사용할 수 있도록 도와주는 것을 불투명 결과/반환 타입 이라고 알고 사용하면 된다
 
 이렇든 Opaque type은 컴파일러만 정확한 타입 정보에 접근하게함
 
##3) 타입 추상화

제네릭은 코드를 호출하는 측(caller)에서 호출되는 측(callee)의 타입을 결정
불투명 타입은 callee의 가 caller의 타입을 결정

## 4) 정적 타입 시스템

정적 타입 시스템에서만 불투명성이 유지된다
런타임에서는 타입이 드러난다

## 5) 타입 정체성
기존처럼 Protocol을 사용하는 것
> 장점: 유연함

> 단점: 호출시에 다른 타입이 반환될 수 있다는 점 때문에 타입에 대한 정보를 잃음

``` swift
protocol P {}
struct SomeType: P {}
func nested<T: P>(_ param: T) -> P {
    param
}
let foo: P = nested(SomeType())
let bar = nested(foo)
```

책에는 컴파일이 안된다고 써있는데 컴파일은 아주잘된다.

대충 내용은 알겠음 

``` 
protocol B {}
protocol A: B {}
func nested<T: A>(_ param: T) -> B {
    param
}

struct Test: A { }

let foo = nested(Test()) // A프로토콜은 B를 채택하고 있음, B로 리턴되어 현재는 B
let test = nested(foo) // foo는 A이기도 한데 무조건 B를 데려와 썩 꺼져! 라고 하는 상황
```

또한 프로토콜은 타입에 대해 명시가 되었거나 추론할 수 있는 경우에만 사용할 수 있다는 단점이 있음

```
func someProperty() -> Hashable // 컴파일 에러남
var somePropert: Collection { ... } // 얘도
```

아무튼!

#### 이러한 단점을 불투명 타입으로 보완가능 (아래 2가지를 강제하여)

1. 반환값은 반드시 실체 타입이어야 한다는 점.
2. 값은 다를지언정 타입은 반드시 동일해야 한다는 것

이게 뭔소리냐?

- 1. 실제 타입

``` 
func returnConcreteType() - some Animal {
    let result: Animal = Dog()
    return result  // 컴파일 오류
    // type 'Animal' cannot conform to 'Animal' because only concrete types can conform to protocols 
}
``` 
Dog를 리턴해주면 문제가 해결됨
프로토콜 대신 실체 타입만 반환하게 함

- 2. 동일 타입

``` 
func genericFunc<T: Equatable>(lhs: T, rhs: T) -> Bool
/// lhs, rhs의 타입은 항상 동일함

genericFunc(lhs: "Swift", rhs:"UI) // 호출하는 코드가 타입 정보 제공
``` 

자 이제 불투명 타입은 리버스 제네릭이라 하였다

``` 
func opaqueTypeFunc() -> some Equatable {
    .random() ? "swift" : "UI" // 만약 반환타입이 달라지면? String : Int 로 가게되면 컴파일 에러남 
}
``` 

X 안됨
``` 
return .random() ? Rectangle() : Circle()
``` 

O 됨
``` 
return .random() ? AnyView(Rectangle()) : AnyView(Circle())
``` 

+++ 참고 AnyView는 View를 리턴함 @frozen도 공부해야겠다 이놈은 뭐시여..

```
@frozen public struct AnyView : View {

    /// Create an instance that type-erases `view`.
    public init<V>(_ view: V) where V : View
```

some 키워드는 프로퍼티와 첨자, 함수 반환타입에 적용 가능
some 다음에 올 수 있는 타입은 protocol, class, Any, AnyObject로 한정

## 정리

### 불투명 타입의 장점
- 구현 숨김: some 키워드는 구현을 추상화하여 프로토콜을 따르는 어떤 구현체를 반환하여 코드의 의도를 명확하게 함.
- 간결성: some을 사용하면 코드가 더 간결해지며, 구현체의 실제 타입을 명시할 필요 없이 프로토콜을 따르는 구현체를 반환함.
- 유연성: 불투명한 타입은 반환되는 구체적인 타입을 변경할 수 있어 코드를 유연하게 함.

### 불투명 타입의 단점
- 몇 가지 제한과 함께 사용해야 할 때도 있음
- 때로는 명시적인 타입이 더 명확할 수 있음 

> 불투명 타입인 some을 선택하는 좋은 예시 중 하나는 SwiftUI의 some View 를 보면 됨!
