//
//  Builder.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2023/01/05.
//

import Foundation
import UIKit

class WebviewController: UIViewController {
    
    var showTopToolBar: Bool
    var showBottomToolBar: Bool
    var isTransparentMode: Bool
    
    init(
        showTopToolBar: Bool,
        showBottomToolbar: Bool,
        isTransparentMode: Bool
    ) {
        self.showTopToolBar = showTopToolBar
        self.showBottomToolBar = showBottomToolbar
        self.isTransparentMode = isTransparentMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol WebviewBuilder {
    func showTopToolBar(isHidden: Bool) -> WebviewBuilder
    func showBottomToolBar(isHidden: Bool) -> WebviewBuilder
    func isTransparentMode(isHidden: Bool) -> WebviewBuilder
    
    func makeWebview() -> WebviewController
}

class DefaultWebviewBuilder: WebviewBuilder {
    
    var showTopToolBar = false
    var showBottomToolBar = false
    var isTransparentMode = false
    
    func showTopToolBar(isHidden: Bool) -> WebviewBuilder {
        self.showTopToolBar = isHidden
        return self
    }
    
    func showBottomToolBar(isHidden: Bool) -> WebviewBuilder {
        self.showBottomToolBar = isHidden
        return self
    }
    
    func isTransparentMode(isHidden: Bool) -> WebviewBuilder {
        self.isTransparentMode = isHidden
        return self
    }
    
    func makeWebview() -> WebviewController {
        WebviewController(
            showTopToolBar: showTopToolBar,
            showBottomToolbar: showBottomToolBar,
            isTransparentMode: isTransparentMode
        )
    }
}
