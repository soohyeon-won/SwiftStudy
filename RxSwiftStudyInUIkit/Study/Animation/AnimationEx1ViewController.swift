//
//  AnimationEx1ViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 6/9/24.
//

import UIKit

import RxSwift
import SnapKit
import Then

final class AnimationEx1ViewController: UIViewController {
    
    private let animatedView = UIView().then {
        $0.backgroundColor = .systemBlue
    }
    
    private let springButton = UIButton(type: .system).then {
        $0.setTitle("Spring Animation", for: .normal)
    }
    
    private let basicButton = UIButton(type: .system).then {
        $0.setTitle("Basic Animation", for: .normal)
    }
    
    private let disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(animatedView)
        view.addSubview(springButton)
        view.addSubview(basicButton)
        
        animatedView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.center.equalToSuperview()
        }
        
        springButton.snp.makeConstraints {
            $0.top.equalTo(animatedView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
        basicButton.snp.makeConstraints {
            $0.top.equalTo(springButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
    }
    
    private func bindEvent() {
        springButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                UIView.animate(withDuration: 1.0) {
                    self.animatedView.snp.updateConstraints {
                        $0.centerY.equalToSuperview().offset(200)
                    }
                    self.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
        
        basicButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                UIView.animate(
                    withDuration: 1.0,
                    delay: 0,
                    usingSpringWithDamping: 0.5, // 스프링의 탄력 정도
                    initialSpringVelocity: 1.0, // 애니메이션이 시작할 때의 속도
                    options: [],
                    animations: {
                        self.animatedView.snp.updateConstraints {
                            $0.centerY.equalToSuperview().offset(-200)
                        }
                        self.view.layoutIfNeeded()
                    },
                    completion: nil
                )
            })
            .disposed(by: disposeBag)
    }
}
