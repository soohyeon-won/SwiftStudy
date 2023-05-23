# Ribs
<Strong>RIBs(Reduced Instruction Set Building Blocks)</Strong>는 Uber에서 개발한 모바일 애플리케이션 아키텍처 패턴
RIBs는 모바일 애플리케이션에서 크고 복잡한 기능을 다루는데 적합하며, 유지보수성과 확장성을 향상시키는데 도움이 됩니다.

RIBs는 기능 단위로 모듈화되어 있다.
기능은 대개 독립된 작업 흐름을 가지고 있으며, 입력을 받아 처리하고 출력을 생성
이러한 기능은 RIB이라고 불리는 모듈로 나타낼 수 있음

RIB => (Interactor, Router, Builder)

- Interactor: RIB의 핵심 비즈니스 로직을 처리, 다른 RIB들과의 상호작용을 처리. 다른 RIBs와 연결되어 있으며, 외부로부터 전달받은 입력에 따라 적절한 출력을 생성
- View: Interactor로부터 입력을 받아 화면을 그리고, 사용자 입력에 대한 이벤트를 Interactor로 전달
- Router: 다른 RIBs와의 연결을 관리, 현재 RIB을 이동시키는데 사용. 애플리케이션 내에서 다른 RIBs로의 이동 및 연결을 담당
- Builder: RIB의 구성을 담당합니다. 새로운 RIBs를 생성하고, 필요한 의존성을 주입합니다.

이러한 구성요소들은 서로 강한 의존성을 가지고 있으며 Hierarchical Structure을 가짐. 
즉, 한 RIB이 다른 RIB의 부모가 될 수 있으며, RIB들 간의 관계는 Tree 형태로 구성됨

Ribs Template를 설치할 수 있음

## [ 장점 ]
- 큰 규모의 애플리케이션 개발에 적합 
- 코드의 재사용성이 높아지고 유지보수가 용이, 테스트하기 쉬운 구조

>https://github.com/uber/RIBs
>
>https://pfxstudio21.medium.com/architecture-ribs-290b68829be1
>youtube.com/watch?v=3XS6xLzKRjc
