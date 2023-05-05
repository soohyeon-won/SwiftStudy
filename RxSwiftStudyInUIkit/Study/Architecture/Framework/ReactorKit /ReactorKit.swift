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
        상태를 중심으로 앱을 설계합니다.
        앱의 모든 상태는 하나의 상태 스트림으로 관리되고,
        상태 변화는 반응형으로 처리됩니다.
        
        View: UI들의 action을 reactor에 넘기고, reactor의 state를 구독하고 있는 형태
        
        Action
        View로부터 받을 Action을 enum으로 정의
        
        Mutation
        View로부터 action을 받은 경우, 해야할 작업단위들을 enum으로 정의
        
        State
        현재 상태를 기록하고 있으며, View에서 해당 정보를 사용하여 UI업데이트 및 Reactor에서 image를 얻어올때 page정보들을 저장
        
        [ 장점 ]
        
        [ 단점 ]
        """
        
        client()
    }
    
    private func client() {
    }
}

import ReactorKit

extension ReactorKit {

    final class ViewController: UIViewController {
        
        let label = UILabel().then {
            $0.text = "Press the button"
        }
        
        let button = UIButton().then {
            $0.setTitle("Press me", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemBlue
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.addSubview(label)
            label.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            view.addSubview(button)
            button.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
                make.width.equalTo(120)
                make.height.equalTo(44)
            }
        }
        
        func bind(reactor: ButtonReactor) {
            
            button.rx.tap
                .map { ButtonReactor.Action.changeText }
                .bind(to: reactor.action)
                .disposed(by: self.disposeBag)
            
            reactor.state.map { $0.text }
                .distinctUntilChanged()
                .bind(to: label.rx.text)
                .disposed(by: self.disposeBag)
        }
        
        private let disposeBag = DisposeBag()
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
        
        func mutate(action: Action) -> Observable<Mutation> {
            switch action {
            case .changeText:
                return .just(.setText("Button pressed!"))
            }
        }
        
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
