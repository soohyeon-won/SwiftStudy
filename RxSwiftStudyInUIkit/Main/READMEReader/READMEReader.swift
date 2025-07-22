//
//  READMEReader.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 4/27/24.
//

import SwiftUI

struct MarkdownView: View {

    let filePath: String
    
    @State private var fileContent: String?
    
    var body: some View {
        VStack {
            if let content = fileContent {
                ScrollView(.vertical) {
                    Text(.init(content)) // init시 LocalizedStringKey 사용됨
                        .padding()
                }
            }
        }
        .onAppear {
            fileContent = readMarkdownFile(from: filePath)
        }
    }

    func readMarkdownFile(from path: String) -> String? {
        if let file = Bundle.main.path(forResource: "README.md", ofType: nil),
           let content = try? String(contentsOf: URL(fileURLWithPath: file)) {
            return content
        }
        
        let fileURL = URL(fileURLWithPath: path)
        do {
            let fileContent = try String(contentsOf: fileURL, encoding: .utf8)
            return fileContent
        } catch {
            print("Failed to read file: \(error)")
            return nil
        }
    }
}

import WebKit

struct WebContentView: View {
    // 로드할 웹 페이지의 URL
    let url: String
    
    var body: some View {
        // WebView를 ContentView의 일부로 포함시킵니다.
        WebView(url: URL(string: url)!)
            .edgesIgnoringSafeArea(.all) // 전체 화면에 표시하도록 합니다.
    }
}

struct WebView: UIViewRepresentable {
    // 로드할 URL을 나타내는 프로퍼티
    let url: URL
    
    // UIView를 생성하여 반환합니다.
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }
    
    // UIView를 업데이트합니다.
    func updateUIView(_ webView: WKWebView, context: Context) {
        // 주어진 URL을 로드합니다.
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebView: WKNavigationDelegate {

    // 1. 페이지 이동 여부 결정 (딥링크 처리, 외부 앱 이동 등)
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }

        let urlString = url.absoluteString
        print("🌐 요청 URL: \(urlString)")

        // 예: 외부 앱 처리
        if url.scheme == "tel" || url.scheme == "mailto" {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
        }

        // 예: 앱 내부 딥링크 처리
        if urlString.hasPrefix("myapp://") {
            handleCustomScheme(url)
            decisionHandler(.cancel)
            return
        }

        // 예: 파일 다운로드 등은 별도로 처리
        if urlString.hasSuffix(".pdf") || urlString.contains("download") {
            handleDownload(url)
            decisionHandler(.cancel)
            return
        }

        decisionHandler(.allow)
    }

    // 2. 응답 수신 후 처리 (헤더 체크 등)
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        if let httpResponse = navigationResponse.response as? HTTPURLResponse {
            print("📡 응답 코드: \(httpResponse.statusCode)")
            if httpResponse.statusCode == 401 {
                showLoginPage()
                decisionHandler(.cancel)
                return
            }
        }

        decisionHandler(.allow)
    }

    // 3. 로딩 시작
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("🚀 로딩 시작")
        showLoadingIndicator()
    }

    // 4. 콘텐츠 시작 수신
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("📥 콘텐츠 수신 중")
    }

    // 5. 로딩 완료
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("✅ 로딩 완료")
        hideLoadingIndicator()

        // JS Inject 예시
        webView.evaluateJavaScript("document.title") { result, error in
            if let title = result as? String {
                self.title = title
            }
        }
    }

    // 6. 로딩 실패
    func webView(_ webView: WKWebView,
                 didFail navigation: WKNavigation!,
                 withError error: Error) {
        print("❌ 로딩 실패: \(error.localizedDescription)")
        hideLoadingIndicator()
        showErrorPage()
    }

    // 7. 초기 요청 실패
    func webView(_ webView: WKWebView,
                 didFailProvisionalNavigation navigation: WKNavigation!,
                 withError error: Error) {
        print("❌ 초기 로딩 실패: \(error.localizedDescription)")
        hideLoadingIndicator()
        showErrorPage()
    }

    // 8. HTTPS 인증서 관련 (필요 시)
    func webView(_ webView: WKWebView,
                 didReceive challenge: URLAuthenticationChallenge,
                 completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // 신뢰할 수 없는 인증서 허용 시 (주의!)
        completionHandler(.performDefaultHandling, nil)
    }
    
    // MARK: - 보조 함수
    
    private func handleCustomScheme(_ url: URL) {
        // 앱 내부에서 처리할 딥링크 로직
        print("📲 딥링크 처리: \(url)")
    }

    private func handleDownload(_ url: URL) {
        // 다운로드 처리 로직
        print("⬇️ 다운로드 처리: \(url)")
        UIApplication.shared.open(url)
    }

    private func showLoadingIndicator() {
        // 로딩 인디케이터 표시
    }

    private func hideLoadingIndicator() {
        // 로딩 인디케이터 숨김
    }

    private func showLoginPage() {
        // 로그인 화면 이동 등
    }

    private func showErrorPage() {
        // 에러 UI 표시 등
    }

}
