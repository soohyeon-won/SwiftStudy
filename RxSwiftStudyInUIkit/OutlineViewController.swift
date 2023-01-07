/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A simple outline view for the sample app's main UI
*/

import UIKit

import SwiftUI

class OutlineViewController: UIViewController {

    enum Section {
        case main
    }

    class OutlineItem: Hashable {
        let title: String
        let subitems: [OutlineItem]
        let outlineViewController: UIViewController.Type?
        let swiftUIController: UIHostingController<BaseView>?

        init(title: String,
             viewController: UIViewController.Type? = nil,
             swiftUIController: UIHostingController<BaseView>? = nil,
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
        navigationItem.title = "soohyeon-won Study"
        configureCollectionView()
        configureDataSource()
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
                    OutlineItem(title: "swiftUIController", swiftUIController: UIHostingController(rootView: BaseView()))
                ]
            ),
            OutlineItem(
                title: "✨ Study",
                subitems: [
                    OutlineItem(
                        title: "☀️DesignPatterns",
                        subitems: [
                            OutlineItem(title: "Singleton",
                                        viewController: SingletonViewController.self),
                            OutlineItem(title: "Factory method",
                                        viewController: FactoryMethodViewController.self),
                            OutlineItem(title: "Absctract factory",
                                        viewController: AbstractFactoryViewController.self),
                            OutlineItem(title: "Builder",
                                        viewController: BuilderViewController.self)
                        ]
                    )
                ]
            )
        ]
    }()
    
}//

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
        
        if let viewController = menuItem.outlineViewController {
            navigationController?.pushViewController(viewController.init(), animated: true)
        }
        
        if let swiftUIView = menuItem.swiftUIController {
            navigationController?.pushViewController(swiftUIView, animated: true)
        }
        
    }
}
