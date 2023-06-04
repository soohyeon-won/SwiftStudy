#  SwiftUI study 내용 정리

**SafeArea**

  > | Operation | Example | Explain |
  > |:---:| :--- | :--- |
  > | ignoresSafeArea |  | 뷰가 전체 Safe Area를 무시하도록 지정 |
  > | edgesIgnoringSafeArea(.bottom) |  | Safe Area의 아래쪽 경계를 무시하도록 지정 |
  > | animation(Animation?,Equaltable) | .padding(.bottom, keyboard.currentHeight)<br>.animation(.easeInOut, value: keyboard.currentHeight) | 키보드 높이에 의해 해당 화면의 bottomInset변경\n애니메이션을 추가하면 자연스러워진다 |
