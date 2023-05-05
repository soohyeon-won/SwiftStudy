//
//  MVVMArchtectureViewModelTests.swift
//  RxSwiftStudyInUIkitTests
//
//  Created by soohyeon won on 2023/05/03.
//

import XCTest
@testable import RxSwiftStudyInUIkit
import RxSwift
import RxCocoa

class MVVMArchtectureViewModelTests: XCTestCase {
    
    var disposeBag: DisposeBag = DisposeBag()
    var model = MVVMArchitecture.Model()
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func testOutputLabelText() {
        // Given
        let viewModel = MVVMArchitecture.ViewModel()
        let buttonTap = PublishRelay<Void>()
        let input = MVVMArchitecture.ViewModel.Input(buttonTap: buttonTap.asSignal())
        let output = viewModel.transform(input: input)
        
        let expectation = XCTestExpectation(description: "label text changed")
        var labelText: String?
        output.labelText
            .drive(onNext: { text in
                labelText = text
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        // When
        buttonTap.accept(())
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(labelText, "Label Text Changed")
    }
}
