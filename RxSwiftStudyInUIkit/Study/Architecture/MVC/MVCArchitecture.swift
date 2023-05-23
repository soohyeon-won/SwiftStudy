//
//  MVCArchitecture.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/04/27.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

struct MVCArchitecture {
    
    final class Model {
        var title: String = "Hello, World!"
        
        func updateLabelText() {
            title = "Button tapped!"
        }
    }
    
    final class ViewController: UIViewController {
        
        private let disposeBag = DisposeBag()
        
        private var model = MVCArchitecture.Model()
        
        private lazy var label = UILabel().then {
            $0.text = model.title
            $0.textAlignment = .center
            $0.textColor = .black
        }
        
        private let button = UIButton().then {
            $0.setTitle("Click me!", for: .normal)
            $0.backgroundColor = .blue
            $0.layer.cornerRadius = 5
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .white
            setupViews()
            bind()
        }
        
        private func setupViews() {
            view.addSubview(label)
            label.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(0.8)
            }
            
            view.addSubview(button)
            button.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(label.snp.bottom).offset(20)
                $0.width.equalTo(100)
                $0.height.equalTo(50)
            }
        }
        
        private func bind() {
            button.rx.tap
                .subscribe(onNext: { [weak self] in
                    guard let self else { return }
                    self.model.updateLabelText()
                    self.label.text = self.model.title
                })
                .disposed(by: disposeBag)
        }
    }
}
