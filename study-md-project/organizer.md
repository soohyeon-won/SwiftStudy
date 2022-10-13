# Any
I was organizing what I studied

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
