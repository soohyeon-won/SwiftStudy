//
//  Copyright (c) 2017. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import RIBs

protocol RootInteractable: Interactable, RibsChangeTextListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    init(interactor: RootInteractable,
         viewController: RootViewControllable,
        changeTextBuilder: RibsChangeTextBuilder) {
        self.changeTextBuilder = changeTextBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
        
        didLoad()
    }

    override func didLoad() {
        super.didLoad()

        let loggedOut = changeTextBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        attachChild(loggedOut)
        viewController.present(viewController: loggedOut.viewControllable)
    }

    // MARK: - Private

    private let changeTextBuilder: RibsChangeTextBuilder

    private var loggedOut: ViewableRouting?
    
    func routeToLoggedIn() {
        let builder = changeTextBuilder.build(withListener: interactor)
        attachChild(builder)
    }
}
