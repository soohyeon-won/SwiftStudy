//
//  Ribs.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/10.
//

import UIKit

struct Ribs {
 
    final class ViewController: UIViewController {
        
        public var window: UIWindow? // 임시로 window 생성, 실제로는 프로젝트 시작할때 Scnene에서 Ribs시작
        private var launchRouter: LaunchRouting?
        
        override func viewDidLoad() {
            view.backgroundColor = .systemBlue
            
            let launchRouter = RootBuilder(dependency: AppComponent()).build()

            self.launchRouter = launchRouter
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            
            let window = UIWindow(windowScene: windowScene)
            window.addSubview(view)
            didMove(toParent: self)
            
            self.window = window
            
            launchRouter.launchFromWindow(window)
        }
    }
}


import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
}
