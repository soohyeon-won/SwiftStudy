//
//  Guideline4_design.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 7/19/24.
//

import SwiftUI

struct Guideline4_design: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("[iOS] App Store 심사 리젝 대응 (Guideline 4.0 - Design)")
                    .font(.title)
                
                Text("회원가입 및 회원탈퇴는 모두 앱 내에서 처리")
                    .font(.title2)
                
                Text("""
            1. SFSafariViewController 사용
            """)
                
                CodeView(code: """
            import SafariServices
            
            struct SafariView: UIViewControllerRepresentable {
                let url: URL
            
                func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
                    return SFSafariViewController(url: url)
                }
            
                func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
                    // 업데이트 로직이 필요할 경우 추가
                }
            }
            """)
                
                Text("""
            2. ASWebAuthenticationSession
            """)
                
                CodeView(code: """
            import AuthenticationServices
            
            class AuthenticationViewModel: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
                func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
                    return UIApplication.shared.windows.first!
                }
                
                func startAuthentication() {
                    let authURL = URL(string: "https://example.com/auth")!
                    let callbackURLScheme = "myapp" // 인증 완료 시 여기서 설정한 값으로 Appdelegate의 openURLOptions 함수로 들어옴
            
                    let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: callbackURLScheme) { callbackURL, error in
                        // 처리 로직 추가
                    }
            
                    session.presentationContextProvider = self
                    session.start()
                }
            }
            """)
                
                CodeView(code: """
             @UIApplicationMain
             class AppDelegate: UIResponder, UIApplicationDelegate {
             
                 func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
                     if url.scheme == "myapp" {
                         // 여기서 URL을 처리하는 로직을 추가합니다.
                         print("App returned with URL: \\(url)")
                         return true
                     }
                     return false
                 }
             
                 // 기타 AppDelegate 메서드
             }
             """)
                
                if let url = URL(string: "https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession") {
                    Link("애플 공식 문서 ASWebAuthenticationSession", destination: url)
                }
            }
            .padding()
        }
    }
}
