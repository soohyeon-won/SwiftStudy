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

final class MapStudyViewController: UIViewController {
    
    deinit {
        print("deinit ShareStudyViewController")
    }

    private let mapStudy = MapStudy()
    
    /// flatMap:
    /// Observable의 요소들을 각각의 Observable로 만들고, 만들어진 각각의 Observable이 요소들을 방출하게 된다.
    private let flatMapButton = UIButton().then {
        $0.setTitle("flatMapButton", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    private let observable2 = UIButton().then {
        $0.setTitle("observable2", for: .normal)
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
        mapStudy.bindInput()
        mapStudy.bindOutput()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(
            arrangedSubviews: [
                flatMapButton,
                observable2,
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
        flatMapButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.mapStudy.input.observable.accept("flatMapButton tap")
            })
            .disposed(by: disposeBag)
        
//        observable2.rx.tap
//            .asDriver()
//            .drive(onNext: { [weak self] _ in
//                guard let self = self else { return }
//                self.mapStudy.studySingleShare()
//            })
//            .disposed(by: disposeBag)
//        
//        sigle.rx.tap
//            .asDriver()
//            .drive(onNext: { [weak self] _ in
//                guard let self = self else { return }
//                self.mapStudy.studySingle()
//            })
//            .disposed(by: disposeBag)
//        
//        observerShare.rx.tap
//            .asDriver()
//            .drive(onNext: { [weak self] _ in
//                guard let self = self else { return }
//                self.mapStudy.studyObservableShare()
//            })
//            .disposed(by: disposeBag)
//        
//        observer.rx.tap
//            .asDriver()
//            .drive(onNext: { [weak self] _ in
//                guard let self = self else { return }
//                self.mapStudy.studyObservable()
//            })
//            .disposed(by: disposeBag)
//        
//        routerButton.rx.tap
//            .asDriver()
//            .drive(onNext: { [weak self] _ in
//                guard let self = self else { return }
//                self.mapStudy.routerRelay()
//            })
//            .disposed(by: disposeBag)
//        
//        routerSubjectButton.rx.tap
//            .asDriver()
//            .drive(onNext: { [weak self] _ in
//                guard let self = self else { return }
//                self.mapStudy.routerSubject()
//            })
//            .disposed(by: disposeBag)
    }
}
