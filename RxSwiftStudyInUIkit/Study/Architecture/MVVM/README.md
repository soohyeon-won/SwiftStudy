# [ MVVM Architecture ]

#### Model - View - ViewModel
        
- ViewModel이 View와 Model을 중개
- ViewModel은 View에서 발생한 이벤트를 처리
- Model에서 필요한 데이터를 가져와서 View에 표시될 데이터로 가공
- View와 ViewModel이 분리되어 있고 ViewModel은 Model을 알고 있음

## [ 장점 ]

- ViewModel은 View와 상관 없이 독립적으로 작성되며, UI와 관련 없는 비즈니스 로직을 처리하기 때문에 다른 View에서도 재사용하기 용이
- viewModel은 테스트하기 쉬워서, TDD(Test Driven Development) 방법론을 적용하여 개발할 때 유용
- 데이터 바인딩을 통해 반응형 UI를 쉽게 구현 가능

## [ 단점 ]

- 애플리케이션의 규모가 작은 경우에는 너무 많은 추상화가 필요할 수 있다.
