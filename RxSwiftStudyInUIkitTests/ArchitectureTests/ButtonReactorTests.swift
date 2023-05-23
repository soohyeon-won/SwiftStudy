//
//  ReactorKit+Tests.swift
//  RxSwiftStudyInUIkitTests
//
//  Created by won soohyeon on 2023/05/09.
//
import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import RxSwiftStudyInUIkit

final class ButtonReactorTests: XCTestCase {
    
    var reactor: ReactorKit.ButtonReactor!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        reactor = ReactorKit.ButtonReactor()
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        reactor = nil
        disposeBag = nil
        try super.tearDownWithError()
    }
    
    func testButtonPressed() {
        // given
        let scheduler = TestScheduler(initialClock: 0)
        let observer = scheduler.createObserver(String.self)
        
        reactor.state.map { $0.text }
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        // when
        scheduler.createColdObservable(
            [.next(10, ()), .next(20, ())]
        )
        .map { ReactorKit.ButtonReactor.Action.changeText }
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        // then
        scheduler.start()
        let expectedEvents: [Recorded<Event<String>>] = [
            .next(0, "Press the button"),
            .next(10, "Button pressed!"),
            .next(20, "Button pressed!")
        ]
        
        XCTAssertEqual(observer.events, expectedEvents)
    }
}
