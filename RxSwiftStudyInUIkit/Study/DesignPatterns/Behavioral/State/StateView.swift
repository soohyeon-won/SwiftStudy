//
//  StateView.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import SwiftUI

struct StateView: View {
    
    private let textViewContent: String = """
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
        
        [전략패턴과의 차이점]
        전략 패턴과 상태 패턴은 객체의 행동을 변경하는 디자인 패턴입니다.
        전략 패턴은 객체가 특정한 행동을 수행할 때, 그 행동을 구현한 전략 객체를 사용합니다.
        반면, 상태 패턴은 객체의 상태에 따라 객체의 행동을 변경합니다. 상태 패턴에서는 상태를 클래스로 정의하고, 각 상태마다 클래스를 만들어서 객체가 상태를 변경할 때마다 새로운 클래스의 인스턴스를 생성합니다.

        전략 패턴과 상태 패턴의 차이점은 객체의 행동을 변경하는 방식입니다.
        전략 패턴은 객체가 사용할 전략 객체를 외부에서 주입받아 사용합니다.
        반면, 상태 패턴은 객체가 스스로 상태를 변경하고, 그에 따라 적절한 행동을 수행합니다.
        """
    
    var body: some View {
        VStack {
            ScrollView {
                Text(textViewContent)
                    .font(.system(size: 24))
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(8)
                
                CodeView(code: """
                // 게시물 상태 프로토콜 정의
                protocol PostState {
                    func handleEdit(context: PostContext)
                    var statusDescription: String { get }
                }

                // 게시물 클래스
                class PostContext {
                    private var state: PostState
                    
                    init(initialState: PostState) {
                        self.state = initialState
                    }
                    
                    // 상태 변경
                    func setState(_ newState: PostState) {
                        self.state = newState
                    }
                    
                    // 상태에 따른 편집 동작 처리
                    func edit() {
                        state.handleEdit(context: self)
                    }
                    
                    // 상태 확인
                    func getStatus() -> String {
                        return state.statusDescription
                    }
                }

                // '초안' 상태 구현
                class DraftState: PostState {
                    var statusDescription: String {
                        return "게시물을 작성하는 중입니다."
                    }
                    
                    func handleEdit(context: PostContext) {
                        print("게시물이 편집되었습니다.")
                        context.setState(PublishedState())  // 상태를 게시됨으로 전환
                    }
                }

                // '게시됨' 상태 구현
                class PublishedState: PostState {
                    var statusDescription: String {
                        return "게시물이 게시되었습니다."
                    }
                    
                    func handleEdit(context: PostContext) {
                        print("게시물을 더 이상 수정할 수 없습니다. 게시물이 잠깁니다.")
                        context.setState(LockedState())  // 상태를 잠금으로 전환
                    }
                }

                // '잠금됨' 상태 구현
                class LockedState: PostState {
                    var statusDescription: String {
                        return "게시물이 잠금 상태입니다."
                    }
                    
                    func handleEdit(context: PostContext) {
                        print("잠금된 게시물은 수정할 수 없습니다.")
                    }
                }
                
                private func example3_writePost() {
                    // 실제 사용 예시
                    let post = PostContext(initialState: DraftState())
                    print("현재 상태: \\(post.getStatus())")

                    // 상태 전환: 초안 -> 게시됨
                    post.edit()
                    print("현재 상태: \\(post.getStatus())")

                    // 상태 전환: 게시됨 -> 잠금
                    post.edit()
                    print("현재 상태: \\(post.getStatus())")

                    // 잠금 상태에서 수정 시도
                    post.edit()
                }
                """)
            }
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .onAppear {
                client()
            }
        }
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
    
    private func example3_writePost() {
        // 실제 사용 예시
        let post = PostContext(initialState: DraftState())
        print("현재 상태: \(post.getStatus())")

        // 상태 전환: 초안 -> 게시됨
        post.edit()
        print("현재 상태: \(post.getStatus())")

        // 상태 전환: 게시됨 -> 잠금
        post.edit()
        print("현재 상태: \(post.getStatus())")

        // 잠금 상태에서 수정 시도
        post.edit()
    }
}

public class Client {
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

// MARK: - 게시물 작성 & 잠금

// 게시물 상태 프로토콜 정의
protocol PostState {
    func handleEdit(context: PostContext)
    var statusDescription: String { get }
}

// 게시물 클래스
class PostContext {
    private var state: PostState
    
    init(initialState: PostState) {
        self.state = initialState
    }
    
    // 상태 변경
    func setState(_ newState: PostState) {
        self.state = newState
    }
    
    // 상태에 따른 편집 동작 처리
    func edit() {
        state.handleEdit(context: self)
    }
    
    // 상태 확인
    func getStatus() -> String {
        return state.statusDescription
    }
}

// '초안' 상태 구현
class DraftState: PostState {
    var statusDescription: String {
        return "게시물을 작성하는 중입니다."
    }
    
    func handleEdit(context: PostContext) {
        print("게시물이 편집되었습니다.")
        context.setState(PublishedState())  // 상태를 게시됨으로 전환
    }
}

// '게시됨' 상태 구현
class PublishedState: PostState {
    var statusDescription: String {
        return "게시물이 게시되었습니다."
    }
    
    func handleEdit(context: PostContext) {
        print("게시물을 더 이상 수정할 수 없습니다. 게시물이 잠깁니다.")
        context.setState(LockedState())  // 상태를 잠금으로 전환
    }
}

// '잠금됨' 상태 구현
class LockedState: PostState {
    var statusDescription: String {
        return "게시물이 잠금 상태입니다."
    }
    
    func handleEdit(context: PostContext) {
        print("잠금된 게시물은 수정할 수 없습니다.")
    }
}
