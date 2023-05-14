//
//  RibsChangeTextBuilder.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/14.
//

import RIBs

import RxSwift
import RxCocoa

protocol RibsChangeTextDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RibsChangeTextComponent: Component<RibsChangeTextDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RibsChangeTextBuildable: Buildable {
    func build(withListener listener: RibsChangeTextListener) -> RibsChangeTextRouting
}

final class RibsChangeTextBuilder: Builder<RibsChangeTextDependency>, RibsChangeTextBuildable {

    override init(dependency: RibsChangeTextDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RibsChangeTextListener) -> RibsChangeTextRouting {
        let _ = RibsChangeTextComponent(dependency: dependency)
        let viewController = RibsChangeTextViewController()
        let interactor = RibsChangeTextInteractor(presenter: viewController)
        interactor.listener = listener
        
        return RibsChangeTextRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
