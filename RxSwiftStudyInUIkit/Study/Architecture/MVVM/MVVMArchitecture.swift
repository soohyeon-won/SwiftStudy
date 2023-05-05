//
//  MVVMArchitecture.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/01.
//

import UIKit

final class MVVMArchitecture: UIViewController {
    
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
        [ MVVM Architecture ]
        Model - View - ViewModel
        
        
        [ 장점 ]
        - ViewModel은 View와 상관 없이 독립적으로 작성되며, UI와 관련 없는 비즈니스 로직을 처리하기 때문에 다른 View에서도 재사용하기 쉬워집니다
        - iewModel은 테스트하기 쉬워서, TDD(Test Driven Development) 방법론을 적용하여 개발할 때 유용
        - 데이터 바인딩을 통해 반응형 UI를 쉽게 구현할 수 있다.
        
        [ 단점 ]
        - 애플리케이션의 규모가 작은 경우에는 너무 많은 추상화가 필요할 수 있다.
        """
    }
}

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

//MARK: - Example
extension MVVMArchitecture {
    
    final class Model {
        var title: String = "Label Text Changed"
    }

    final class ViewModel {

        struct Input {
            let buttonTap: Signal<Void>
        }

        struct Output {
            let labelText: Driver<String>
        }

        func transform(input: Input) -> Output {
            let labelText = input.buttonTap
                .map { Model().title }
                .asDriver(onErrorJustReturn: "")
            
            return Output(labelText: labelText)
        }
    }

    final class ViewController: UIViewController {
        
        private let button = UIButton().then {
            $0.setTitle("Change Label Text", for: .normal)
            $0.setTitleColor(.black, for: .normal)
        }
        private let label = UILabel().then {
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 20)
            $0.text = "Initial Label Text"
        }

        private let disposeBag = DisposeBag()
        private let viewModel = ViewModel()

        override func viewDidLoad() {
            super.viewDidLoad()

            view.addSubview(button)
            button.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
            
            view.addSubview(label)
            label.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(button.snp.bottom).offset(20)
            }
        }
        
        func transform() {
            let input = ViewModel.Input(buttonTap: button.rx.tap.asSignal()) //signal: 구독 이후에 발행된 값을 받음
            let output = viewModel.transform(input: input)

            output.labelText
                .drive(label.rx.text)
                .disposed(by: disposeBag)
        }
    }

}
