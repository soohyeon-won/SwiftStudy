//
//  ChacheEx3View.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 5/15/24.
//

import SwiftUI

struct PracticalCacheView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("캐시의 실용적인 사용")
                    .font(.title)
                    .fontWeight(.bold)
                
                ImageCachingSectionView()
                NetworkDataCachingSectionView()
                OtherObjectCachingSectionView()
            }
            .padding()
        }
    }
}

struct ImageCachingSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("1. 이미지 캐싱")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("UIImageView의 이미지 로딩 및 캐싱을 실습합니다.")
            
            ImageCachingExampleView()
        }
    }
}

struct NetworkDataCachingSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("2. 네트워크 데이터 캐싱")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("URLSession을 통한 데이터 요청 결과 캐싱을 학습합니다.")
            
            NetworkDataCachingExampleView()
        }
    }
}

struct OtherObjectCachingSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("3. 기타 객체 캐싱")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("JSON 데이터, 사용자 정의 객체 등의 캐싱 방법을 알아봅니다.")
            
            OtherObjectCachingExampleView()
        }
    }
}

struct ImageCachingExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("이미지 캐싱 예제:")
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text("아래는 URLSession과 NSCache를 사용하여 이미지를 캐싱하는 예제입니다.")
            
            CodeView(code: """
            import UIKit

            let imageCache = NSCache<NSString, UIImage>()

            extension UIImageView {
                func loadImage(from url: URL) {
                    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
                        self.image = cachedImage
                        return
                    }

                    URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data, let image = UIImage(data: data) else { return }
                        imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }.resume()
                }
            }
            """)
        }
    }
}

struct NetworkDataCachingExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("네트워크 데이터 캐싱 예제:")
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text("아래는 URLSession과 NSCache를 사용하여 네트워크 요청 결과를 캐싱하는 예제입니다.")
            
            CodeView(code: """
            import Foundation

            let dataCache = NSCache<NSString, NSData>()

            func fetchData(from url: URL, completion: @escaping (Data?) -> Void) {
                if let cachedData = dataCache.object(forKey: url.absoluteString as NSString) {
                    completion(cachedData as Data)
                    return
                }

                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data else {
                        completion(nil)
                        return
                    }
                    dataCache.setObject(data as NSData, forKey: url.absoluteString as NSString)
                    completion(data)
                }.resume()
            }
            """)
        }
    }
}

struct OtherObjectCachingExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("기타 객체 캐싱 예제:")
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text("아래는 JSON 데이터나 사용자 정의 객체를 캐싱하는 예제입니다.")
            
            CodeView(code: """
            import Foundation

            let jsonCache = NSCache<NSString, NSDictionary>()

            func fetchJSON(from url: URL, completion: @escaping (NSDictionary?) -> Void) {
                if let cachedJSON = jsonCache.object(forKey: url.absoluteString as NSString) {
                    completion(cachedJSON)
                    return
                }

                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data,
                          let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                        completion(nil)
                        return
                    }
                    jsonCache.setObject(jsonObject, forKey: url.absoluteString as NSString)
                    completion(jsonObject)
                }.resume()
            }
            """)
        }
    }
}

struct PracticalCacheView_Previews: PreviewProvider {
    static var previews: some View {
        PracticalCacheView()
    }
}
