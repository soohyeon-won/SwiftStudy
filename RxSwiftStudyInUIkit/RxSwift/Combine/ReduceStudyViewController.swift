//
//  ReduceStudyViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/08/26.
//

import UIKit
import RxSwift
import SnapKit
import Then

final class ReduceStudyViewController: UIViewController {
    
    deinit {
        print("deinit ReduceStudyViewController")
    }

    private let reduceStudy = ReduceStudy()

    private let reduceButton = UIButton().then {
        $0.setTitle("reduceButton", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    
    private let reduceButtonWithoutOnCompleted = UIButton().then {
        $0.setTitle("reduceButton Without OnCompleted", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    
    private let scanButton = UIButton().then {
        $0.setTitle("scanButton", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    
    private let scanArrayButton = UIButton().then {
        $0.setTitle("scan Array Button", for: .normal)
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
        reduceStudy.bindInput()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(
            arrangedSubviews: [
                reduceButton,
                reduceButtonWithoutOnCompleted,
                scanButton,
                scanArrayButton
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
        reduceButton.rx.tap
            .map { () }
            .bind(to: reduceStudy.input.reduceTest)
            .disposed(by: disposeBag)
        
        reduceButtonWithoutOnCompleted.rx.tap
            .map { () }
            .bind(to: reduceStudy.input.reduceTestWithoutOnCompleted)
            .disposed(by: disposeBag)
        
        scanButton.rx.tap
            .scan(false) { lastState, newState in
                return !lastState
            }
            .bind(to: reduceStudy.input.scanTest)
            .disposed(by: disposeBag)
        
        scanArrayButton.rx.tap
            .subscribe(onNext: {
                self.reduceStudy.input.scanArrayTest.accept([Int]())
                self.reduceStudy.input.scanArrayTest.accept([1,2,3])
                self.reduceStudy.input.scanArrayTest.accept([4,5,6])
            })
            .disposed(by: disposeBag)
        
    }
}
