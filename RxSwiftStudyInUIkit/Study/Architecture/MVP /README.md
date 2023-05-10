# [ MVP Architecture ]
<strong>Model-View-Presenter</strong>

*presenter : 증여자*

- MVC는 View와 Model사이의 의존성이 존재했지만 MVP에서는 의존성을 제거
- Presenter가 View와 Model 사이의 중개자 역할
- View는 Presenter에 의존
- Presenter는 Model과 View를 알고 있음.
- Presenter는 View에서 이벤트를 수신
필요한 경우 Model을 업데이트하고,
다시 View를 업데이트한다.

>View와 Presenter가 직접적으로 상호작용하며,
View와 Model은 분리되어 있음

#### Presenter
- View와 Model의 중개자 역할. 
- View에서 발생한 이벤트를 처리하고 Model에 대한 요청을 처리하여 View에 표시할 데이터를 생성
Presenter는 View와 Model 간의 결합도를 낮추는 역할
