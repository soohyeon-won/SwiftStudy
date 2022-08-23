//
//  RxSwiftStudy.swift
//  RxSwiftStudy
//
//  Created by won soohyeon on 2022/08/21.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class Study {
    
    deinit {
        print("deinit study")
    }
    private let disposeBag = DisposeBag()
    
    let input = Input()
    private let output = Output()
    
    struct Input {
        let observable = PublishRelay<String>()
    }
    
    struct Output {
        let router = PublishRelay<String>()
        
        let relay = PublishRelay<String>()
        let subject = PublishSubject<String>()
        
        let behaviorRelay = BehaviorRelay<String>(value: "init")
        let behaviorSubject = BehaviorSubject<String>(value: "init")
    }
    
    private func createSingleRequester() -> Single<String> {
        return Single<String>.create { single in
            print("createSingleRequester😤")
            single(.success("Single"))
            return Disposables.create()
        }
    }
    
    private func createObservableRequester() -> Observable<String> {
        return Observable<String>.create { observer in
            print("createObservableRequester😇")
            observer.onNext("Observable1")
            observer.onCompleted() // X
            return Disposables.create()
        }
    }
    
    func studyObservable() {
        let apiRequester = createObservableRequester()

        apiRequester
            .bind(to: output.relay)
            .disposed(by: disposeBag)
        
        apiRequester
            .bind(to: output.subject)
            .disposed(by: disposeBag)
        
        apiRequester
            .bind(to: output.behaviorRelay)
            .disposed(by: disposeBag)
        
        apiRequester
            .bind(to: output.behaviorSubject)
            .disposed(by: disposeBag)
    }
    
    func studyObservableShare() {
        let apiRequester = createObservableRequester().share(replay:1)

        apiRequester
            .bind(to: output.relay)
            .disposed(by: disposeBag)
        
        apiRequester
            .bind(to: output.subject)
            .disposed(by: disposeBag)
        
        apiRequester
            .bind(to: output.behaviorRelay)
            .disposed(by: disposeBag)
        
        apiRequester
            .bind(to: output.behaviorSubject)
            .disposed(by: disposeBag)
    }
    
    func studySingle() {
        let apiRequester = createSingleRequester().asObservable()

        apiRequester
            .bind(to: output.relay)
            .disposed(by: disposeBag)
        
        apiRequester
            .bind(to: output.subject)
            .disposed(by: disposeBag)
        
        apiRequester
            .bind(to: output.behaviorRelay)
            .disposed(by: disposeBag)
        
        apiRequester
            .bind(to: output.behaviorSubject)
            .disposed(by: disposeBag)
    }
    
    func studySingleShare() {
        let apiRequester = createSingleRequester().asObservable()

        apiRequester
            .bind(to: output.relay)
            .disposed(by: disposeBag)
        
        apiRequester
            .bind(to: output.subject)
            .disposed(by: disposeBag)
        
        apiRequester
            .bind(to: output.behaviorRelay)
            .disposed(by: disposeBag)
        
        apiRequester
            .bind(to: output.behaviorSubject)
            .disposed(by: disposeBag)
    }
    
    func routerRelay() {
        let apiRequester = createSingleRequester().asObservable()

        apiRequester
            .bind(to: output.router)
            .disposed(by: disposeBag)
    }
    
    func routerSubject() {
        let apiRequester = createSingleRequester().asObservable()

        apiRequester
            .bind(to: output.subject)
            .disposed(by: disposeBag)
    }
    
    func bindInput() {
        let observable = input.observable
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                owner.createSingleRequester()
            }
            .asObservable()
            .share()
        
        observable
            .bind(to: output.relay)
            .disposed(by: disposeBag)
        
        observable
            .bind(to: output.subject)
            .disposed(by: disposeBag)
        
        observable
            .bind(to: output.behaviorRelay)
            .disposed(by: disposeBag)
        
        observable
            .bind(to: output.behaviorSubject)
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {
        output.relay
            .subscribe(onNext: { test in
                print("👹PublishRelay:\(test)")
            })
            .disposed(by: disposeBag)
        
        output.subject
            .subscribe(onNext: { test in
                print("👿PublishSubject:\(test)")
            })
            .disposed(by: disposeBag)
        
        output.behaviorRelay
            .subscribe(onNext: { test in
                print("👺behaviorRelay:\(test)")
            })
            .disposed(by: disposeBag)
        
        output.behaviorSubject
            .subscribe(onNext: { test in
                print("👾behaviorSubject:\(test)")
            })
            .disposed(by: disposeBag)
        
        output.router
            .subscribe(onNext: { test in
                print("🤝Router1 PublishRelay:\(test)")
            })
            .disposed(by: disposeBag)
        
        output.router
            .subscribe(onNext: { test in
                print("🤝Router2 PublishRelay:\(test)")
            })
            .disposed(by: disposeBag)
    }
}
