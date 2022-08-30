//
//  ScanViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/08/30.
//

import UIKit
import RxSwift
import SnapKit
import Then

final class ScanStudyViewController: UIViewController {
    
    deinit {
        print("deinit ScanStudyViewController")
    }

    private let scanStudy = ScanStudy()

    private let reduceButton = UIButton().then {
        $0.setTitle("scanButton", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    
    private let reduceButtonWithoutOnCompleted = UIButton().then {
        $0.setTitle("reduceButton Without OnCompleted", for: .normal)
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
                reduceButtonWithoutOnCompleted
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
    }
}
