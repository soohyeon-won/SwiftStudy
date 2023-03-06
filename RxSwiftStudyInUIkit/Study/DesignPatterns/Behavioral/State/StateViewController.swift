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

// MARK: - 자판기
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
        VendingMachine.shared.transitionToState(.coinInserted)
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
        VendingMachine.shared.transitionToState(.noCoin)
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
