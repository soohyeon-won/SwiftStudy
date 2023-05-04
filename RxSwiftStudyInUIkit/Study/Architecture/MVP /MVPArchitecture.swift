//
//  MVPArchitecture.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/01.
//

import UIKit

import RxSwift
import RxCocoa

final class MVPArchitecture: UIViewController {
    
    private let textView = UITextView().then {
        $0.isEditable = false
        $0.font = .systemFont(ofSize: 24)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(textView)
        
        textView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(24)
        }
        
        textView.text =
        """
        [ MVP Architecture ]
        Model-View-Presenter
        *presenter : 증여자
        MVC는 View와 Model사이의 의존성이 존재했지만 MVP에서는 의존성을 제거
        
        Presenter: View와 Model의 중개자 역할. View에서 발생한 이벤트를 처리하고 Model에 대한 요청을 처리하여 View에 표시할 데이터를 생성합니다. Presenter는 View와 Model 간의 결합도를 낮추는 역할을 합니다.

        [ 장점 ]
        
        [ 단점 ]
        """
        
        client()
    }
    
    private func client() {
        let presenter = MVPArchitecture.Presenter(model: Model())
        let viewController = MVPArchitecture.ViewController()
        presenter.bind(view: viewController)
    }
}

protocol MVP_View: AnyObject {
    var buttonTap: Observable<Void> { get }
    func updateLabel(with text: String)
}

extension MVPArchitecture {

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

    class ViewController: UIViewController, MVP_View {
        
        private let button = UIButton().then {
            $0.setTitle("Change Label Text", for: .normal)
            $0.setTitleColor(.black, for: .normal)
        }
        private let label = UILabel().then {
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 20)
            $0.text = "Initial Label Text"
        }
        private let disposeBag = DisposeBag()
        
        var buttonTap: Observable<Void> {
            return button.rx.tap.asObservable()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
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
        
        func updateLabel(with text: String) {
            label.text = text
        }
    }
}
