//
//  RibsChangeTextInteractor.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/14.
//

import RIBs
import RxSwift

protocol RibsChangeTextRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RibsChangeTextPresentable: Presentable {
    var listener: RibsChangeTextPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RibsChangeTextListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    
}

final class RibsChangeTextInteractor: PresentableInteractor<RibsChangeTextPresentable>, RibsChangeTextInteractable {

    weak var router: RibsChangeTextRouting?
    weak var listener: RibsChangeTextListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RibsChangeTextPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}

extension RibsChangeTextInteractor: RibsChangeTextPresentableListener {
    
    func didTapTextChangeBtn() {
        print("???")
    }
}
