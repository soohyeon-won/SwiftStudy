# Any 😜
I was organizing what I studied

It was diffrent with 'TIL'

because i just organized what i learned from time to time.

## [Date] contents...

## [22.09.29] 

1. performBatchUpdate 를 이용하면 애니메이션이 끝나는 시점을 알고 이를 컨트롤 할 수 있다.
2. ExpyTableView 라이브러리는 항상 펼쳐질 cell 개수를 리턴해주기만 하면됨 (crash X)
3. trottle last: false 를 이용하면 마지막 값은 구독되지않음
4. stackView를 사용할 때에는 trailing, leading 과 같은 마진이 소용없음으로 주의해야함

## [22.10.12]
 
1. stackView Inset 추가 

```
tabStackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
tabStackView.isLayoutMarginsRelativeArrangement = true
```
## [23.06.06]

SPM vs Cocoapods

* SPM (Swift Package Manager): Xcode의 기본 빌드 시스템과 원활하게 통합되고 Swift 언어에 특화되어 있다. <br> Xcode의 기본 빌드 시스템과 원활하게 통합되어 Xcode에서 프로젝트를 더 편리하게 관리할 수 있음<br>Package.swift 파일에서 원하는 패키지 버전을 명시하고 업데이트할 수 있음.<br> 기본 빌드 시스템과 원활하게 통합된다는 것은 
Xcode에서 SPM을 사용하여 프로젝트의 패키지 의존성을 관리하고, 패키지를 다운로드하고 빌드하여 프로젝트에 통합할 수 있다는 것을 의미.

* CocoaPods: 다양한 라이브러리와 프레임워크의 버전 관리와 종속성 해결을 유연하게 제공 <br>CocoaPods는 중앙 집중식 저장소를 통해 다양한 라이브러리와 프레임워크를 검색하고 설치할 수 있음, CocoaPods는 종속성 간의 충돌을 해결하고, 프로젝트에 필요한 특정 버전의 라이브러리를 선택하여 관리할 수 있는 기능을 제공 (with Podfile)

- 요약: SPM은 Xcode와 잘 맞으며 Swift 패키지에 적합하고, CocoaPods는 다양한 라이브러리와 함께 objectC도 지원
