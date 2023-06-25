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

## 개념
- 비동기(Asynchronous): 작업을 큐에 넣고 다른 작업을 실행하는 동안 대기하지 않고 진행
- 동기(Synchronous): 큐에 있는 이전 작업이 완료될 때까지 대기
