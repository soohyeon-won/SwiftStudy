#  GCD

## 애플의 멀티스레딩과 병렬처리를 지원하는 프로그래밍 기술

- 작업을 Queue로 관리
- FIFO
- Main Queue, Background Queue

# 종류
1. 메인 큐(Main Queue)
  + 메인 스레드
  + UI 업데이트
  + 사용자 이벤트 처리

2. 백그라운드 큐(Background Queue)
 + 별도의 스레드에서 작업
 + 병렬처리

3. 디스패치 그룹(Dispatch Group)
  + 여러 작업을 그룹으로 묶어서 동기화
  + 완료 여부 추적가능

4. 디스패치 세마포어(Dispatch Semaphore)
  + 동시에 실행 가능한 작업의 수를 제한하는 세마포어를 사용하여 동시성 제어 가능

## Queue
### 종류
1. Serial Queue
  + 작업을 순차적으로 처리하는 Queue입니다.
  + sync 메서드를 사용하면 현재 작업이 끝날 때까지 대기합니다.

2. Concurrent Queue
  + 작업을 병렬로 처리할 수 있는 Queue입니다.
  + async 메서드를 사용하면 작업을 넘겨주고 바로 다음 코드를 실행합니다.

## concurrent Queue
+ 병렬적 실행
+ 우선순위를 정해줄 수 있음 (Qos: Quality of Service)

## Qos
1. mainQueue: 메인 큐(Main Queue), UI 업데이트와 같은 주요 사용자 인터페이스 작업을 처리하는 큐입니다.
+ userInteractiveQueue: User Interactive 큐, 사용자 상호 작용에 즉각적인 응답이 필요한 작업을 처리하는 큐입니다.
+ userInitiatedQueue: User Initiated 큐, 사용자가 시작한 작업이며, 사용자가 응답을 기다리는 작업을 처리하는 큐입니다.
+ defaultQueue: Default 큐, userInitiated와 utility 사이의 중간 우선순위 작업을 처리하는 큐입니다.
+ utilityQueue: Utility 큐, 시간이 걸리는 작업이며, 즉각적인 응답이 필요하지 않은 경우를 처리하는 큐입니다.
+ backgroundQueue: Background 큐, 눈에 보이지 않는 작업을 처리하는 큐로, 완료 시간이 중요하지 않은 작업을 처리합니다.
+ unspecifiedQueue: Unspecified 큐, 명시되지 않은 우선순위를 가지는 큐로, 기본 우선순위를 사용하는 작업을 처리합니다.

## 개념
- 비동기(Asynchronous): 작업을 큐에 넣고 다른 작업을 실행하는 동안 대기하지 않고 진행
- 동기(Synchronous): 큐에 있는 이전 작업이 완료될 때까지 대기

## DispatchWorkItem
- 수행 할 수 있는 task를 캡슐화
- wait(), cancel(), isCancelled 등 작업 취소가 가능하다
+ DispatchQueue에서 작업을 취소해야 하는 경우에는 DispatchWorkItem을 활용하여 작업을 캡슐화하고, 필요한 경우에는 해당 DispatchWorkItem을 취소하는 방식을 사용하는 것이 일반적입니다
