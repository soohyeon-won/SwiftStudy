#  SwiftUI study 내용 정리

**SafeArea**

| Operation | Example | Explain |
|:---:| :--- | :--- |
| ignoresSafeArea |  | 뷰가 전체 Safe Area를 무시하도록 지정 |
| edgesIgnoringSafeArea(.bottom) |  | Safe Area의 아래쪽 경계를 무시하도록 지정 |
| animation(Animation?,Equaltable) | .padding(.bottom, keyboard.currentHeight)<br>.animation(.easeInOut, value: keyboard.currentHeight) | 키보드 높이에 의해 해당 화면의 bottomInset변경\n애니메이션을 추가하면 자연스러워진다 |
  
  
**Property Wrapper**

| Property Wrapper | Example | Explain |
|:---:| :--- | :--- |
| Property Wrapper |  | 속성을 감싸고 해당 속성에 추가적인 동작을 적용하는 기능 |
| @State |  | - SwiftUI의 상태 관리를 위해 사용됨.<br>- 변경 가능한 값으로 선언되며, 값의 변경을 감지하여 뷰를 자동으로 업데이트함.<br>- 주로 뷰 내부에서 사용됨. |
| @Binding |  | - 속성을 다른 뷰와 바인딩하기 위해 사용됨.<br>- 값을 읽고 쓸 수 있는 양방향 바인딩을 제공함.<br>- 주로 상위 뷰에서 하위 뷰로 데이터를 전달하거나, 하위 뷰에서 상위 뷰의 상태를 업데이트하는 데 사용됨. |  
| @ObservedObject |  | - 관찰 가능한 객체를 사용하기 위해 사용됨.<br>- 외부에서 객체를 주입받아 사용하며, 객체의 변경을 감지하여 뷰를 업데이트함.<br>- 주로 클래스로 구현된 관찰 가능한 모델을 사용할 때 사용됨. |  
| @EnvironmentObject |  | - 환경 객체를 사용하기 위해 사용됨.<br>- 외부에서 환경 객체를 주입받아 사용하며, 앱 전역에서 공유되는 데이터를 제공함.<br>- 주로 앱의 공통 상태를 관리하는 데 사용됨. |  
| @Published |  | - ObservableObject 프로토콜을 준수하는 클래스에서 사용됨.<br>- 속성을 감싸고 변경 사항을 자동으로 알림.<br>- 클래스 내부에서 didSet을 구현하지 않고도 값의 변경을 감지할 수 있음. |  
| ObservableObject 프로토콜 |  | - 관찰 가능한 객체를 정의하기 위해 사용됨.<br>- @Published 속성을 사용하여 값의 변경을 알릴 수 있음.<br>- objectWillChange을 통해 속성 변경을 알림. |  
