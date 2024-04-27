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
        return webView
    }
    
    // UIView를 업데이트합니다.
    func updateUIView(_ webView: WKWebView, context: Context) {
        // 주어진 URL을 로드합니다.
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
