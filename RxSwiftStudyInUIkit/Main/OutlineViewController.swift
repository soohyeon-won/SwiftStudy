/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A simple outline view for the sample app's main UI
*/

import UIKit

import SwiftUI

import ComposableArchitecture

class OutlineViewController: UIViewController {
    
    enum Section {
        case main
    }

    class OutlineItem: Hashable {
        let title: String
        let subitems: [OutlineItem]
        let outlineViewController: UIViewController.Type?
        let swiftUIController: UIHostingController<AnyView>?

        init(title: String,
             viewController: UIViewController.Type? = nil,
             swiftUIController: UIHostingController<AnyView>? = nil,
             subitems: [OutlineItem] = []) {
            self.title = title
            self.subitems = subitems
            self.outlineViewController = viewController
            self.swiftUIController = swiftUIController
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        static func == (lhs: OutlineItem, rhs: OutlineItem) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        private let identifier = UUID()
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, OutlineItem>! = nil
    var outlineCollectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = nil
        navigationItem.backBarButtonItem = nil
        navigationItem.rightBarButtonItems = nil

        configureCollectionView()
        configureDataSource()
    }
    
    /// NavigationView와 사용할 때 네비게이션바를 숨기면서 navigation 기능은 유지
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true) // 설정하면 swipeBack 기능 X
    }

    override func viewWillDisappear(_ animated: Bool) {
        /// 아래 코드를 삽입해주면 swipeBack기능이 유지되지만 SwiftUIView에서 navigationBarHidden(true)시에 swipeBack 기능이 안됨
        /// UINavigationController+Extensions 에 delegate 설정해주면 된다!
//      navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private lazy var menuItems: [OutlineItem] = {
        return [
            OutlineItem(
                title: "🦅 RxSwift",
                subitems: [
                    OutlineItem(title: "ShareStudyViewController", viewController: ShareStudyViewController.self),
                    OutlineItem(title: "MapStudyViewController", viewController: MapStudyViewController.self),
                    OutlineItem(title: "ReduceStudyViewController", viewController: ReduceStudyViewController.self),
                    OutlineItem(title: "MaterializeViewController", viewController: MaterializeViewController.self)
                ]
            ),
            OutlineItem(
                title: "🦉 UIKit",
                subitems: [
                    OutlineItem(title: "PagingViewController", viewController: PagingViewController.self),
                    OutlineItem(title: "ExpandableViewController", viewController: ExpandableViewController.self)
                ]
            ),
            OutlineItem(
                title: "🕊 SwiftUI",
                subitems: [
                    OutlineItem(
                        title: "1. Hello,SwiftUI",
                        subitems: [
                            OutlineItem(
                                title: "README.md",
                                swiftUIController: WebContentView(url: "\(githubPath)/SwiftUI/README.md").toHostingController()
                            )
                        ]
                    ),
                    OutlineItem(
                        title: "2. 뷰 구성하기",
                        subitems: [
                            OutlineItem(
                                title: "README.md",
                                swiftUIController: WebContentView(url: "\(githubPath)/SwiftUI/Chapter2-Generate%20View/README.md").toHostingController()
                            ),
                            OutlineItem(title: "Text", swiftUIController: UIHostingController(rootView: AnyView(SwiftUI_Text()))),
                            OutlineItem(title: "Image", swiftUIController: UIHostingController(rootView: AnyView(SwiftUI_Image()))),
                            OutlineItem(title: "Stack", swiftUIController: UIHostingController(rootView: AnyView(SwiftUI_Stack()))),
                            OutlineItem(title: "Stack-도형만들기", swiftUIController: UIHostingController(rootView: AnyView(SwiftUI_StackComb()))),
                            OutlineItem(
                                title: "2-2 실전 앱 구현하기",
                                swiftUIController: UIHostingController(rootView: AnyView(SweeterChapter2()))
                            )
                        ]
                    ),
                    OutlineItem(
                        title: "3. 네비게이션 뷰와 리스트",
                        subitems: [
                            OutlineItem(
                                title: "README.md",
                                swiftUIController: WebContentView(url: "\(githubPath)/SwiftUI/Chapter3-NavigationView%20and%20List/README.md").toHostingController()
                            ),
                            OutlineItem(
                                title: "3-1 Button",
                                swiftUIController: UIHostingController(rootView: AnyView(SweeterChapter3_Button()))
                            ),
                            OutlineItem(
                                title: "3-1 Navigation",
                                swiftUIController: UIHostingController(rootView: AnyView(SweeterChapter3_Navigation()))
                            ),
                            OutlineItem(
                                title: "3-1 List",
                                swiftUIController: UIHostingController(rootView: AnyView(SweeterChapter3_List()))
                            ),
                            OutlineItem(
                                title: "3-1 Section",
                                swiftUIController: UIHostingController(rootView: AnyView(SweeterChapter3_Section()))
                            )
                        ]
                    )
                ]
            ),
            OutlineItem(
                title: "✨ Develop Study",
                subitems: [
                    makeDisgnPatternItem(),
                    makeArchitectureItem()
                ]
            ),
            OutlineItem(
                title: "📚 Swift",
                subitems: [
                    OutlineItem(
                        title: "GCD",
                        swiftUIController: UIHostingController(
                            rootView: AnyView(GCDView())
                        )
                    )
                ]
            ),
            OutlineItem(
                title: "🐣 Combine",
                subitems: [
                    OutlineItem(
                        title: "README.md",
                        swiftUIController: WebContentView(url: "\(githubPath)/Study/Combine/README.md").toHostingController()
                    )
                ]
            ),
            OutlineItem(
                title: "🤖 Library",
                subitems: [
                    OutlineItem(
                        title: "Moya",
                        viewController: MoyaViewController.self
                    )
                ]
            )
        ]
    }()
    
}

