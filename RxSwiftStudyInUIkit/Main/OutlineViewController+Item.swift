//
//  OutlineViewController+Item.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/05/01.
//

import UIKit
import SwiftUI

extension OutlineViewController {
    
    func makeArchitectureItem() -> OutlineItem {
        return OutlineItem(
            title: "🏗Architecture",
            subitems: [
                OutlineItem(
                    title: "MVC",
                    viewController: MVCArchitecture.ViewController.self
                ),
                OutlineItem(
                    title: "MVP",
                    viewController: MVPArchitecture.ViewController.self
                ),
                OutlineItem(
                    title: "MVVM",
                    viewController: MVVMArchitecture.ViewController.self
                ),
                OutlineItem(
                    title: "ReactorKit",
                    viewController: ReactorKit.ViewController.self
                ),
                OutlineItem(
                    title: "MVI",
                    viewController: MVIArchitecture.ViewController.self
                ),
                OutlineItem(
                    title: "Ribs",
                    viewController: MVVMArchitecture.ViewController.self
                ),
                OutlineItem(
                    title: "MVVMCleanArchitecture",
                    viewController: MVVMCleanArchitecture.ViewController.self
                ),
                OutlineItem(
                    title: "TheComposableArchitecture",
                    swiftUIController: UIHostingController(rootView: AnyView(TCAView()))
                )
            ]
        )
    }
    
    func makeDisgnPatternItem() -> OutlineItem {
        return OutlineItem(
            title: "☀️DesignPatterns",
            subitems: [
                OutlineItem(
                    title: "생성(Create)",
                    subitems: [
                        OutlineItem(title: "Singleton",
                                    viewController: SingletonViewController.self),
                        OutlineItem(title: "Factory method",
                                    viewController: FactoryMethodViewController.self),
                        OutlineItem(title: "Absctract factory",
                                    viewController: AbstractFactoryViewController.self),
                        OutlineItem(title: "Builder",
                                    viewController: BuilderViewController.self),
                        OutlineItem(title: "Prototype",
                                    viewController: PrototypeViewController.self)
                    ]
                ),
                OutlineItem(
                    title: "구조(Structural)",
                    subitems: [
                        OutlineItem(title: "Adapter",
                                    viewController: AdapterViewController.self),
                        OutlineItem(title: "Bridge",
                                    viewController: BridgeViewController.self),
                        OutlineItem(title: "Composite",
                                    viewController: CompositeViewController.self),
                        OutlineItem(title: "Decorator",
                                    viewController: DecoratorViewController.self),
                        OutlineItem(title: "Facade",
                                    viewController: FacadeViewController.self),
                        OutlineItem(title: "Flyweight",
                                    viewController: FlyweightViewController.self),
                        OutlineItem(title: "Proxy",
                                    viewController: ProxyViewController.self)
                    ]
                ),
                OutlineItem(
                    title: "행동(Behavioral)",
                    subitems: [
                        OutlineItem(title: "책임연쇄(ChainOfResponsibility)",
                                    viewController: ChainOfResponsibilityViewController.self),
                        OutlineItem(title: "Command",
                                    viewController: CommandViewController.self),
                        OutlineItem(title: "Interpreter",
                                    viewController: InterpreterViewController.self),
                        OutlineItem(title: "Iterator",
                                    viewController: IteratorViewController.self),
                        OutlineItem(title: "Mediator",
                                    viewController: MediatorViewController.self),
                        OutlineItem(title: "Memento",
                                    viewController: MementoViewController.self),
                        OutlineItem(title: "Observer",
                                    viewController: ObserverViewController.self),
                        OutlineItem(title: "State",
                                    viewController: StateViewController.self),
                        OutlineItem(title: "Strategy",
                                    viewController: StrategyViewController.self),
                        OutlineItem(title: "Template Method",
                                    viewController: TemplateMethodViewController.self),
                        OutlineItem(title: "Template Callback",
                                    viewController: TemplateCallbackViewController.self),
                        OutlineItem(title: "Visitor",
                                    viewController: VisitorViewController.self)
                    ]
                )
            ]
        )
    }
}
