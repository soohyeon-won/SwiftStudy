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
        let mapBasic = PublishRelay<String>()
        let flatMap = PublishRelay<Void>()
        let flatMapLatest = PublishRelay<Void>()
    }
    
    struct Output {
        let bindMap = PublishRelay<String>()
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
            return Disposables.create()
        }
    }
    
    func bindInput() {
        mapBasicTest()
        
        input.flatMap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.flatMapTest()
            })
            .disposed(by: disposeBag)
        
        input.flatMapLatest
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.flatMapLatestTest()
            })
            .disposed(by: disposeBag)
    }
    
    private func mapBasicTest() {
        let observable = input.mapBasic
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.createSingleRequester()
            }
            .asObservable()
            .share()
        
        observable
//            .map { test in
//                return test // 리턴을 명시하지 않으면 Void가 리턴된다.
//            }
            .map { str -> String in
                return str
            }
            .subscribe(onNext: { str in
                print("🥳 subscribe map: \(str)")
            })
            .disposed(by: disposeBag)
        
        observable
            .map { str -> Observable<String> in
                return Observable.just(str)
            }.subscribe(onNext: { str in
                print("💙 subscribe map: \(str)") // Observable 리턴됨
            })
            .disposed(by: disposeBag)
        
        observable
            .flatMap { str -> Observable<String> in
                return Observable.just(str)
            }.subscribe(onNext: { str in
                print("👹 subscribe flatMap: \(str)") // 평탄화된 Observable 리턴됨
            })
            .disposed(by: disposeBag)
        
        observable
            .flatMapLatest { str -> Observable<String> in
                return Observable.just(str)
            }.subscribe(onNext: { str in
                print("⚠️ subscribe flatMapLatest: \(str)") // 평탄화된 마지막 Observable 리턴됨
            })
            .disposed(by: disposeBag)
    }
    
    /**
     🔷
     ♦️
     🔷
     🔶
     ♦️
     🔶
     */
    private func flatMapTest() {
        Observable<Int>.timer(.seconds(0), period: .seconds(1), scheduler: MainScheduler.instance)
            .take(3)
            .flatMap({ element in
                return Observable<Int>.timer(.seconds(0), period: .seconds(2), scheduler: MainScheduler.instance)
                    .take(2)
                    .map { innerElement in
                        return "\(Shape(rawValue: element)!.diamond)"
                    }
            }).subscribe(onNext: { element in
                print(element)
            }).disposed(by: disposeBag)
    }
    
    /**
     🔷
     ♦️
     🔶
     🔶
     */
    private func flatMapLatestTest() {
        Observable<Int>.timer(.seconds(0), period: .seconds(1), scheduler: MainScheduler.instance)
            .take(3)
            .flatMapLatest({ element in
                return Observable<Int>.timer(.seconds(0), period: .seconds(2), scheduler: MainScheduler.instance)
                    .take(2)
                    .map { innerElement in
                        return "\(Shape(rawValue: element)!.diamond)"
                    }
            }).subscribe(onNext: { element in
                print(element)
            }).disposed(by: disposeBag)
    }
    
    func bindOutput() {
        output.bindMap
            .subscribe(onNext: { str in
                print("🤖 bindMap: \(str)")
            })
            .disposed(by: disposeBag)
    }
}

enum Shape: Int {
    case 🔵 = 0
    case 🔴 = 1
    case 🟠 = 2
    
    var diamond: String {
        switch self {
        case .🔵:
            return "🔷"
        case .🔴:
            return "♦️" // <- 믿기 힘들겠지만 이거 빨간 다이아 입니다..!😅
        case .🟠:
            return "🔶"
        }
    }
}
