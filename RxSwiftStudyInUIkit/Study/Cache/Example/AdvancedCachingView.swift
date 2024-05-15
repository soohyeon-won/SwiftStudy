//
//  AdvancedCachingView.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 5/15/24.
//
import SwiftUI

struct AdvancedCachingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("캐싱 전략 및 고급 기능")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("NSCache는 LRU(Least Recently Used)와 유사한 자동 캐싱 전략을 사용합니다.\n즉, 메모리가 부족할 때 최근에 사용되지 않은 객체를 우선적으로 제거하여 메모리를 확보합니다. 이는 시스템 메모리 상태와 캐시 설정에 따라 동적으로 이루어지며, 개발자가 직접 제어할 수 없는 부분입니다. 개발자는 NSCache의 설정을 통해 캐시 제한을 관리할 수 있으며, 시스템이 필요에 따라 캐시를 자동으로 관리합니다.")
                
                CacheInvalidationSectionView()
                DiskCachingSectionView()
                CodableDiskCachingSectionView()
                
                CacheEx2View()
            }
            .padding()
        }
    }
}

struct CacheInvalidationSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("1. 캐시 무효화 전략 (캐시 비우기)")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("캐시 무효화는 캐시된 데이터가 오래되거나 유효하지 않을 때 캐시를 비우는 과정을 말합니다. 무효화 전략에는 타임스탬프를 사용한 시간 기반 무효화, 특정 이벤트 기반 무효화 등이 있습니다.")
            
            Text("예제:")
                .font(.subheadline)
                .fontWeight(.bold)
            
            CodeView(code: """
            class CacheWithInvalidation {
                private var cache = NSCache<NSString, CacheItem>()
                
                func setObject(_ object: AnyObject, forKey key: NSString, expiry: TimeInterval) {
                    let item = CacheItem(object: object, expiryDate: Date().addingTimeInterval(expiry))
                    cache.setObject(item, forKey: key)
                }
                
                func object(forKey key: NSString) -> AnyObject? {
                    guard let item = cache.object(forKey: key), item.expiryDate > Date() else {
                        cache.removeObject(forKey: key)
                        return nil
                    }
                    return item.object
                }
            }

            class CacheItem {
                let object: AnyObject
                let expiryDate: Date
                
                init(object: AnyObject, expiryDate: Date) {
                    self.object = object
                    self.expiryDate = expiryDate
                }
            }
            """)
        }
    }
}

struct DiskCachingSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("2. 캐싱된 데이터의 지속성 (디스크 캐싱)")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("NSCache는 메모리 내에서만 데이터를 유지하지만, 데이터를 디스크에 저장하여 앱이 재기동되더라도 데이터를 유지할 수 있습니다.")
            
            Text("예제:")
                .font(.subheadline)
                .fontWeight(.bold)
            
            CodeView(code: """
            func saveToDisk(data: Data, forKey key: String) {
                let fileURL = getFileURL(forKey: key)
                try? data.write(to: fileURL)
            }
            
            func loadFromDisk(forKey key: String) -> Data? {
                let fileURL = getFileURL(forKey: key)
                return try? Data(contentsOf: fileURL)
            }
            
            func getFileURL(forKey key: String) -> URL {
                let fileManager = FileManager.default
                let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
                return directory.appendingPathComponent(key)
            }
            """)
        }
    }
}

struct CodableDiskCachingSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("3. Codable 프로토콜과 디스크 캐싱")
                .font(.headline)
                .fontWeight(.bold)
            
            Text("Codable 프로토콜을 사용하여 데이터를 인코딩하고 디스크에 저장할 수 있습니다. 이는 JSON 데이터나 사용자 정의 객체를 저장하는 데 유용합니다.")
            
            Text("예제:")
                .font(.subheadline)
                .fontWeight(.bold)
            
            CodeView(code: """
            struct User: Codable {
                let id: Int
                let name: String
            }

            func saveUserToDisk(user: User, forKey key: String) {
                let encoder = JSONEncoder()
                if let encodedData = try? encoder.encode(user) {
                    saveToDisk(data: encodedData, forKey: key)
                }
            }
            
            func loadUserFromDisk(forKey key: String) -> User? {
                guard let data = loadFromDisk(forKey: key) else { return nil }
                let decoder = JSONDecoder()
                return try? decoder.decode(User.self, from: data)
            }
            
            // 재사용을 위해 saveToDisk와 loadFromDisk 함수는 위의 DiskCachingSectionView에서 가져옵니다.
            """)
        }
    }
}

struct AdvancedCachingView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCachingView()
    }
}

struct CacheEx2View: View {
    
    @State var cacheUserName: String = "empty"
    
    var body: some View {
        Button {
            let user = CacheUser(id: 0, name: "testName")
            CacheManager.shared.saveUserToDisk(user: user, forKey: "CacheUser")
        } label: {
            Text("캐시 저장")
        }
        
        Button {
            let user = CacheManager.shared.loadUserFromDisk(forKey: "CacheUser")
            cacheUserName = user?.name ?? "load fail (nil)"
        } label: {
            Text("디스크에서 가져오기")
        }
        
        Text(cacheUserName)
        
        Button {
            CacheManager.shared.removeAllCache()
            cacheUserName = "cache cleared"
        } label: {
            Text("캐시 무효화")
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct CacheUser: Codable {
    var id: Int
    var name: String
}

struct CacheManager {
    
    static let shared: CacheManager = .init()
    
    private init() { }
    
    func saveUserToDisk(user: CacheUser, forKey key: String) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(user) {
            saveToDisk(data: encodedData, forKey: key)
        }
    }

    func loadUserFromDisk(forKey key: String) -> CacheUser? {
        guard let data = loadFromDisk(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(CacheUser.self, from: data)
    }
    
    func removeAllCache() {
        let fileManager = FileManager.default
        if let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            do {
                let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: [])
                for fileURL in fileURLs {
                    try fileManager.removeItem(at: fileURL)
                }
                print("All cache files removed")
            } catch {
                print("Could not clear cache: \(error)")
            }
        }
    }
    
    private func saveToDisk(data: Data, forKey key: String) {
        let fileURL = getFileURL(forKey: key)
        try? data.write(to: fileURL)
    }
    
    private func loadFromDisk(forKey key: String) -> Data? {
        let fileURL = getFileURL(forKey: key)
        return try? Data(contentsOf: fileURL)
    }
    
    private func getFileURL(forKey key: String) -> URL {
        let fileManager = FileManager.default
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent(key)
    }
}
