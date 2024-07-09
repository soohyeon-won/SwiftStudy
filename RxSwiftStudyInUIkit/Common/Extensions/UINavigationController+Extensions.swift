//
//  UINavigationController+Extensions.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 1/1/24.
//

import UIKit

// NavigationView
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

import SwiftUI

extension View {
    
    func toHostingController() -> UIHostingController<AnyView> {
        UIHostingController(rootView: AnyView(self))
    }
}
