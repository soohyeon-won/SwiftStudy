//
//  BuilderPattern.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2023/01/05.
//

import UIKit

final class BuilderViewController: UIViewController {
    
    private let textView = UITextView().then {
        $0.isEditable = false
        $0.font = .systemFont(ofSize: 24)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(textView)
        
        textView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(24)
        }
        
        textView.text = """
        [ 빌더 패턴 ]
        장점
        복잡한 구성을 가진 인스턴스를 만들때, 순서가 중요하거나, 경우의 수에따라 생성자가 다이나믹하게 변하는 경우
        Director를 사용해서 복잡한 인스턴스를 만드는 과정을 숨겨둘 수 있음.
        마지막 make 함수를 통해서 리턴하려는 인스턴스가 온전한 객체인지 확인한 뒤 리턴할 수 있음
        
        단점
        객체를 많이 만들어야 하다보니 클래스가 늘어나는 단점이 있다고 볼 수 있음
        기존에 just생성자만 만들다가 builder, director를 만들어야하니 구조가 좀 복잡해진다는 단점이 있음
        하지만 이것은 대부분의 디자인패턴이 가지는 단점이라고 한다.
        """
        
        client()
    }
    
    private func client() {
        
        // Builder를 직접 호출하여
        let builder = DefaultWebviewBuilder()
            .showTopToolBar(isHidden: true)
            .showBottomToolBar(isHidden: true)
            .isTransparentMode(isHidden: true)
        
        let webviewController = builder.makeWebview()
        
        // Director를 통해서
        let webview = WebviewDirector(builder: DefaultWebviewBuilder())
            .makeDefaultWebview()
        
        let toolbarWebview = WebviewDirector(builder: DefaultWebviewBuilder())
            .makeToolbarWebview()
    }
}

