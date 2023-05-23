//
//  ReactorKit.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/01.
//

import UIKit

import ReactorKit

struct ReactorKit {

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
