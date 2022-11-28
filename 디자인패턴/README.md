## ✨ Study
https://www.inflearn.com/course/%EB%94%94%EC%9E%90%EC%9D%B8-%ED%8C%A8%ED%84%B4/dashboard

- 디자인패턴
#### 1. 싱글톤 패턴
#### 2. 팩토리 메소드 (Factory method) 패턴

개방-폐쇄 원칙 (OCP: Open-Closed Principle) 

구체적으로 어떤 인스턴스를 만들지는 서브 클래스가 정한다.

다양한 구현체 (Product) 가 있고, 그중에서 특정한 구현체를 만들 수 있는 다양한 팩토리(Creator) 제공

JAVA interface ShipFactory 에 createShip() 함수를 정의하고 BlackshipFactory, WhiteshipFactory 에서 상속받아서 createShip() 함수에서 인스턴스를 리턴 한다.

interface ShipFactory
- orderShip(String name, String email)
- private void validate(String name, String email)

#### 3. 추상 팩토리 메소드 패턴
