//
//  Reduce.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2022/08/26.
//

import Foundation
import RxSwift
import RxCocoa

final class ReduceStudy {
    
    deinit {
        print("deinit MapStudy")
    }
    private let disposeBag = DisposeBag()
    
    let input = Input()
    private let output = Output()
    
    struct Input {
        let reduceTest = PublishRelay<Void>()
        let reduceTestWithoutOnCompleted = PublishRelay<Void>()
        let scanTest = PublishRelay<Bool>()
        let scanArrayTest = PublishRelay<[Int]>()
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
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.reduceTest()
            })
            .disposed(by: disposeBag)
        
        
        input.reduceTestWithoutOnCompleted
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.reduceTestWithoutOnCompleted()
            })
            .disposed(by: disposeBag)
        
        input.scanTest
            .subscribe(onNext: { test in
                print("🫥 \(test)")
            })
            .disposed(by: disposeBag)
        
        input.scanArrayTest
            .asObservable()
            .scan([]) { prev, newValue in
                print("prev: \(prev)")
                print("newValue: \(newValue)")
                return newValue.isEmpty ? [] : prev + newValue
            }
            .subscribe(onNext: { test in
                print("🫥 \(test)")
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
    
    private func scanTest() {
        
    }
}
