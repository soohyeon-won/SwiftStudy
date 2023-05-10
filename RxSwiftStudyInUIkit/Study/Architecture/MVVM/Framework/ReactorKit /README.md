# [ ReactorKit ]

MVVM 패턴을 기반으로 하며 RxSwift를 사용하여 구현된 라이브러리
상태를 중심으로 앱을 설계

앱의 모든 상태는 하나의 상태 스트림으로 관리되고, 상태 변화는 반응형으로 처리된다.

*View -> Action -> Reactor -> State -> View*

- View
UI들의 action을 reactor에 넘기고, reactor의 state를 구독하고 있는 형태

- Reactor
비지니스 로직 수행, state관리 해서 View에게 전달
Reactor protocol을 준수하여 Reactor를 정의

## Reactor protocol

1. Action
사용자 동작
2. Mutation
State와 Action의 중간다리 역할
3. State
현재 상태를 기록하고 있으며, View에서 해당 정보를 사용하여 UI업데이트