extension OutlineViewController {
    
}

extension OutlineViewController {

    func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemGroupedBackground
        self.outlineCollectionView = collectionView
        collectionView.delegate = self
    }

    func configureDataSource() {
        
        let containerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> { (cell, indexPath, menuItem) in
            // Populate the cell with our item description.
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = menuItem.title
            contentConfiguration.textProperties.font = .preferredFont(forTextStyle: .headline)
            cell.contentConfiguration = contentConfiguration
            
            let disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [.outlineDisclosure(options: disclosureOptions)]
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> { cell, indexPath, menuItem in
            // Populate the cell with our item description.
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = menuItem.title
            cell.contentConfiguration = contentConfiguration
            cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, OutlineItem>(collectionView: outlineCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: OutlineItem) -> UICollectionViewCell? in
            // Return the cell.
            if item.subitems.isEmpty {
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            } else {
                return collectionView.dequeueConfiguredReusableCell(using: containerCellRegistration, for: indexPath, item: item)
            }
        }

        // load our initial data
        let snapshot = initialSnapshot()
        self.dataSource.apply(snapshot, to: .main, animatingDifferences: false)
    }

    func generateLayout() -> UICollectionViewLayout {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        return layout
    }

    func initialSnapshot() -> NSDiffableDataSourceSectionSnapshot<OutlineItem> {
        var snapshot = NSDiffableDataSourceSectionSnapshot<OutlineItem>()

        func addItems(_ menuItems: [OutlineItem], to parent: OutlineItem?) {
            snapshot.append(menuItems, to: parent)
            for menuItem in menuItems where !menuItem.subitems.isEmpty {
                addItems(menuItem.subitems, to: menuItem)
            }
        }
        
        addItems(menuItems, to: nil)
        return snapshot
    }

}

extension OutlineViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let menuItem = self.dataSource.itemIdentifier(for: indexPath) else { return }
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if menuItem.outlineViewController.self == MoyaViewController.self {
            navigationController?.pushViewController(MoyaViewController(viewModel: MoyaViewModel()), animated: true)
            return
        }
        
        if let viewController = menuItem.outlineViewController {
            navigationController?.pushViewController(viewController.init(), animated: true)
        }
        
        if let swiftUIView = menuItem.swiftUIController {
            addChild(swiftUIView)
            view.addSubview(swiftUIView.view)
            
            navigationController?.pushViewController(swiftUIView, animated: true)
            
            swiftUIView.didMove(toParent: self)
        }
        
    }
}
