//
//  StateViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class StateViewController: UIViewController {
    
    private let textView = UITextView().then {
        $0.isEditable = false
        $0.font = .systemFont(ofSize: 24)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(textView)
        
        textView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(24)
        }
        
        textView.text = """
        [ 상태 (State) 패턴 ]
        • 객체 내부 상태 변경에 따라 객체의 행동이 달라지는 패턴.
        • 상태에 특화된 행동들을 분리해 낼 수 있으며, 새로운 행동을 추가하더라도 다른 행동에 영향을 주지 않는다.
            - 클래스가 늘어남에 따라 복잡한 경우가 증가한다고 생각할 수 있지만 여러 조합에 대해 단위 테스트 코드를 하기 유용하다.
            - 테스트 범위는 동일할 수 있지만 개별적으로/단위마다 테스트할 수 있다.
            - 구체적인 클래스에 대한 의존성을 없앨 수 있음
            - 의존하고 있는 부분이 Interface라서 새로운 행동을 추가해도 영향을 주지 않는다.
        
        [장점]
        • 상태에 따른 동작을 개별 클래스로 옮겨서 관리할 수 있다.
        • 기존의 특정 상태에 따른 동작을 변경하지 않고 새로운 상태에 다른 동작을 추가할 수 있다.
        • 코드 복잡도를 줄일 수 있다.
        
        [단점]
        • 복잡도가 증가한다.
        
        [사용 예제]
        - 자판기
        - 수강 신청
        - 배포 상태 변경
        
        [추가 의견 by ChatGPT]
        스위프트에서는 상태 패턴을 구현할 수 있는 다양한 방법이 있지만, 내장된 라이브러리나 함수는 없습니다.
        하지만 스위프트의 다형성과 프로토콜을 활용하여 쉽게 상태 패턴을 구현할 수 있습니다.
        """
        
        client()
    }
    
    private func client() {
        example1_vendingMachine()
        example2_community()
    }
    
    private func example1_vendingMachine() {
        let vendingMachine = VendingMachine.shared

        vendingMachine.insertCoin(100) // 동전을 삽입했습니다.
        vendingMachine.pressButton()   // 동전이 없습니다.

        vendingMachine.insertCoin(100) // 동전을 삽입했습니다.
        vendingMachine.pressButton()   // 음료수가 나왔습니다.
    }
    
    private func example2_community() {
        let isWriter = false
        let community = Community()
        community.getUseState(isWriter: isWriter)
        community.excuteEntryAction()
    }
}

public class client {
    func client() {
        let student = Student (name: "whiteship")
        let onlineCourse = OnlineCourse()
        let keesun = Student(name: "keesun")
        
        keesun.addPrivateCourse(onlineCourse)
        onlineCourse.addStudent(student)
        onlineCourse.changeState(OnlineCourse.State.PRIVATE)
        onlineCourse.addStudent(keesun)
        onlineCourse.addReview(review: "hello", student)
        
        print(onlineCourse.getState())
        print(onlineCourse.getStudents())
        print(onlineCourse.getReviews())
    }
}

// MARK: - 수강신청
class Student {
    let name: String
    init(name: String) {
        self.name = name
    }

    func addPrivateCourse(_ state: OnlineCourse) {

    }
}

class OnlineCourse {
    
    enum State {
        case PRIVATE
    }
    
    func addStudent() {
        
    }
    
    func changeState(_ state: State) {
        
    }
    
    func addStudent(_ student: Student) {
        
    }
    
    func addReview(review: String, _ student: Student) {
        
    }
    
    func getState() {
        
    }
    
    func getStudents() {
        
    }
    
    func getReviews() {
        
    }
}

// MARK: - 자판기 1
// 자판기 상태 프로토콜
protocol VendingMachineState {
    func insertCoin(_ amount: Int)
    func pressButton()
}

// 동전 없는 상태
class NoCoinState: VendingMachineState {
    func insertCoin(_ amount: Int) {
        print("동전을 삽입했습니다.")
        // 상태 변경
        VendingMachine.shared.transitionToState(self)
    }

    func pressButton() {
        print("동전이 없습니다.")
    }
}

// 동전 삽입된 상태
class CoinInsertedState: VendingMachineState {
    func insertCoin(_ amount: Int) {
        print("이미 동전이 삽입되어 있습니다.")
    }

    func pressButton() {
        print("음료수를 나왔습니다.")
        // 상태 변경
        VendingMachine.shared.transitionToState(self)
    }
}

// 자판기 객체
class VendingMachine {
    static let shared = VendingMachine()
    private var state: VendingMachineState

    // 초기 상태: 동전 없음
    private init() {
        self.state = NoCoinState()
    }

    // 상태 변경 함수
    func transitionToState(_ state: VendingMachineState) {
        self.state = state
    }

    // 동전 삽입 함수
    func insertCoin(_ amount: Int) {
        state.insertCoin(amount)
    }

    // 버튼 누르기 함수
    func pressButton() {
        state.pressButton()
    }
}

// MARK: - 자판기 예제2

protocol VendingMachineState2 {
    func insertMoney(_ money: Int)
    func chooseDrink(_ drink: String)
    func dispenseDrink()
}

// 상태 클래스 정의
class ReadyState: VendingMachineState2 {
    func insertMoney(_ money: Int) {
        print("\(money)원을 받았습니다.")
    }
    
    func chooseDrink(_ drink: String) {
        print("\(drink)를 선택하셨습니다.")
    }
    
    func dispenseDrink() {
        print("음료를 선택해주세요.")
    }
}

class DrinkSelectedState: VendingMachineState2 {
    func insertMoney(_ money: Int) {
        print("\(money)원을 받았습니다.")
    }
    
    func chooseDrink(_ drink: String) {
        print("이미 음료가 선택되어 있습니다.")
    }
    
    func dispenseDrink() {
        print("음료를 배출합니다.")
    }
}

class DrinkDispensedState: VendingMachineState2 {
    func insertMoney(_ money: Int) {
        print("음료가 이미 배출되었습니다. 돈을 반환합니다.")
    }
    
    func chooseDrink(_ drink: String) {
        print("음료가 이미 배출되었습니다. 돈을 반환합니다.")
    }
    
    func dispenseDrink() {
        print("음료가 이미 배출되었습니다. 돈을 반환합니다.")
    }
}

// 자판기 클래스 정의
class VendingMachine2 {
    private var state: VendingMachineState2
    
    init() {
        self.state = ReadyState()
    }
    
    func insertMoney(_ money: Int) {
        state.insertMoney(money)
        if state is ReadyState {
            state = DrinkSelectedState()
        }
    }
    
    func chooseDrink(_ drink: String) {
        state.chooseDrink(drink)
        if state is DrinkSelectedState {
            state = DrinkDispensedState()
        }
    }
    
    func dispenseDrink() {
        state.dispenseDrink()
        if state is DrinkDispensedState {
            state = ReadyState()
        }
    }
}

// 사용 예시
let vendingMachine = VendingMachine2()


