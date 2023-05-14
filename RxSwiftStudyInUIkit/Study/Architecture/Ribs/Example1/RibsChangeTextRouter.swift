//
//  RibsChangeTextRouter.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/14.
//

import RIBs

protocol RibsChangeTextInteractable: Interactable {
    var router: RibsChangeTextRouting? { get set }
    var listener: RibsChangeTextListener? { get set }
}

protocol RibsChangeTextViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RibsChangeTextRouter: ViewableRouter<RibsChangeTextInteractable, RibsChangeTextViewControllable>, RibsChangeTextRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: RibsChangeTextInteractable, viewController: RibsChangeTextViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
