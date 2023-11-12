#  SwiftUI Chapter2. 뷰 구성하기

## 1) UIKit과 SwiftUI 비교

[ Views and controls ]

| UIKit | SwiftUI |
|:---:| :--- |
|UILabel | Text |
|UITextFiled | TextField |
|UIButton|Button|
|UISwitch|Toggle|
|UITextView|동일 요소 없음|

[ ViewController ]

| UIKit | SwiftUI |
|:---:| :--- |
|UIViewController | View |
|UINavigationCotroller | NavigationView |
|UITabbarViewController |TabView|
|UISplitViewController| NavigationView |
|UITableViewController|List|
|UICollectionViewController|동일 요소 없음|
|UIAlertController(actionSheet스타일)|ActionSheet|
|UIAlertController(alert스타일)|Alert|

## 2) 텍스트(Text)
* Button, Picker, Toggle 등 다양한 뷰에서 UI를 구성할때 사용하는 경우가 많아 UILabel보다 활용범위가 넓다.
