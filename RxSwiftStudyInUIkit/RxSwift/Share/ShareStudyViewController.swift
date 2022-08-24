//
//  ShareStudyViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/08/23.
//

import UIKit
import RxSwift
import SnapKit
import Then

final class ShareStudyViewController: UIViewController {
    
    deinit {
        print("deinit ShareStudyViewController")
    }

    private let shareStudy = ShareStudy()
    
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
    private let routerButton = UIButton().then {
        $0.setTitle("routerRelay", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    private let routerSubjectButton = UIButton().then {
        $0.setTitle("routerSubjectButton", for: .normal)
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
        shareStudy.bindInput()
        shareStudy.bindOutput()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(
            arrangedSubviews: [
                inputSingleShare,
                singleShare,
                sigle,
                observerShare,
                observer,
                routerButton,
                routerSubjectButton
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
                self.shareStudy.input.observable.accept("tap")
            })
            .disposed(by: disposeBag)
        
        singleShare.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.shareStudy.studySingleShare()
            })
            .disposed(by: disposeBag)
        
        sigle.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.shareStudy.studySingle()
            })
            .disposed(by: disposeBag)
        
        observerShare.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.shareStudy.studyObservableShare()
            })
            .disposed(by: disposeBag)
        
        observer.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.shareStudy.studyObservable()
            })
            .disposed(by: disposeBag)
        
        routerButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.shareStudy.routerRelay()
            })
            .disposed(by: disposeBag)
        
        routerSubjectButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.shareStudy.routerSubject()
            })
            .disposed(by: disposeBag)
    }
}
