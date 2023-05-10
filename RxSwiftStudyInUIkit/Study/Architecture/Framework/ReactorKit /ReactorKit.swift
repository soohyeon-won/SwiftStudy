//
//  ReactorKit.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/01.
//

import UIKit

final class ReactorKit: UIViewController {
    
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
        
        textView.text =
        """
        [ ReactorKit ]
        MVVM 패턴을 기반으로 하며 RxSwift를 사용하여 구현된 라이브러리
        상태를 중심으로 앱을 설계
        앱의 모든 상태는 하나의 상태 스트림으로 관리되고, 상태 변화는 반응형으로 처리된다.
        View -> Action -> Reactor -> State -> View
        
        - View
        UI들의 action을 reactor에 넘기고, reactor의 state를 구독하고 있는 형태
        
        - Reactor
        비지니스 로직 수행, state관리 해서 View에게 전달
        Reactor protocol을 준수하여 Reactor를 정의
        
        * Reactor protocol
        1. Action
        사용자 동작
        2. Mutation
        State와 Action의 중간다리 역할
        3. State
        현재 상태를 기록하고 있으며, View에서 해당 정보를 사용하여 UI업데이트
        
        [ 장점 ]
        
        [ 단점 ]
        
        """
        
        client()
    }
    
    private func client() {
        let viewController = ReactorKit.ViewController()
    }
}

import ReactorKit

extension ReactorKit {

    final class ViewController: UIViewController, View {
        typealias Reactor = ButtonReactor
        
        private let label = UILabel().then {
            $0.text = "Press the button"
        }

        private let button = UIButton().then {
            $0.setTitle("Press me", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemBlue
        }
        var disposeBag = DisposeBag()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .white
            
            view.addSubview(label)
            label.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
            
            view.addSubview(button)
            button.snp.makeConstraints {
                $0.top.equalTo(label.snp.bottom).offset(16)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(120)
                $0.height.equalTo(44)
            }
            
            reactor = Reactor()
        }
        
        func bind(reactor: Reactor) {
            button.rx.tap
                .map { ButtonReactor.Action.changeText }
                .bind(to: reactor.action)
                .disposed(by: disposeBag)
            
            reactor.state.map { $0.text }
                .distinctUntilChanged()
                .bind(to: label.rx.text)
                .disposed(by: self.disposeBag)
        }
        
    }

    final class ButtonReactor: Reactor {
        
        enum Action {
            case changeText
        }
        
        enum Mutation {
            case setText(String)
        }
        
        struct State {
            var text: String
        }
        
        let initialState = State(text: "Press the button")
        
        // 비동기 작업, API call같은 행동 수행
        func mutate(action: Action) -> Observable<Mutation> {
            switch action {
            case .changeText:
                return .just(.setText("Button pressed!"))
            }
        }
        
        // 이전 State와 mutation을 받아서 동기적으로 State를 반환
        func reduce(state: State, mutation: Mutation) -> State {
            var state = state
            switch mutation {
            case let .setText(text):
                state.text = text
            }
            return state
        }
    }
}
