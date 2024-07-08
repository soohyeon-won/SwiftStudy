//
//  SingletonViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2022/12/10.
//
import SwiftUI

struct SingletonView: View {
    
    var body: some View {
        ScrollView {
            Text("""
                [ 싱글톤 패턴 ]
                
                thread safety하게 구현하는 것이 중요
                - synchronized
                - double check locking
                - Immutable
                
                swift는 전역, 정적 변수 / 싱글톤 객체 lazy하게 생성, atomic함 보장
                let 선언 Immutable 하도록 설정 가능
                thread safety = Immutable + atomic함 보장
                
                + atomic함: 공유자원에 변경이 일어나고 있을 때는 다른 스레드가 접근X
                
                싱글톤 패턴은 객체지향적 관점에서 의존성을 주입할 수 없어(DIP 위반) 테스트가 어렵고,
                구체타입에 의존해야 하므로 유연성이 떨어진다(OCP 위반 가능성 높음)는 단점이 있음
                """)
            .font(.system(size: 24))
            .padding(24)
            .background(Color.white)
            .cornerRadius(8)
            
            CodeView(code: """
            final class Settings {
                
                // Swift에서 전역, 정적 변수는 항상 lazy하게 초기화
                // static으로 선언한 싱글톤 객체 역시 lazy하게 초기화
                // Swift는 전역, 정적 변수의 초기화 과정이 atomic함을 보장
                // 'atomic하다'는 것은 멀티 스레드 환경에서 공유자원에 변경이 일어나고 있을 때는 다른 스레드가 접근하지 못함을 의미
                // 해당 자원에 변경이 일어나기 전이나 일어난 후에만 접근 가능하므로 읽기와 쓰기에 대한 무결성을 보장
                // atomic하다는 것만으로는 Thread-Safe를 보장한다고 할 수 없음.
                // Thread-Safe하기 위해서는 atomic함과 동시에 immutable해야함
                
                // ex java synchronized
                static let settings = Settings()
                
                // 싱글톤 패턴은 객체지향적 관점에서 의존성을 주입할 수 없어(DIP 위반) 테스트가 어렵고, 구체타입에 의존해야 하므로 유연성이 떨어진다(OCP 위반 가능성 높음)는 단점이 있음
                private init() {
                    
                }
            }
            """)
        }
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .onAppear {
//            SettingsNive.getInstance()
//            SettingsNive.getInstance2()
        }
    }
}
