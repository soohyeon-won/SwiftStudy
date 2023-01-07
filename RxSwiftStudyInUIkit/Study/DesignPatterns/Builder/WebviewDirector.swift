//
//  WebviewDirector.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/01/07.
//

import Foundation

class WebviewDirector {
    
    let builder: WebviewBuilder
    
    init(builder: WebviewBuilder) {
        self.builder = builder
    }
}

extension WebviewDirector {
    
    func makeDefaultWebview() -> WebviewController {
        return builder
            .showTopToolBar(isHidden: true)
            .showBottomToolBar(isHidden: true)
            .isTransparentMode(isHidden: true)
            .makeWebview()
    }
    
    func makeToolbarWebview() -> WebviewController {
        return builder
            .showTopToolBar(isHidden: false)
            .showBottomToolBar(isHidden: false)
            .isTransparentMode(isHidden: false)
            .makeWebview()
    }
}
