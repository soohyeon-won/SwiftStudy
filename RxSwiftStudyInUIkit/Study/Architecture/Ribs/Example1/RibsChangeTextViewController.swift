//
//  RibsChangeTextViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/14.
//

import RIBs
import RxSwift
import UIKit

protocol RibsChangeTextPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func didTapTextChangeBtn()
}

final class RibsChangeTextViewController: UIViewController, RibsChangeTextPresentable, RibsChangeTextViewControllable {
    
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
    
    weak var listener: RibsChangeTextPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindEvent()
    }
    
    private func setupUI() {
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
    }
    
    func bindEvent() {
        button.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                self.listener?.didTapTextChangeBtn()
            })
            .disposed(by: disposeBag)
    }

    // MARK: - RibsChangeTextViewControllable

    func present(viewController: ViewControllable) {
        present(viewController.uiviewController, animated: true, completion: nil)
    }
}
