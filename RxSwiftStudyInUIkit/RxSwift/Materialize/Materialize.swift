//
//  Materialize.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2022/12/10.
//

import UIKit

import RxSwift
import RxCocoa

class MaterializeViewController: UIViewController {
    
    private let testBtn = UIButton().then {
        $0.setTitle("Materialize", for: .normal)
    }
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        view.addSubview(testBtn)
        
        testBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        testBtn.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.observable()
                    .materialize()
                    .map { event -> Event<Int> in
                        switch event {
                        case .error:
                            return .next(-1) // 에러 처리
                        default:
                            return event
                        }
                    }
                    .dematerialize()
                    .subscribe(onNext: { element in
                        print(element)
                    }, onCompleted: {
                        print("completed")
                    }).disposed(by: owner.disposeBag)
            })
            .disposed(by: disposeBag)
    }
    
    private func observable() -> Observable<Int> {
        return Observable.create { observer in
            observer.onNext(1)
            observer.onNext(2)
            observer.onError(NSError())
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
