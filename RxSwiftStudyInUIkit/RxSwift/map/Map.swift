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

final class MapStudy {
    
    deinit {
        print("deinit MapStudy")
    }
    private let disposeBag = DisposeBag()
    
    let input = Input()
    private let output = Output()
    
    struct Input {
        let observable = PublishRelay<String>()
    }
    
    struct Output {
//        let observable2 = PublishRelay<String>()
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
    
    func bindInput() {
        let observable2 = Observable.of("a","b","c")
//        let observable2 = BehaviorRelay<String>(value: "F")
//        observable2.accept("a")
//        observable2.accept("b")
//        observable2.accept("c")
        
        let observable = input.observable
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                owner.createSingleRequester()
            }
            .asObservable()
            .share()
        
        observable
            .map { str -> String in
                return str // 리턴을 명시하지 않으면 Void가 리턴된다.
            }.subscribe(onNext: { str in
                print("🥳 subscribe map: \(str)")
            })
            .disposed(by: disposeBag)
        
        observable
            .flatMap { str -> Observable<String> in
                return Observable.just(str)
            }.subscribe(onNext: { str in
                print("👹 subscribe flatMap: \(str)")
            })
            .disposed(by: disposeBag)
        
        observable
            .withUnretained(self)
            .map { owner, str -> Observable<String> in
                return observable2.map { "\(str) + \($0)" }
            }.subscribe(onNext: { str in
                print("🥳 observable, observable2 map: \(str)")
            })
            .disposed(by: disposeBag)
        
        observable
            .withUnretained(self)
            .flatMap { owner, str -> Observable<String> in
                return observable2.map { "\(str) + \($0)" }
            }.subscribe(onNext: { str in
                print("👹 observable, observable2 flatMap: \(str)")
            })
            .disposed(by: disposeBag)
        
//        observable2.accept("D")
        
        observable
            .withUnretained(self)
            .flatMapLatest { owner, str -> Observable<String> in
                return observable2.map { "\(str) + \($0)" }
            }.subscribe(onNext: { str in
                print("👹 observable, observable2 flatMapLatest: \(str)")
            })
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {
        
    }
}
