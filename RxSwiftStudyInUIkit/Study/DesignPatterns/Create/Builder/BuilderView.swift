//
//  BuilderPattern.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2023/01/05.
//

import SwiftUI

struct BuilderView: View {
    
    private let textViewContent = """
        [ 빌더 패턴 ]
        장점
        복잡한 구성을 가진 인스턴스를 만들때, 순서가 중요하거나, 경우의 수에따라 생성자가 다이나믹하게 변하는 경우
        Director를 사용해서 복잡한 인스턴스를 만드는 과정을 숨겨둘 수 있음.
        마지막 make 함수를 통해서 리턴하려는 인스턴스가 온전한 객체인지 확인한 뒤 리턴할 수 있음
        
        단점
        객체를 많이 만들어야 하다보니 클래스가 늘어나는 단점이 있다고 볼 수 있음
        기존에 just생성자만 만들다가 builder, director를 만들어야하니 구조가 복잡해짐
        하지만 이것은 대부분의 디자인패턴이 가지는 단점
        
        나의활용
        - 웹뷰를 생성할 때, 상단, 하단 toolbar가 있을지 없을지 등
        여러가지 옵션에 따라 다이나믹하게 바뀌는 웹뷰를 Builder패턴으로 구현했음
        Director를 통해서 자주 사용하는 웹뷰 메이커를 만들어 둠
        """
    
    var body: some View {
        ScrollView {
            Text(textViewContent)
                .font(.system(size: 24))
                .padding(24)
                .background(Color.white)
                .cornerRadius(8)
            
            CodeView(code: """
            // Builder를 직접 호출하여
            let builder = DefaultWebviewBuilder()
                .showTopToolBar(isHidden: true)
                .showBottomToolBar(isHidden: true)
                .isTransparentMode(isHidden: true)
            
            let webviewController = builder.makeWebview()
            
            // 실제 Builder
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
                
                // 해당 함수를 통해 유효성 판별도 가능!
                func makeWebview() -> WebviewController {
                    WebviewController(
                        showTopToolBar: showTopToolBar,
                        showBottomToolbar: showBottomToolBar,
                        isTransparentMode: isTransparentMode
                    )
                }
            }
            
            // Director를 통해서 자주 사용하는 웹뷰 메이커를 만들어 둠
            let webview = WebviewDirector(builder: DefaultWebviewBuilder())
                .makeDefaultWebview()
            
            let toolbarWebview = WebviewDirector(builder: DefaultWebviewBuilder())
                .makeToolbarWebview()
            
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
            """)
        }
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .onAppear {
            client()
        }
    }
    
    private func client() {
        // Builder를 직접 호출하여
        let builder = DefaultWebviewBuilder()
            .showTopToolBar(isHidden: true)
            .showBottomToolBar(isHidden: true)
            .isTransparentMode(isHidden: true)
        
        let webviewController = builder.makeWebview()
        
        // Director를 통해서 자주 사용하는 웹뷰 메이커를 만들어 둠
        let webview = WebviewDirector(builder: DefaultWebviewBuilder())
            .makeDefaultWebview()
        
        let toolbarWebview = WebviewDirector(builder: DefaultWebviewBuilder())
            .makeToolbarWebview()
    }
}
