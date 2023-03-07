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
        - 객체 내부 상태 변경에 따라 객체의 행동이 달라지는 패턴.
        • 상태에 특화된 행동들을 분리해 낼 수 있으며, 새로운 행동을 추가하더라도 다른 행동에 영향을 주지 않는다.
        
        [장점]
        
        [단점]
        
        [사용 예제]
        """
        
        client()
    }
    
    private func client() {
        example1_vendingMachine()
    }
    
    private func example1_vendingMachine() {
        let vendingMachine = VendingMachine.shared

        vendingMachine.insertCoin(100) // 동전을 삽입했습니다.
        vendingMachine.pressButton()   // 동전이 없습니다.

        vendingMachine.insertCoin(100) // 동전을 삽입했습니다.
        vendingMachine.pressButton()   // 음료수가 나왔습니다.
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


