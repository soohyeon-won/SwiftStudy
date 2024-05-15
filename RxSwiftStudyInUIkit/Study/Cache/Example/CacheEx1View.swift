//
//  CacheEx1View.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 5/15/24.
//

import SwiftUI

struct CacheBlockView: View {
    var label: String
    var color: Color
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(color)
                .frame(width: 50, height: 50)
            Text(label)
        }
    }
}

struct CacheEx1View: View {
    
    var body: some View {
        ScrollView {
            LRUCacheView()
            FIFOCacheView()
            LFUCacheView()
            ARCCacheView()
        }
    }
}

struct LRUCacheView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Least Recently Used (LRU)")
                .font(.title)
                .fontWeight(.bold)
            
            Text("LRU 캐시 전략은 최근에 사용된 데이터가 캐시에서 더 오래된 데이터보다 높은 우선순위를 갖습니다. 이를 통해 최근에 더 자주 액세스되는 데이터가 캐시에 유지됩니다.\n데이터가 캐시에 추가될 때마다, 캐시는 최대 크기를 유지하기 위해 가장 오래된 데이터를 제거합니다.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 20) {
                CacheBlockView(label: "최근 사용된", color: .blue)
                
                VStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 50, height: 50)
                    Text("가장 오래된")
                }
            }
            
            Text("""
                 장점: 자주 사용하는 데이터를 유지하고, 오래된 데이터를 제거하여 효율적인 메모리 사용.
                 단점: 특정 패턴에서는 비효율적일 수 있음 (예: 자주 사용하는 데이터가 주기적으로 변경되는 경우).
                """)
            .font(.subheadline)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct FIFOCacheView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("First In, First Out (FIFO)")
                .font(.title)
                .fontWeight(.bold)
            
            Text("FIFO 캐시 전략은 데이터가 캐시에 추가된 순서대로 제거됩니다. 가장 오래된 데이터가 먼저 제거되는 방식입니다.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 20) {
                CacheBlockView(label: "최초 추가된", color: .green)
                
                VStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 50, height: 50)
                    Text("가장 오래된")
                }
            }
            
            Text("""
                 장점: 구현이 간단하며 순차적 데이터 처리에 유용.
                 단점: 최근에 사용된 데이터가 쉽게 제거될 수 있음.
                """)
            .font(.subheadline)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct LFUCacheView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Least Frequently Used (LFU)")
                .font(.title)
                .fontWeight(.bold)
            
            Text("LFU 캐시 전략은 가장 적게 액세스된 데이터가 우선적으로 제거됩니다. 자주 액세스되는 데이터가 캐시에 더 오래 유지됩니다.\n캐시는 최대 크기를 유지하기 위해 가장 적게 액세스된 데이터를 제거합니다")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 20) {
                CacheBlockView(label: "자주 사용된", color: .pink)
                
                VStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 50, height: 50)
                    Text("가장 적게\n액세스된")
                }
            }
            
            Text("""
                장점: 자주 사용되는 데이터를 오래 유지.
                단점: 데이터 접근 패턴이 갑작스럽게 변할 때 비효율적.
                """)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct ARCCacheView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Adaptive Replacement Cache (ARC)")
                .font(.title)
                .fontWeight(.bold)
            
            Text("ARC 캐시 전략은 LRU와 LFU를 혼합한 전략입니다. 시스템의 동작 패턴에 따라 적응적으로 캐시 전략을 조절합니다.\n데이터가 캐시에 추가될 때마다, 캐시는 최대 크기를 유지하기 위해 적게 액세스된 데이터나 최근에 사용하지 않은 데이터를 제거합니다.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 20) {
                VStack {
                    CacheBlockView(label: "자주 사용된", color: .pink)
                    CacheBlockView(label: "최근 사용된", color: .blue)
                }
                
                VStack {
                    CacheBlockView(label: "가장 적게 액세스된", color: .gray)
                    CacheBlockView(label: "가장 오래된", color: .gray)
                }
            }
            
            Text("""
                장점: LRU와 LFU의 장점을 결합하여 더 나은 성능 제공.
                단점: 복잡한 구현과 더 높은 메모리 오버헤드
                """)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}


struct CacheEx1View_Previews: PreviewProvider {
    static var previews: some View {
        CacheEx1View()
    }
}
