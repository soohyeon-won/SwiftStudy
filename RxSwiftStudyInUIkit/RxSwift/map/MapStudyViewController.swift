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
    private let mapBasicButton = UIButton().then {
        $0.setTitle("map test", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    private let flatMapButton = UIButton().then {
        $0.setTitle("flatMap", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    private let flatMapLatestButton = UIButton().then {
        $0.setTitle("flatMapLatest", for: .normal)
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
                mapBasicButton,
                flatMapButton,
                flatMapLatestButton
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
        mapBasicButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.mapStudy.input.mapBasic.accept("flatMapButton tap")
            })
            .disposed(by: disposeBag)
        
        flatMapButton.rx.tap
            .map { () }
            .bind(to: mapStudy.input.flatMap)
            .disposed(by: disposeBag)
        
        flatMapLatestButton.rx.tap
            .map { () }
            .bind(to: mapStudy.input.flatMapLatest)
            .disposed(by: disposeBag)
    }
}
