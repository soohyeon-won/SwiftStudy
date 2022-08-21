//
//  ViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2022/08/21.
//

import UIKit
import SnapKit
import Then
import RxSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.pushViewController(ShareStudyViewController(), animated: true)
    }
}

class ShareStudyViewController: UIViewController {
    
    deinit {
        print("deinit ShareStudyViewController")
    }

    private let study = Study()
    
    private let inputSingleShare = UIButton().then {
        $0.setTitle("inputSingleShare", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    private let singleShare = UIButton().then {
        $0.setTitle("singleShare", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    private let sigle = UIButton().then {
        $0.setTitle("sigle", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    private let observerShare = UIButton().then {
        $0.setTitle("observerShare", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    private let observer = UIButton().then {
        $0.setTitle("observer", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindEvent()
        study.bindInput()
        study.bindOutput()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(
            arrangedSubviews: [
                inputSingleShare,
                singleShare,
                sigle,
                observerShare,
                observer
            ]
        ).then {
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .fillEqually
        }
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bindEvent() {
        inputSingleShare.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.study.input.observable.accept("tap")
            })
            .disposed(by: disposeBag)
        
        singleShare.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.study.studySingleShare()
            })
            .disposed(by: disposeBag)
        
        sigle.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.study.studySingle()
            })
            .disposed(by: disposeBag)
        
        observerShare.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.study.studyObservableShare()
            })
            .disposed(by: disposeBag)
        
        observer.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.study.studyObservable()
            })
            .disposed(by: disposeBag)
    }


}


/**
 결론
 
 1. input 변수를 통해서 API 를 request하고, 이를 share형태로 사용한다.
 - 장점: subject, behavior 모두 사용가능한 방식 이고 API 가 중복호출 될 위험이 적다.
 - 단점: 함수로 호출될 때보다 디버깅이 힘들 수 있음, 테스트코드로 해결 할 수 있지만 우리 구조에서는 불가능하다.
 
 2. 여러번 호출되는 곳에서 Subject 선언을 지양한다. relay로 작성되어야함.
 - 장점: 기존 아키텍처로 작성된 곳을 수정할 필요없음
 - 단점: 구성원들 모두가 relay와 subject에 대한 이해도를 가져야함 무분별한 relay가 생성될 수 있음.
 
 3. Observable<String>.create 시에 onCompleted를 작성하지 않는다.

 */
