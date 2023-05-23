//
//  MVPArchitecture.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/01.
//

import UIKit

import RxSwift
import RxCocoa

protocol MVP_View: AnyObject {
    var buttonTap: Observable<Void> { get }
    func updateLabel(with text: String)
}

struct MVPArchitecture {

    final class Presenter {
        
        private let disposeBag = DisposeBag()
        private let model: Model
        
        init(model: Model) {
            self.model = model
        }
        
        func bind(view: MVP_View) {
            view.buttonTap
                .map { [model] in model.title }
                .subscribe(onNext: { title in
                    view.updateLabel(with: title)
                })
                .disposed(by: disposeBag)
        }
    }

    final class Model {
        var title: String = "Label Text Changed"
    }

    final class ViewController: UIViewController, MVP_View {
        
        private let button = UIButton().then {
            $0.setTitle("Click me!", for: .normal)
            $0.backgroundColor = .blue
            $0.layer.cornerRadius = 5
        }
        private let label = UILabel().then {
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 20)
            $0.text = "Initial Label Text"
        }
        private let disposeBag = DisposeBag()
        
        private let presenter = Presenter(model: Model())
        
        var buttonTap: Observable<Void> {
            return button.rx.tap.asObservable()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            
            view.addSubview(button)
            button.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
            
            view.addSubview(label)
            label.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(button.snp.bottom).offset(20)
            }
            
            presenter.bind(view: self)
        }
        
        func updateLabel(with text: String) {
            label.text = text
        }
    }
}
