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

1. SPM vs Cocoapods

* SPM (Swift Package Manager): Xcode의 기본 빌드 시스템과 원활하게 통합되고 Swift 언어에 특화되어 있다. <br> Xcode의 기본 빌드 시스템과 원활하게 통합되어 Xcode에서 프로젝트를 더 편리하게 관리할 수 있음<br>Package.swift 파일에서 원하는 패키지 버전을 명시하고 업데이트할 수 있음.<br> 기본 빌드 시스템과 원활하게 통합된다는 것은 
Xcode에서 SPM을 사용하여 프로젝트의 패키지 의존성을 관리하고, 패키지를 다운로드하고 빌드하여 프로젝트에 통합할 수 있다는 것을 의미.

* CocoaPods: 다양한 라이브러리와 프레임워크의 버전 관리와 종속성 해결을 유연하게 제공 <br>CocoaPods는 중앙 집중식 저장소를 통해 다양한 라이브러리와 프레임워크를 검색하고 설치할 수 있음, CocoaPods는 종속성 간의 충돌을 해결하고, 프로젝트에 필요한 특정 버전의 라이브러리를 선택하여 관리할 수 있는 기능을 제공 (with Podfile)

- 요약: SPM은 Xcode와 잘 맞으며 Swift 패키지에 적합하고, CocoaPods는 다양한 라이브러리와 함께 objectC도 지원

2. 로컬 디비

* UserDefaults: 간단한 키-값 형태로 데이터를 저장. 간단한 설정 값, 작은 데이터를 저장

* CoreData: 앱 내에서 복잡한 데이터 모델을 관리하기 위한 프레임워크. 객체 지향적인 접근 방식으로 데이터를 저장하고 관리. 주로 대량의 데이터를 구조화하고 영구 저장이 필요한 경우에 사용.

* Realm: 객체 지향적인 접근 방식으로 데이터를 저장하고 관리. 빠른 속도와 유연한 데이터 모델링을 특징으로 합니다.
단점: 약간의 추가 오버헤드가 있을 수 있으며, 데이터베이스 크기가 큰 경우에는 일부 성능 저하가 발생할 수 있습니다.

* SQLite: 경량의 관계형 데이터베이스 엔진. SQL 쿼리를 작성하여 데이터를 조작할 수 있으며, 복잡한 데이터 구조를 지원.

* 파일 시스템: 데이터를 파일로 저장하는 방식. 파일 시스템을 이용하여 데이터를 읽고 쓸 수 있으며, JSON, XML, CSV 등 다양한 형식으로 데이터 저장 가능.

|local DB|장점|단점|
|------|---|---|
|CoreData|Apple의 공식 프레임워크<br>- 데이터의 객체 지향적인 모델링 지원<br>- 데이터 변화 추적 및 자동 관리	- 초기 설정이 복잡|복잡한 데이터 모델에 대한 성능 저하 가능|
|Realm|- 높은 성능<br>- 객체 지향적인 접근 방식<br>- 대용량 데이터 처리에 효과적<br>- 실시간 업데이트를 지원<br> - 다수의 사용자 간에 실시간으로 변경 사항을 공유할 수 있음(Realm 데이터를 클라우드에 동기화하고 여러 디바이스 간에 데이터를 공유)|	- 약간의 추가 오버헤드(데이터 저장 및 검색 작업에 조금 더 많은 작업을 필요)<br> - 객체 지향적인 방식으로 데이터를 다루기 때문에, 객체와 데이터베이스 간의 매핑 및 변환 작업이 필요<br> - 일부 기능 제한적일 수 있음
|SQLite|- 경량 및 뛰어난 성능<br> - 다양한 플랫폼 지원<br> - 유연한 SQL 쿼리 사용 가능|	- SQL 쿼리 작성 필요<br> - 복잡한 인터페이스|
