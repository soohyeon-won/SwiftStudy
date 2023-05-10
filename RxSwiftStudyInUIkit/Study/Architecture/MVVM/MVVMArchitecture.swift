//
//  MVVMArchitecture.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/01.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

struct MVVMArchitecture {
    
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
