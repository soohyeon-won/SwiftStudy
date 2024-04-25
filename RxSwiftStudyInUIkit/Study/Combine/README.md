# Combine 학습 커리큘럼

Swift의 Combine 프레임워크는 비동기 프로그래밍과 데이터 흐름을 처리하기 위한 강력한 도구입니다. 다음은 Combine을 공부하기 위한 커리큘럼입니다.

## 1. 기본 개념 이해

- **Reactive Programming**: 반응형 프로그래밍의 개념과 원리 이해.
- **Publishers and Subscribers**: `Publisher`와 `Subscriber`의 역할과 개념 이해.
- **Operators**: Combine에서 사용되는 다양한 연산자들의 역할과 사용 방법 이해.
- **Data Flow**: 데이터 흐름의 개념과 Combine에서 어떻게 처리되는지 이해.

## 2. Combine의 핵심 구성 요소

- **Publishers**: `Just`, `Future`, `PassthroughSubject`, `CurrentValueSubject` 등 다양한 `Publisher`의 사용 방법 이해.
- **Subscribers**: `sink` 및 `assign` 연산자를 사용하여 데이터를 구독하고 처리하는 방법 이해.
- **Cancellables**: 구독을 취소할 수 있는 `Cancellable`의 개념과 사용 방법 이해.

## 3. Combine 연산자

- **Mapping Operators**: `map`, `compactMap`, `flatMap` 등 데이터를 변환하는 연산자 이해.
- **Filtering Operators**: `filter`, `removeDuplicates` 등 데이터를 필터링하는 연산자 이해.
- **Combining Operators**: `merge`, `zip`, `combineLatest` 등 여러 `Publisher`를 결합하는 연산자 이해.
- **Error Handling Operators**: `catch`, `retry` 등을 사용하여 오류를 처리하는 방법 이해.

## 4. 실전 예제

- **Combine을 활용한 네트워크 요청**: Combine을 사용하여 네트워크 요청을 수행하고 데이터를 처리하는 예제.
- **UI와 데이터 바인딩**: Combine을 사용하여 UI와 데이터의 바인딩을 구현하는 예제.
- **데이터 흐름 처리**: Combine을 사용하여 데이터 흐름을 관리하고 반응형 프로그래밍을 적용하는 예제.

## 5. 고급 주제

- **Backpressure**: Combine에서 데이터 흐름의 속도를 조절하는 `Backpressure`의 개념 이해.
- **Custom Publishers and Subscribers**: 사용자 정의 `Publisher`와 `Subscriber`를 구현하는 방법 이해.
- **Debugging and Performance**: Combine 코드의 디버깅 및 성능 최적화 기법 이해.

## 6. Combine 프로젝트 구축

- **실전 프로젝트**: Combine을 사용하여 실제 프로젝트를 구축하고 적용해보는 연습.
- **문제 해결 및 개선**: 프로젝트에서 발생하는 문제를 해결하고 코드를 개선하는 방법 연습.
