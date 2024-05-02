## 1. 기본 개념 이해

- **Reactive Programming**:
    - Reactive Programming(반응형 프로그래밍)은 이벤트와 데이터 흐름을 중심으로 동작하는 프로그래밍 패러다임입니다.
    - 데이터 흐름과 이벤트의 변화에 따라 시스템이 반응하며 동작하는 것을 목표로 합니다.
    - 이벤트가 발생할 때마다 시스템이 반응하도록 코드를 작성하는 것이 특징입니다.

- **Publishers and Subscribers**:
    - `Publisher`는 데이터를 생성하고 배포하는 주체입니다.
    - `Subscriber`는 `Publisher`에서 생성된 데이터를 구독하고 처리하는 주체입니다.
    - `Publisher`와 `Subscriber` 간의 관계는 Combine에서 데이터 흐름을 관리하고 처리하는 핵심 구조입니다.

- **Operators**:
    - Combine에서 사용되는 다양한 연산자들은 데이터 흐름을 조작하거나 변형하는 역할을 합니다.
    - `Mapping Operators`, `Filtering Operators`, `Combining Operators`, `Error Handling Operators` 등의 다양한 연산자 유형이 있습니다.
    - 연산자들을 통해 데이터를 가공하고 원하는 결과를 얻을 수 있습니다.

- **Data Flow**:
    - 데이터 흐름은 `Publisher`에서 생성된 데이터를 `Subscriber`가 구독하고 처리하는 과정을 말합니다.
    - Combine을 사용하면 데이터 흐름을 효율적으로 관리하고 제어할 수 있습니다.
    - 데이터 흐름을 조작하여 원하는 방식으로 데이터를 처리할 수 있습니다.

## 2. Combine의 핵심 구성 요소

- **Publishers**:
    - `Just`, `Future`, `PassthroughSubject`, `CurrentValueSubject` 등 다양한 `Publisher`의 사용 방법을 이해합니다.
    - `Just`는 단일 값을 즉시 생성하는 `Publisher`입니다.
    - `Future`는 비동기 작업의 결과를 전달하는 `Publisher`입니다.
    - `PassthroughSubject`는 데이터 흐름을 제어하고 관찰할 수 있는 `Publisher`입니다.
    - `CurrentValueSubject`는 현재 값과 관련된 데이터를 구독할 수 있는 `Publisher`입니다.

- **Subscribers**:
    - `sink` 연산자를 사용하여 `Publisher`의 데이터를 구독하고 처리하는 방법을 이해합니다.
    - `assign` 연산자를 사용하여 `Publisher`의 데이터를 객체의 속성에 할당하는 방법을 이해합니다.
    - `Subscriber`는 `Publisher`의 데이터를 수신하고 처리하며, `Cancellable`을 사용하여 구독을 관리할 수 있습니다.

- **Cancellables**:
    - 구독을 취소할 수 있는 `Cancellable`의 개념과 사용 방법을 이해합니다.
    - `Cancellable`을 사용하여 데이터 흐름을 중지하거나 구독을 취소할 수 있습니다.
    - `Cancellable`을 통해 메모리 관리와 데이터 흐름 제어를 효과적으로 수행할 수 있습니다.
    
## 2-1. property wrapper
- @StateObject와 @ObservedObject는 SwiftUI에서 ObservableObject를 관리하기 위한 "속성 래퍼"

| 속성 래퍼       | 특징                                 | 사용 경우                                       |
|--------------|-----------------------------------|---------------------------------------------|
| `@StateObject` | - 뷰가 `ObservableObject`를 직접 생성하고 소유합니다.  <br> - 뷰의 생명 주기에 따라 객체가 생성 및 해제됩니다. <br> - 객체의 수명 주기를 뷰가 직접 관리합니다. | - 뷰 내부에서 독립적으로 객체를 생성 및 관리할 때 <br> - 뷰와 객체의 생명 주기를 일치시켜야 할 때 |
| `@ObservedObject` | - 객체를 외부에서 전달받아 관리합니다. <br> - 뷰의 수명 주기와 객체의 수명 주기가 분리됩니다. <br> - 특정 뷰에서만 객체를 관찰하고 관리합니다. | - 외부에서 전달받은 객체를 관리할 때 <br> - 객체가 뷰 외부에서 초기화된 경우 <br> - 상위 뷰나 객체에서 전달받은 데이터를 관찰할 때 |
| `@EnvironmentObject` | - 환경에 주입된 `ObservableObject`를 뷰 트리 전체에서 공유합니다. <br> - 상위 뷰에서 객체를 주입하고, 하위 뷰에서 관찰합니다. | - 뷰 트리 전체에서 동일한 객체를 공유하고 관찰할 때 <br> - 상위 뷰에서 객체를 주입하고, 하위 뷰에서 사용해야 할 때 |


## 3. Combine 연산자

