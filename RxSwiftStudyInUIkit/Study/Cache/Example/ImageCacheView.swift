//
//  ImageCacheView.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 5/15/24.
//
import SwiftUI
import Combine

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        cache.countLimit = 100 // 최대 100개의 이미지
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        let cost = image.size.height * image.size.width * image.scale * image.scale
        cache.setObject(image, forKey: key as NSString, cost: Int(cost))
    }
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}

struct ImageCacheView: View {
    @State private var image: UIImage?
    @State private var cancellable: AnyCancellable?
    
    private let testURL: String = "https://picsum.photos/600/400"
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Empty image")
            }
            
            Button("Fetch Image") {
                loadImage()
            }
            .padding()
            
            Button("Clear Cache") {
                ImageCacheManager.shared.clearCache()
            }
            .padding()
            
            Button("Load Cache") {
                let imageURL = URL(string: testURL)!
                if let cachedImage = ImageCacheManager.shared.getImage(forKey: imageURL.absoluteString) {
                    image = cachedImage
                } else {
                    image = nil
                }
            }
            .padding()
        }
        .onDisappear {
            cancellable?.cancel()
        }
    }
    
    func loadImage() {
        let imageURL = URL(string: testURL)!
        if let cachedImage = ImageCacheManager.shared.getImage(forKey: imageURL.absoluteString) {
            image = cachedImage
        } else {
            cancellable = URLSession.shared.dataTaskPublisher(for: imageURL)
                .map { response in
                    return UIImage(data: response.data)
                }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { downloadedImage in
                    if let downloadedImage = downloadedImage {
                        ImageCacheManager.shared.setImage(downloadedImage, forKey: imageURL.absoluteString)
                        self.image = downloadedImage
                    }
                }
        }
    }
}

struct ImageCacheView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCacheView()
    }
}

struct CacheComparisonView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("캐싱 방법 비교")
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                Text("NSCache + File System")
                    .fontWeight(.bold)
                Spacer()
                Text("UserDefaults")
                    .fontWeight(.bold)
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("장점")
                        .fontWeight(.bold)
                    Text("- 크고 복잡한 데이터를 저장하는 데 용이")
                    Text("- NSCache를 사용하여 메모리에 데이터를 캐싱하여 빠른 접근 가능")
                    Text("- 파일 시스템을 통한 디스크 I/O를 활용하여 데이터를 영구 저장 가능")
                    Text("단점")
                        .fontWeight(.bold)
                    Text("- 파일 시스템을 통한 디스크 저장 시 I/O가 느릴 수 있음")
                    Text("- 메모리 사용을 효율적으로 관리해야 함")
                }
                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text("장점")
                        .fontWeight(.bold)
                    Text("- 간단한 데이터를 저장하기에 용이")
                    Text("- 데이터를 메모리에 즉시 로드하여 빠른 접근 가능")
                    Text("단점")
                        .fontWeight(.bold)
                    Text("- 대용량 데이터를 저장하기에 적합하지 않음")
                    Text("- 메모리 사용량이 증가하지 않는 범위 내에서만 사용해야 함")
                }
            }
        }
        .padding()
    }
}

struct CacheComparisonView_Previews: PreviewProvider {
    static var previews: some View {
        CacheComparisonView()
    }
}
