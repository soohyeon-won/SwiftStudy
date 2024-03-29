#  Realm

## 정리

|-|설명|기타|
|------|---|---|
| @Persisted |RealmSwift 라이브러리에서 제공되는 속성 감시자<br>속성을 지속적으로 관리하고 Realm 데이터베이스에 저장<br> Realm 데이터베이스와 속성을 편리하게 동기화 ||
|@objc dynamic var|Objective-C의 @dynamic과 Swift의 @objc 특성을 조합하여 Realm 데이터베이스에서 관리되는 동적 속성을 정의|var는 일반적인 Swift 변수로서 Realm 객체의 속성을 변경할 수 있지만 데이터베이스에 자동으로 반영X|

## Useage

백그라운드 작업
```
DispatchQueue.global().async {
    let realm = try! Realm()
    
    // 백그라운드 스레드에서 데이터베이스 작업 수행
    
    DispatchQueue.main.async {
        // UI 업데이트 등 필요한 작업을 메인 스레드에서 처리
    }
}
```


## 링크
- [공식문서](https://www.mongodb.com/docs/legacy/realm/swift/latest/#property-attributes)
- [RxRealm](https://github.com/RxSwiftCommunity/RxRealm)
- [Realm 사용하기](https://gonslab.tistory.com/16)