- **Mapping Operators**:
    - `map`: 입력된 데이터를 변환하여 새로운 데이터로 매핑합니다.
    - `compactMap`: `map`과 유사하지만, nil 값을 제외하고 결과를 반환합니다.
    - `flatMap`: 다른 `Publisher`를 중첩적으로 펼치고 결과를 단일 `Publisher`로 결합합니다.

- **Filtering Operators**:
    - `filter`: 조건을 만족하는 데이터만 전달합니다.
    - `removeDuplicates`: 연속된 중복 데이터를 제거하고 유일한 값만 전달합니다.
    - `first` 및 `last`: 첫 번째 또는 마지막 데이터를 수신하여 전달합니다.
    - `dropWhile` 및 `dropUntilOutput`: 지정된 조건에 따라 데이터의 일부를 생략합니다.

- **Combining Operators**:
    - `merge`: 여러 `Publisher`를 하나의 `Publisher`로 병합하여 데이터를 순차적으로 전달합니다.
    - `zip`: 여러 `Publisher`에서 동시에 데이터를 수신하여 결합합니다.
    - `combineLatest`: 여러 `Publisher`의 최신 데이터를 결합하여 전달합니다.
    - `withLatestFrom`: 한 `Publisher`의 최신 데이터를 다른 `Publisher`의 데이터와 결합합니다.

- **Error Handling Operators**:
    - `catch`: 오류가 발생했을 때 대체 `Publisher`를 실행하여 오류를 처리합니다.
    - `retry`: 오류가 발생했을 때 지정된 횟수만큼 재시도합니다.
    - `assertNoFailure`: 오류 없이 성공적으로 완료되었다는 확신을 가집니다.
    - `replaceError`: 오류가 발생했을 때 대체 데이터로 처리합니다.
    
## 4. 실전 예제

Combine을 활용한 실전 예제를 통해 실제 상황에서 Combine을 어떻게 사용하는지 학습할 수 있습니다.

- **Combine을 활용한 네트워크 요청**:
    - Combine을 사용하여 네트워크 요청을 수행하고 데이터를 처리하는 방법을 학습합니다.
    - `URLSession`을 사용하여 HTTP 요청을 만들고, 결과를 `Publisher`로 반환합니다.
    - JSON 데이터와 같은 응답 데이터를 디코딩하여 사용할 수 있습니다.
    - 에러 처리와 데이터 변환을 위해 Combine 연산자들을 사용합니다.

- **UI와 데이터 바인딩**:
    - Combine을 사용하여 UI와 데이터의 바인딩을 구현하는 방법을 학습합니다.
    - `Publisher`를 사용하여 데이터 흐름을 관찰하고, UI 요소에 데이터를 동기화합니다.
    - `sink` 또는 `assign` 연산자를 사용하여 데이터 변화를 UI에 적용합니다.
    - UI 인터랙션과 데이터를 효과적으로 연결하여 반응형 인터페이스를 구현합니다.

- **데이터 흐름 처리**:
    - Combine을 사용하여 데이터 흐름을 관리하고 반응형 프로그래밍을 적용하는 방법을 학습합니다.
    - `Publisher`를 통해 데이터를 생성하고 처리하며, `Subscriber`를 통해 데이터를 구독합니다.
    - 다양한 Combine 연산자들을 사용하여 데이터의 흐름을 조작하고 변환합니다.
    - 데이터 흐름을 관리하고 처리하는 방법을 익혀 Combine을 효과적으로 활용할 수 있습니다.

## 5. 고급 주제

Combine 프레임워크를 심도 있게 이해하고 활용하기 위해 고급 주제들을 학습합니다.

- **Backpressure**:
    - `Backpressure`는 데이터 흐름의 속도를 조절하여 `Publisher`와 `Subscriber` 간의 균형을 유지하는 개념입니다.
    - `Subscriber`가 데이터를 처리하는 속도가 느린 경우, `Publisher`가 너무 많은 데이터를 빠르게 전달하는 것을 방지합니다.
    - `Demand`를 조절하여 `Publisher`에 데이터 생산을 제어할 수 있습니다.

- **Custom Publishers and Subscribers**:
    - 사용자 정의 `Publisher`와 `Subscriber`를 구현하는 방법을 학습합니다.
    - `Publisher`와 `Subscriber` 프로토콜을 구현하여 고유한 데이터 흐름을 정의합니다.
    - 사용자 정의 `Publisher`는 특정 데이터 소스를 반영하거나 고유한 데이터 흐름을 생성할 수 있습니다.
    - 사용자 정의 `Subscriber`는 데이터 수신 및 처리를 원하는 방식으로 제어할 수 있습니다.

- **Debugging and Performance**:
    - Combine 코드를 디버깅하고 성능을 최적화하는 방법을 학습합니다.
    - `print` 연산자 또는 디버거를 사용하여 데이터 흐름을 모니터링하고 디버깅합니다.
    - 성능 병목 현상을 최소화하기 위해 병렬 실행 및 연산자 선택을 고려합니다.
    - 메모리 관리를 위한 `Cancellable` 및 `Subscribers`의 올바른 활용법을 배웁니다.
