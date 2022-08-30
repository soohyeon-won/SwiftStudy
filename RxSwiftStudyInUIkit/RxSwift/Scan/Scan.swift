//
//  File.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/08/30.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class ScanStudy {
    
    deinit {
        print("deinit MapStudy")
    }
    private let disposeBag = DisposeBag()
    
    let input = Input()
    private let output = Output()
    
    struct Input {
        let reduceTest = PublishRelay<Void>()
        let reduceTestWithoutOnCompleted = PublishRelay<Void>()
    }
    
    struct Output {
        let bindMap = PublishRelay<String>()
    }
    
    private func createSingleRequester() -> Single<Int> {
        return Single<Int>.create { single in
            print("createSingleRequester😤")
            single(.success(1))
            single(.success(2))
            single(.success(3))
            return Disposables.create()
        }
    }
    
    private func createObservableRequester() -> Observable<Int> {
        return Observable<Int>.create { observer in
            print("createObservableRequester😇")
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            return Disposables.create()
        }
    }
    
    private func createObservableRequesterOnCompleted() -> Observable<Int> {
        return Observable<Int>.create { observer in
            print("createObservableRequester😇")
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func bindInput() {
        input.reduceTest
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.reduceTest()
            })
            .disposed(by: disposeBag)
        
        
        input.reduceTestWithoutOnCompleted
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.reduceTestWithoutOnCompleted()
            })
            .disposed(by: disposeBag)
    }
    
    private func reduceTest() {
        createSingleRequester()
            .asObservable()
            .reduce(0) { lsh, rsh in
                return lsh + rsh
            }.subscribe(onNext: { elemet in
                print(elemet)
            }).disposed(by: disposeBag)
        
        createObservableRequesterOnCompleted()
            .reduce(0) { lsh, rsh in
                return lsh + rsh
            }.subscribe(onNext: { elemet in
                print("🤝\(elemet)")
            }).disposed(by: disposeBag)
    }
    
    private func reduceTestWithoutOnCompleted() {
        createObservableRequester()
            .reduce(0) { lsh, rsh in
                return lsh + rsh
            }.subscribe(onNext: { elemet in
                print(elemet)
            }).disposed(by: disposeBag)
    }
}
