//
//  CacheEx2View.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 5/15/24.
//

import SwiftUI

struct BasicCacheView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Swift의 기본 캐시")
                    .font(.title)
                    .fontWeight(.bold)
                
                NSCacheSectionView()
                DictionaryCacheSectionView()
            }
            .padding()
        }
    }
}

struct NSCacheSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("1. NSCache 클래스")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("NSCache는 캐시 데이터를 저장하기 위한 클래스로, 자동으로 메모리 경계를 넘지 않도록 관리합니다.")
            
            Text("NSCache 설정 및 제한 사항:")
                .font(.subheadline)
                .fontWeight(.bold)
            Text("NSCache는 캐시의 크기를 제한할 수 있는 다양한 설정을 제공합니다. 예를 들어, 최대 캐시 크기와 개체 수를 설정할 수 있습니다.")
            Text("NSCache는 메모리 내에서만 작동하며, 앱이 재기동될 때 데이터가 유지되지 않습니다. NSCache는 앱의 메모리 내에서 일시적으로 데이터를 저장하여 빠른 액세스를 가능하게 하지만, 앱이 종료되거나 재기동되면 NSCache에 저장된 모든 데이터는 사라집니다.")
            Text("메모리캐싱과 NSCache 모두 데이터를 메모리에 저장하여 빠르게 접근할 수 있게 합니다. 그러나 메모리캐싱은 주로 직접 데이터 구조를 사용하여 구현되고, NSCache는 키-값 쌍으로 데이터를 저장하는 Objective-C 클래스입니다.")
//            Text("NSCache는 메모리에 데이터를 캐싱하여 빠른 접근을 가능하게 합니다. 주요 사용 사례로는 이미지 캐싱, 네트워크 요청 결과 캐싱, 데이터베이스 쿼리 결과 캐싱 등이 있습니다.")
                    
            
            NSCacheExampleView()
            
            Text("NSCache 메서드와 프로퍼티 사용법:")
                .font(.subheadline)
                .fontWeight(.bold)
            Text("NSCache는 setObject(_:forKey:), object(forKey:), removeObject(forKey:) 등의 메서드를 제공합니다.")
            
            
            NSCacheUsageExampleView()
        }
    }
}

struct DictionaryCacheSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("2. Dictionary를 사용한 캐싱")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("Swift의 Dictionary를 사용하여 간단한 캐시를 구현할 수 있습니다.")
            
            DictionaryCacheExampleView()
        }
    }
}

struct NSCacheExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("NSCache 예제:")
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text("아래는 NSCache를 사용하여 캐시를 설정하는 간단한 예제입니다.")
            
            CodeView(code: """
            let cache = NSCache<NSString, NSString>()
            cache.countLimit = 100 // 최대 캐시 개체 수 설정
            cache.totalCostLimit = 1024 * 1024 * 10 // 최대 캐시 크기 (10MB) 설정
            """)
        }
    }
}

struct NSCacheUsageExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("NSCache 사용 예제:")
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text("아래는 NSCache의 메서드를 사용하는 예제입니다.")
            
            CodeView(code: """
            let cache = NSCache<NSString, NSString>()
            
            // 데이터 저장
            cache.setObject("Hello, world!", forKey: "greeting")
            
            // 데이터 가져오기
            if let greeting = cache.object(forKey: "greeting") {
                print(greeting) // 출력: Hello, world!
            }
            
            // 데이터 제거
            cache.removeObject(forKey: "greeting")
            """)
        }
    }
}

struct DictionaryCacheExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("메모리캐싱")
                .font(.headline)
            Text("Dictionary를 사용한 캐싱 예제:")
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text("아래는 Swift Dictionary를 사용하여 캐시를 구현하는 간단한 예제입니다.")
            
            CodeView(code: """
            var cache = [String: String]()
            
            // 데이터 저장
            cache["greeting"] = "Hello, world!"
            
            // 데이터 가져오기
            if let greeting = cache["greeting"] {
                print(greeting) // 출력: Hello, world!
            }
            
            // 데이터 제거
            cache.removeValue(forKey: "greeting")
            """)
        }
    }
}

struct CodeView: View {
    let code: String
    
    var body: some View {
        Text(code)
            .font(.system(.body, design: .monospaced))
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
    }
}

struct BasicCacheView_Previews: PreviewProvider {
    static var previews: some View {
        BasicCacheView()
    }
}
